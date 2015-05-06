'''
Performs ode integration for given simulations.

@author: Matthias Koenig
@date: 2014-12-13
'''
import sys
import time
import traceback
from subprocess import call
import shlex

import roadrunner
from roadrunner import SelectionRecord

from django.utils import timezone

from project_settings import COPASI_EXEC, SIM_DIR, MULTISCALE_GALACTOSE_RESULTS
from sbmlsim.models import NONE_SBML_PARAMETER
from sbmlsim.models import ERROR, COPASI, ROADRUNNER
from sbmlsim.models import GLOBAL_PARAMETER, BOUNDERY_INIT, FLOATING_INIT

import odesim.integrate.ode_io as ode_io

            
def integrate(sims, integrator, keep_tmp=False):
    ''' Run ODE integration for the odesim. '''        
    if (integrator == COPASI):
        integrate_copasi(sims);
    elif (integrator == ROADRUNNER):
        integrate_roadrunner(sims, keep_tmp);

def integrate_copasi(sims):
    ''' Integrate simulations with Copasi. 
        TODO: Update to latest Copasi source & test.
        TODO: Use the python interface to solve the problem.
    '''
    sbml_file = str(sims[0].task.sbml_model.file.path)
    sbml_id = sims[0].task.sbml_model.sbml_id
    for sim in sims:  
        try:
            sim.time_assign = timezone.now()            # correction due to bulk assignment
            config_file = ode_io.storeConfigFile(sim, SIM_DIR) # create the copasi config file for settings & changes
            csv_file = "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_copasi.csv'])

            # run an operating system command
            # call(["ls", "-l"])
            call_command = COPASI_EXEC + " -s " + sbml_file + " -c " + config_file + " -t " + csv_file;
            print call_command
            call(shlex.split(call_command))
                
            ode_io.store_timecourse_db(sim, filepath=csv_file, 
                                       ftype=ode_io.FileType.CSV)
        except Exception:
            integration_exception(sim)
                    

def integrate_roadrunner(sims, keep_tmp=False):
    ''' Integrate simulations with RoadRunner.'''
    
    # read SBML
    try:
        sbml_file = str(sims[0].task.sbml_model.file.path)
        sbml_id = sims[0].task.sbml_model.sbml_id
        
        start = time.clock()
        rr = roadrunner.RoadRunner(sbml_file)
        print 'SBML load time :', (time.clock()- start)
        
    except RuntimeError:
        # reset odesim status
        for sim in sims:
            sim.status = ERROR
            sim.save()
        raise
    
    # set RoadRunner settings
    # roadrunner.Config.setValue(roadrunner.Config.OPTIMIZE_REACTION_RATE_SELECTION, True)
    roadrunner.Config.setValue(roadrunner.Config.PYTHON_ENABLE_NAMED_MATRIX, False)
    
    # set the selection
    sel = ['time'] \
        + [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()] \
        + [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] \
        + [item for item in rr.model.getReactionIds() if item.startswith('H')]
    rr.selections = sel

    # use the integration settings (adapt absTol to amounts)
    sdict = sims[0].task.integration.get_settings_dict()
    absTol = sdict['absTol'] * min(rr.model.getCompartmentVolumes())
    relTol = sdict['relTol']
    varSteps = sdict['varSteps']
    
    # make a concentration backup
    conc_backup = dict()
    # for sid in rr.model.getBoundarySpeciesIds():
    #    conc_backup[sid] = rr["[{}]".format(sid)]    
    for sid in rr.model.getFloatingSpeciesIds():
        conc_backup[sid] = rr["[{}]".format(sid)]
    
    for sim in sims:
        try:
            tstart_total = time.time()
            sim.time_assign = timezone.now() # correction due to bulk assignment
            
            # set all parameters in the model and store the changes for revert
            changes = dict()
            for p in sim.parameters.all():
                if (p.ptype == GLOBAL_PARAMETER):
                    name = str(p.name)
                    changes[name] = rr.model[name]
                    rr.model[name] = p.value
                    # print 'set', name, ' = ', p.value
            
            # recalculate the initial assignments
            rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
            
            # restore initial concentrations
            for key, value in conc_backup.iteritems():
                rr.model['[{}]'.format(key)] = value
            
            # apply concentration changes
            for p in sim.parameters.all():
                if (p.ptype in [NONE_SBML_PARAMETER, GLOBAL_PARAMETER]):
                    continue
                
                name = str(p.name) 
                if (p.ptype == BOUNDERY_INIT):
                    name = '[{}]'.format(name)
                elif (p.ptype == FLOATING_INIT):
                    name = 'init([{}])'.format(name)
                
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
            print "CSV: {}".format(tmp)
            
            # Store in HDF5
            h5_file = ode_io.hdf5_file(sbml_id, sim)
            tmp = time.time()
            ode_io.store_timecourse_hdf5(h5_file, data=s, header=sel)
            ode_io.store_timecourse_db(sim, filepath=h5_file, ftype=ode_io.FileType.HDF5)
            tmp = time.time() - tmp
            print "HDF5: {}".format(tmp)
            
            # reset parameter changes
            for key, value in changes.iteritems():
                rr.model[key] = value 
            rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
            
            # reset initial concentrations
            rr.reset()
            time_total = time.time()-tstart_total
            print 'Time: [{:.3f}|{:.3f} |{:.2f}]'.format(time_total, t_int, t_int/time_total*100 )
            
        except:
            integration_exception(sim)
    return rr

def write_model_items(r, filename):
    print filename
    f = open(filename, "w")
    rows = ["\t".join([data[0], str(data[1])] ) for data in r.model.items()]
    f.write("\n".join(rows))
    f.close()

def integration_exception(sim):
    ''' Handling exceptions in the integration. '''
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
    
    # tc = Timecourse.objects.get(simulation__pk=15624)
    # print tc.file.path
    # os.remove(tc.file.path)

    import django
    django.setup()
    
    from sbmlsim.models import Simulation
    # sim_ids = range(1,2)
    # sims = [Simulation.objects.get(pk=sid) for sid in sim_ids]
    
    # the folder for the simulations has to exist !
    sims = Simulation.objects.filter(task=2)
    
    print '* Start integration *'
    print 'Simulation: ', sims
    integrate(sims, integrator=ROADRUNNER, keep_tmp=True)
    # integrate(sims, simulator=COPASI)
    
    