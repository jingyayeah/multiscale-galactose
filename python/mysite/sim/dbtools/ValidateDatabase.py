'''
    Database tools for consistency checks and database cleaning in case
    things went wrong, for instance some simulations are hanging.
    This is the only class removing entries from the database.
    The Creator classes are the SimulationFactory.


    # TODO: Somehow the database has to be checked for consistency.
    # Perform db validation routines and cleanup on the database.
    TODO: 
    Check for timecourses which point to unassigned & assigned simulations
    and remove these files.    
    
    TODO: 
    validate the database content. Is everything consistent, are all the files
    accessible. Run control checks.
    
    TODO: remove temporary files which are not represented in the database, namely
        in the tmp_sim folder and the timecourse subfolder,
        cleaning the local content on the computers
    
    TODO: 
    remove hanging objects, i.e. parameters which are not used in any simulations
    
    TODO: setup cron jobs for backup of the database and the the general informaton.
    
    Created on Mar 25, 2014
    @author: Matthias Koenig
'''

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
from django.core.exceptions import ObjectDoesNotExist
from sim.models import Simulation, Timecourse, Parameter, UNASSIGNED, ASSIGNED, ERROR
from sim.models import Task

def unassignAssignedHangingSimulations(task=None, cutoff_minutes=10):
    unassignHangingSimulationsWithStatus(ASSIGNED, task, cutoff_minutes)
    
def unassignErrorHangingSimulations(task=None, cutoff_minutes=10):
    unassignHangingSimulationsWithStatus(ERROR, task, cutoff_minutes)
            
def unassignHangingSimulationsWithStatus(status, task=None, cutoff_minutes=10):
    if not task:
        sims = Simulation.objects.filter(status=status)
    else:
        sims = Simulation.objects.filter(task=task, status=status)
    for sim in sims:
        if (cutoff_minutes >= 0):
            if (sim._is_hanging(cutoff_minutes)):
                unassignSimulation(sim)
        else:
            unassignSimulation(sim)
            

def unassignAllSimulation():
    '''
    ! Be very careful ! Know what are you doing.
    '''
    for sim in Simulation.objects.all():
        unassignSimulation(sim);

def unassignSimulationsByPk(pks):
    '''
    Sometimes simulations finish but something went wrong writing the 
    files. 
    TODO: find BUG empty parameter files and simulations
    '''
    for pk in pks:
        sim = Simulation.objects.get(pk=pk)
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
    sim.time_sim = None
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
    # task = Task.objects.get(pk=1)
    # addDefaultDeficiencyToTaskSimulations(task)
    
    #-----------------------------------------------
    #     Unassign hanging simulations
    #-----------------------------------------------
    task = Task.objects.get(pk=1)
    unassignAssignedHangingSimulations(task=task, cutoff_minutes=-1);
    # unassignErrorHangingSimulations(cutoff_minutes=-1);
    
    #-----------------------------------------------
    #     Unassign simulations by pk
    #-----------------------------------------------
    #pks = (26985, )
    #print(pks)
    # unassignSimulationsByPk(pks)
    
    #-----------------------------------------------
    #     Remove tasks
    #-----------------------------------------------
    # TODO: implement
    
    #-----------------------------------------------
    #     Remove simulations for tasks
    #-----------------------------------------------
    # TODO: also clean the tmp files and local files after removing simulations
    #task_pks = (1, )
    #for pk in task_pks:
    #    task = Task.objects.get(pk=pk)
    #    removeSimulationsForTask(task)
    
    #-----------------------------------------------
    #     Unassign all simulations
    #-----------------------------------------------
    # ! CAREFUL - KNOW WHAT YOU ARE DOING !
    # unassignAllSimulation()
    