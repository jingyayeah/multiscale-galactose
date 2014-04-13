'''
Created on Mar 25, 2014

@author: Matthias Koenig
    Database tools for consistency checks and database cleaning in case
    things went wrong, for instance some simulations are hanging.

    # TODO: Somehow the database has to be checked for consistency.
    # Perform db validation routines and cleanup on the database.

    TODO: 
    Check for timecourses which point to unassigned & assigned simulations
    and remove these files.    
    
    TODO: 
    validate the database content. Is everything consistent, are all the files
    accessible. Run control checks.
    
    TODO: 
    clean cores which did not listen for some time.
'''

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
from django.core.exceptions import ObjectDoesNotExist
from sim.models import Simulation, Timecourse, Parameter, UNASSIGNED, ASSIGNED
from sim.models import Task

def handleHangingAssignedSimulations(cutoff_minutes=10):
    '''
    Looks for unfinished simulations, i.e. they were assigned, but
    never finished. The simulations are reset to the UNASSIGNED status.
    And the necessary database updates are made.
    '''
    # get all assigned simulations
    assigned = Simulation.objects.filter(status=ASSIGNED)
    for sim in assigned:
        if (sim._is_hanging(cutoff_minutes)):
            unassignSimulation(sim)

def unassignAllSimulation():
    '''
    ! Be very careful ! Know what are you doing.
    '''
    for sim in Simulation.objects.all():
        unassignSimulation(sim);

def unassignSimulation(sim):
    '''
    Removes the corresponding Timecourse if exists and resets the
    Simulation to unassigned.
    '''
    # remove the timecourse if exists
    try:
        tc = Timecourse.objects.get(simulation=sim)
        # TODO: delete the coresponding local file
        tc.delete();
        print "Timecourse for simulation removed"
    except ObjectDoesNotExist:
        print "No timecourse for simulation available."
    
    # reset the simulation
    sim.status = UNASSIGNED
    sim.core = None
    sim.file = None
    sim.time_assign = None
    sim.save();
    print "Simulation reset: ", sim
    
def addDefaultParametersToTaskSimulations(task, pars):
    '''
    The simulations within a task should have the same minimal number of parameters set. 
    '''
    print pars
    
    # get the simulations
    for sim in task.simulation_set.all():

        # get parameter collection
        pc = sim.parameters;
        
        for data in pars:
            name, value, unit = data
            # get the Parameter
            p, tmp = Parameter.objects.get_or_create(name=name, value=value, unit=unit);
            
            if (pc.parameters.filter(name=name).exists()):
                continue
            else:
                print '-'*20
                print sim.pk
                print '-'*20
                print "Add parameter: ", name
                pc.parameters.add(p)
                pc.save();
                for ptmp in pc.parameters.all():
                    print ptmp


def addDefaultDeficiencyToTaskSimulations(task):
    pars = [('deficiency', 0, '-')]
    addDefaultParametersToTaskSimulations(task, pars)
    
def removeSimulationsForTask(task):
    '''
    Removes all simulations associated with a task.
    No cleaning of dependent database objects is perfomed.
    TODO: clean the timecourses and other model components
        which depend on the simulations.
    '''
    sims = Simulation.objects.filter(task=task);
    for sim in sims:
        print "remove Simulation: ", sim.pk
        sim.delete()
    
    
if __name__ == "__main__":
    pass
    # task = Task.objects.get(pk=1)
    # addDefaultDeficiencyToTaskSimulations(task)
    # handleHangingAssignedSimulations();
    
    
    # Remove simulations for task
    # task = Task.objects.get(pk=3)
    # removeSimulationsForTask(task)
    
    
    # ! CAREFUL !
    # unassignAllSimulation()
    
    # ! CAREFUL !
    # unassignAllSimulation()
    
    