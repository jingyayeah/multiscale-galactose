'''
Performs ode integration for given simulations.

@author: Matthias Koenig
@date: 2014-12-13
'''
import sys
import os
import time
import traceback
from subprocess import call
import shlex

import numpy
import roadrunner
from roadrunner import SelectionRecord

from django.core.files import File
from django.utils import timezone

from sim.PathSettings import COPASI_EXEC, SIM_DIR, MULTISCALE_GALACTOSE_RESULTS
from sim.models import Timecourse, NONE_SBML_PARAMETER
from sim.models import DONE, ERROR, COPASI, ROADRUNNER
from sim.models import GLOBAL_PARAMETER, BOUNDERY_INIT, FLOATING_INIT

import config_files

def storeConfigFile(sim, folder):
    ''' Store the config file in the database. '''
    fname = config_files.create_config_filename(sim, folder)
    config_file = config_files.create_config_file_for_simulation(sim, fname)
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
    return config_file;

def storeTimecourseResults(sim, tc_file, keep_tmp=False):
    ''' This takes quit long. '''
    f = open(tc_file, 'r')
    myfile = File(f)
    tc, _ = Timecourse.objects.get_or_create(simulation=sim)
    tc.file = myfile
    tc.save()
    # zip the file
    tc.zip()
    # convert to Rdata
    tc.rdata()
    if (keep_tmp==False):
        # remove the original csv file now
        myfile.close()
        f.close()
        os.remove(tc_file)
    # remove the db csv (only compressed file kept)
    os.remove(tc.file.path)
     
    # simulation finished (update simulation status)
    sim.time_sim = timezone.now()
    sim.status = DONE
    sim.save()
            
def integrate(sims, integrator, keep_tmp=False):
    ''' Run ODE integration for the simulation. '''        
    if (integrator == COPASI):
        integrate_copasi(sims);
    elif (integrator == ROADRUNNER):
        integrate_roadrunner(sims, keep_tmp);

def integrate_copasi(sims):
    ''' Integrate simulations with Copasi. 
        TODO: Update to latest Copasi source & test
    '''
    sbml_file = str(sims[0].task.sbml_model.file.path)
    sbml_id = sims[0].task.sbml_model.sbml_id
    for sim in sims:  
        try:
            sim.time_assign = timezone.now()            # correction due to bulk assignment
            config_file = storeConfigFile(sim, SIM_DIR) # create the copasi config file for settings & changes
            tc_file = "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_copasi.csv'])

            # run an operating system command
            # call(["ls", "-l"])
            call_command = COPASI_EXEC + " -s " + sbml_file + " -c " + config_file + " -t " + tc_file;
            print call_command
            call(shlex.split(call_command))
                
            storeTimecourseResults(sim, tc_file)
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
        # reset simulation status
        for sim in sims:
            sim.status = ERROR
            sim.save()
        raise
    
    # set RoadRunner settings
    # roadrunner.Config.setValue(roadrunner.Config.OPTIMIZE_REACTION_RATE_SELECTION, True)
    roadrunner.Config.setValue(roadrunner.Config.PYTHON_ENABLE_NAMED_MATRIX, False)
    print roadrunner.Config.PYTHON_ENABLE_NAMED_MATRIX
    print '*' * 80
    print rr.getInfo()
    print '*' * 80
    
    # get changed parameters in SBML
    # pars = sims[0].parameters.all()
    # pnames = [str(p.name) for p in pars if p.ptype == GLOBAL_PARAMETER] \
    #           + ["".join(['[', str(p.name), ']']) for p in pars if p.ptype == BOUNDERY_INIT] \
    #           + ["".join(['init([', str(p.name), '])']) for p in pars if p.ptype == FLOATING_INIT]
    # print pnames
    
    # set the selection
    sel = ['time'] \
        + [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()] \
        + [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] \
        + [item for item in rr.model.getReactionIds() if item.startswith('H')]
    
    rr.selections = sel
    header = ",".join(sel)

    # use the integration settings (adapt absTol to amounts)
    sdict = sims[0].task.integration.get_settings_dict()
    absTol = sdict['absTol'] * min(rr.model.getCompartmentVolumes())
    relTol = sdict['relTol']
    varSteps = sdict['varSteps']
    
    # make a concentration backup
    conc_backup = dict()
    for sid in rr.model.getBoundarySpeciesIds():
        conc_backup[sid] = rr["[{}]".format(id)]    
    for sid in rr.model.getFloatingSpeciesIds():
        conc_backup[sid] = rr["[{}]".format(id)]
    
    for sim in sims:
        try:
            # set all parameters in the model and store the changes for revert
            # tstart = time.clock()
            tstart_total = time.clock()
            sim.time_assign = timezone.now() # correction due to bulk assignment
            changes = dict()
            
            # apply parameter changes
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
                            
            # store the items before integration
            # items_file = "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_items.csv'])
            # write_model_items(rr, items_file)
            
            # perform integration
            tstart_int = time.clock()          
            if varSteps:
                # variable step size integration 
                s = rr.simulate(sdict['tstart'], sdict['tend'], 
                    absolute=absTol, relative=relTol,
                    variableStep=True, stiff=True)
            else:
                # fixed steps
                s = rr.simulate(sdict['tstart'], sdict['tend'], steps=sdict['steps'],
                    absolute=absTol, relative=relTol,
                    variableStep=False, stiff=True)
            t_int = time.clock()- tstart_int
        
            # Store Timecourse Results
            tc_file = "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_roadrunner.csv'])
            numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')
            storeTimecourseResults(sim, tc_file, keep_tmp=keep_tmp)

            # reset parameter changes
            for key, value in changes.iteritems():
                rr.model[key] = value 
            rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
            # reset initial concentrations
            rr.reset()
              
            print 'Time: [{:.1f}|{:.1f}]'.format( (time.clock()-tstart_total), t_int )
            
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
    # update simulation status
    sim.status = ERROR
    sim.save()
    


if __name__ == "__main__":
    
    # tc = Timecourse.objects.get(simulation__pk=15624)
    # print tc.file.path
    # os.remove(tc.file.path)

    from sim.models import Simulation
    # sims = [Simulation.objects.filter(task__pk=6)[0], ]
    sims = [Simulation.objects.get(pk=10000), ]
    print '* Start integration *'
    print 'Simulation: ', sims
    integrate(sims, integrator=ROADRUNNER, keep_tmp=True)
    # integrate(sims, simulator=COPASI)
    
    