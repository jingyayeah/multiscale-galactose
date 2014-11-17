'''
Here the actual ode integration is performed for the given simulations.

@author: Matthias Koenig
@date: 2014-07-11
'''
import sys
import os
import time
import traceback
from subprocess import call
import shlex

import numpy
import roadrunner

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

def storeTimecourseResults(sim, tc_file):
    f = open(tc_file, 'r')
    myfile = File(f)
    tc, _ = Timecourse.objects.get_or_create(simulation=sim)
    tc.file = myfile
    tc.save()
    # zip the file
    tc.zip()
    # convert to Rdata
    tc.rdata()
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
            
def integrate(sims, integrator):
    ''' Run ODE integration for the simulation. '''        
    if (integrator == COPASI):
        integrate_copasi(sims);
    elif (integrator == ROADRUNNER):
        integrate_roadrunner(sims);

def integrate_copasi(sims):
    ''' Integrate simulations with Copasi. 
        TODO: this is not up to date and probably not working currently.
    '''
    sbml_file = str(sims[0].task.sbml_model.file.path)
    sbml_id = sims[0].task.sbml_model.sbml_id
    for sim in sims:  
        try:
            sim.time_assign = timezone.now() # correction due to bulk assignment
            config_file = storeConfigFile(sim, SIM_DIR)
            tc_file = "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_copasi.csv'])

            # run an operating system command
            # call(["ls", "-l"])
            call_command = COPASI_EXEC + " -s " + sbml_file + " -c " + config_file + " -t " + tc_file;
            print call_command
            call(shlex.split(call_command))
                
            storeTimecourseResults(sim, tc_file)
        except Exception:
            integration_exception(sim)
            
        
def integrate_roadrunner(sims):
    ''' Integrate simulations with RoadRunner.'''
    
    # read SBML
    try:
        sbml_file = str(sims[0].task.sbml_model.file.path)
        sbml_id = sims[0].task.sbml_model.sbml_id
        rr = roadrunner.RoadRunner(sbml_file)
    except RuntimeError:
        # reset the simulation status
        for sim in sims:
            sim.status = ERROR
            sim.save()
        raise
        
    # set the selection
    sel = ['time']
    sel += [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()]
    sel += [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] 
    sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]
    # For testing store the parameters (make sure that reset is working)
    # sel += rr.model.getGlobalParameterIds()
            
    rr.selections = sel
    header = ",".join(sel)

    # use the integration settings (adapt absTol to amounts)
    sdict = sims[0].task.integration.get_settings_dict()
    absTol = sdict['absTol'] * min(rr.model.getCompartmentVolumes())
    relTol = sdict['relTol']
    varSteps = sdict['varSteps']
    
    for sim in sims:
        try:
            # set all parameters in the model and store the changes for revert
            # tstart = time.clock()
            tstart_total = time.clock()
            sim.time_assign = timezone.now() # correction due to bulk assignment
            changes = dict()
            for p in sim.parameters.all():
                if (p.ptype == NONE_SBML_PARAMETER):
                    continue
                
                name = str(p.name) # handle unicode from db
                if (p.ptype == GLOBAL_PARAMETER):
                    pass
                elif (p.ptype == BOUNDERY_INIT):
                    name = "".join(['[', name, ']'])
                elif (p.ptype == FLOATING_INIT):
                    name = "".join(['init([', name, '])'])
                
                # now set the value for the correct name
                changes[name] = rr.model[name]
                rr.model[name] = p.value

            tstart_int = time.clock()
                        
            if varSteps:
                # variable step size integration 
                s = rr.simulate(sdict['tstart'], sdict['tend'], 
                    absolute=absTol, relative=relTol,
                    variableStep=True, stiff=True)
            else:
                # fixed steps
                s = rr.simulate(sdict['tstart'], sdict['tend'], steps=sdict['steps'],
                                absolute=absTol, 
                                relative=relTol,
                                variableStep=False, stiff=True)
            
            # print 'Integration Time:', (time.clock()- tstart_int)
            t_int = time.clock()- tstart_int
        
            # Store Timecourse Results
            tc_file = "".join([SIM_DIR, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_roadrunner.csv'])
            numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')

            # reset
            rr.reset()
            for key, value in changes.iteritems():
                rr.model[key] = value
                    
            storeTimecourseResults(sim, tc_file)
            print 'Time: [{:.1f}|{:.1f}]'.format( (time.clock()-tstart_total), t_int )
            
        except:
            integration_exception(sim)
    return rr
    
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
    sims = [Simulation.objects.filter(task__pk=5)[0], ]
    print '* Start integration *'
    integrate(sims, integrator=ROADRUNNER)
    # integrate(sims, simulator=COPASI)
    
    