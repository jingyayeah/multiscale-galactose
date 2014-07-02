'''
Here the actual ode integration is performed for the given simulations.

@author: mkoenig
@date: 2014-05-11
'''
import sys
import os
import time
import traceback
from subprocess import call
import shlex

from django.core.files import File
from ConfigFileFactory import create_config_file_in_folder

from django.utils import timezone
from sim.models import Timecourse
from sim.models import DONE, ERROR, COPASI, ROADRUNNER
from sim.models import GLOBAL_PARAMETER, BOUNDERY_INIT, FLOATING_INIT

from simulation.Simulator import SIM_FOLDER

import numpy
import roadrunner
from matplotlib.pyplot import step
COPASI_EXEC = "/home/mkoenig/multiscale-galactose/cpp/copasi/CopasiModelRunner/build/CopasiModelRunner"

def storeConfigFile(sim, folder):
    #Store the config file in the database
    config_file = create_config_file_in_folder(sim, folder)
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
    return config_file;

def storeTimecourseResults(sim, tc_file):
    # Store Timecourse Results
    f = open(tc_file, 'r')
    myfile = File(f)
    tc, created = Timecourse.objects.get_or_create(simulation=sim)
    tc.file = myfile
    tc.save();
    
    # simulation finished (update simulation information and save)
    sim.time_sim = timezone.now()
    sim.status = DONE
    sim.save()
            
def integrate(sims, simulator):
    ''' 
    Run ODE integration for the simulation. 
    Error handling is done via try/except 
    Cores are not hanging, but simulations are put into an ERROR state.
    Mainly problems if files are not available.
    '''
    directory = ''.join([SIM_FOLDER, "/", str(sims[0].task)])
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    if (simulator == COPASI):
        integrate_copasi(sims);
    elif (simulator == ROADRUNNER):
        integrate_roadrunner(sims);

def integration_exception(sim):
    '''
    Handling exceptions in the integration.
    TODO: proper file location.
    '''
    print "Exception in integration"
    print '-'*60
    fname = '/home/mkoenig/multiscale-galactose-results/ERROR_' + str(sim.pk) + '.log'
    print fname
    with open(fname, 'a') as f_err:
        traceback.print_exc(file=f_err)
    
    traceback.print_exc(file=sys.stdout)
    print '-'*60
    sim.status = ERROR
    sim.save()


def integrate_copasi(sims):
    ''' Integrate simulations with Copasi. '''
    sbml_file = str(sims[0].task.sbml_model.file.path)
    sbml_id = sims[0].task.sbml_model.sbml_id
    for sim in sims:  
        try:
            sim.time_assign = timezone.now() # correction due to bulk assignment
            config_file = storeConfigFile(sim, SIM_FOLDER)
            tc_file = "".join([SIM_FOLDER, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_copasi.csv'])

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
    sbml_file = str(sims[0].task.sbml_model.file.path)
    sbml_id = sims[0].task.sbml_model.sbml_id
    
    # read SBML
    rr = roadrunner.RoadRunner(sbml_file)
        
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
            tstart = time.clock()
            sim.time_assign = timezone.now() # correction due to bulk assignment
            changes = dict()
            for p in sim.parameters.all():
                name = p.name
                if (p.ptype == GLOBAL_PARAMETER):
                    pass
                elif (p.ptype == BOUNDERY_INIT):
                    name = "".join(['[', name, ']'])
                elif (p.ptype == FLOATING_INIT):
                    name = "".join(['init([', name, '])'])
                name = str(name)
                
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
            
            print 'Integration Time:', (time.clock()- tstart_int)
        
            # Store Timecourse Results
            tc_file = "".join([SIM_FOLDER, "/", str(sim.task), '/', sbml_id, "_Sim", str(sim.pk), '_roadrunner.csv'])
            numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')

            # reset
            rr.reset()
            for key, value in changes.iteritems():
                rr.model[key] = value
                    
            storeTimecourseResults(sim, tc_file)
            # print 'Full Time:', (time.clock()-tstart)
            
        except Exception:
            integration_exception(sim)
    

if __name__ == "__main__":
    from sim.models import Simulation
    
    sims = [Simulation.objects.filter(task__pk=1)[0], ]
    integrate(sims, simulator=ROADRUNNER)
    integrate(sims, simulator=COPASI)