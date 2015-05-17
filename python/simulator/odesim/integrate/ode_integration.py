"""
Perform ode integration.
Can use different simulation backends like RoadRunner or COPASI.

"""
import sys
import time
import traceback
from subprocess import call
import shlex

import roadrunner
from roadrunner import SelectionRecord
from django.utils import timezone

from project_settings import COPASI_EXEC, SIM_DIR, MULTISCALE_GALACTOSE_RESULTS
from simapp.models import SimulatorType, SimulationStatus, ParameterType
import odesim.integrate.ode_io as ode_io

class IntegrationException(Exception):
    pass


def integrate(simulations, integrator, keep_tmp=False):
    """ Perform the ODE simulation based on the given ode solvers.
        Switches to the respective subcode for the individual solvers.
    """
    if integrator == SimulatorType.COPASI:
        integrate_copasi(simulations)
    elif integrator == SimulatorType.ROADRUNNER:
        integrate_roadrunner(simulations, keep_tmp)
    else:
        raise IntegrationException('Integrator not supported: {}'.format(integrator))


def integrate_copasi(simulations):
    """ Integrate simulations with Copasi. """
    # TODO: Update to latest Copasi source & test.
    # TODO: Use the python interface to solve the problem.
    task = simulations[0].task

    filepath = task.model.filepath
    model_id = task.model.model_id
    for sim in simulations:
        try:
            sim.time_assign = timezone.now()                      # correction due to bulk assignment
            config_file = ode_io.store_config_file(sim, SIM_DIR)  # create the copasi config file for settings & changes
            csv_file = "".join([SIM_DIR, "/", str(sim.task), '/', model_id, "_Sim", str(sim.pk), '_copasi.csv'])

            # run an operating system command
            # call(["ls", "-l"])
            call_command = COPASI_EXEC + " -s " + filepath + " -c " + config_file + " -t " + csv_file
            print call_command
            call(shlex.split(call_command))
                
            ode_io.store_timecourse_db(sim, filepath=csv_file, 
                                       ftype=ode_io.FileType.CSV)
        except Exception:
            integration_exception(sim)
                    

def integrate_roadrunner(sims, keep_tmp=False):
    """ Integrate simulations with RoadRunner. """
    try:
        # read SBML
        time_start = time.time()
        comp_model = sims[0].task.model
        sbml_id = comp_model.model_id
        rr = roadrunner.RoadRunner(comp_model.filepath)
        print 'Model load time :{}'.format(time.time() - time_start)
        
    except RuntimeError:
        for sim in sims:
            sim.status = SimulationStatus.ERROR
            sim.save()
        raise
    
    # set RoadRunner settings
    # TODO: what are these settings
    # roadrunner.Config.setValue(roadrunner.Config.OPTIMIZE_REACTION_RATE_SELECTION, True)
    roadrunner.Config.setValue(roadrunner.Config.PYTHON_ENABLE_NAMED_MATRIX, False)
    
    # set the selection
    sel = ['time'] \
        + ["".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()] \
        + ["".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] \
        + [item for item in rr.model.getReactionIds() if item.startswith('H')]
    rr.selections = sel

    # use the integration settings (adapt absTol to amounts)
    sdict = sims[0].task.method.get_settings_dict()
    absTol = sdict['absTol'] * min(rr.model.getCompartmentVolumes())
    relTol = sdict['relTol']
    varSteps = sdict['varSteps']
    
    # make a concentration backup
    conc_backup = dict()
    # for sid in rr.model.getBoundarySpeciesIds():
    #    conc_backup[sid] = rr["[{}]".format(sid)]    
    for sid in rr.model.getFloatingSpeciesIds():
        conc_backup[sid] = rr["[{}]".model_format(sid)]
    
    for sim in sims:
        try:
            tstart_total = time.time()
            sim.time_assign = timezone.now() # correction due to bulk assignment
            
            # set all parameters in the model and store the changes for revert
            changes = dict()
            for p in sim.parameters.all():
                if (p.parameter_type == GLOBAL_PARAMETER):
                    name = str(p.key)
                    changes[name] = rr.model[name]
                    rr.model[name] = p.value
                    # print 'set', name, ' = ', p.value
            
            # recalculate the initial assignments
            rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
            
            # restore initial concentrations
            for key, value in conc_backup.iteritems():
                rr.model['[{}]'.model_format(key)] = value
            
            # apply concentration changes
            for p in sim.parameters.all():
                if (p.parameter_type in [NONE_SBML_PARAMETER, GLOBAL_PARAMETER]):
                    continue
                
                name = str(p.key) 
                if (p.parameter_type == BOUNDERY_INIT):
                    name = '[{}]'.model_format(name)
                elif (p.parameter_type == FLOATING_INIT):
                    name = 'init([{}])'.model_format(name)
                
                changes[name] = rr.model[name]
                rr.model[name] = p.value
                # print 'set', name, ' = ', p.value
                            
            # ode integration
            tstart_int = time.time()          
            if varSteps:    # variable step size integration 
                s = rr.simulate(sdict['tstart'], sdict['tend'], 
                    absolute=absTol, relative=relTol,
                    variableStep=True, stiff=True)
            else:           # fixed steps
                s = rr.simulate(sdict['tstart'], sdict['tend'], steps=sdict['steps'],
                    absolute=absTol, relative=relTol,
                    variableStep=False, stiff=True)
            t_int = time.time()- tstart_int
        
            # Store CSV
            csv_file = ode_io.csv_file(sbml_id, sim)
            tmp = time.time()
            ode_io.store_timecourse_csv(csv_file, data=s, header=sel)
            ode_io.store_timecourse_db(sim, filepath=csv_file, ftype=ode_io.FileType.CSV, keep_tmp=True)
            tmp = time.time() - tmp
            print "CSV: {}".model_format(tmp)
            
            # Store in HDF5
            h5_file = ode_io.hdf5_file(sbml_id, sim)
            tmp = time.time()
            ode_io.store_timecourse_hdf5(h5_file, data=s, header=sel)
            ode_io.store_timecourse_db(sim, filepath=h5_file, ftype=ode_io.FileType.HDF5)
            tmp = time.time() - tmp
            print "HDF5: {}".model_format(tmp)
            
            # reset parameter changes
            for key, value in changes.iteritems():
                rr.model[key] = value 
            rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
            
            # reset initial concentrations
            rr.reset()
            time_total = time.time()-tstart_total
            print 'Time: [{:.3f}|{:.3f} |{:.2f}]'.model_format(time_total, t_int, t_int/time_total*100 )
            
        except:
            integration_exception(sim)
    return rr


def write_model_items(r, filename):
    print filename
    f = open(filename, "w")
    rows = ["\t".join([data[0], str(data[1])]) for data in r.model.items()]
    f.write("\n".join(rows))
    f.close()


def integration_exception(sim):
    """ Handling exceptions in the integration. """
    # print information
    print '-' *60
    print '*** Exception in ODE integration ***'
    fname = MULTISCALE_GALACTOSE_RESULTS + '/ERROR_' + str(sim.pk) + '.log'
    with open(fname, 'a') as f_err:
        traceback.print_exc(file=f_err)
    traceback.print_exc(file=sys.stdout)
    print '-'*60
    # update odesim status
    sim.status = ERROR
    sim.save()
    

if __name__ == "__main__":
    import django
    django.setup()
    
    from simapp.models import Simulation
    # sim_ids = range(1,2)
    # sims = [Simulation.objects.get(pk=sid) for sid in sim_ids]
    
    # the folder for the simulations has to exist !
    sims = Simulation.objects.filter(task=2)
    
    print '* Start integration *'
    print 'Simulation: ', sims
    integrate(sims, integrator=SimulatorType.ROADRUNNER)
    # integrate(sims, simulator=COPASI)
