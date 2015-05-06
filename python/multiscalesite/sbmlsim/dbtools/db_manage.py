'''
    Database tools for consistency checks and database cleanup, 
    for instance some simulations are hanging.
    This is the only module removing entries from the database.

    TODO: implement database integrity checks. Are all the files
    accessible. Run control checks.
    
    TODO: Check for timecourses associated with unassigned & assigned simulations
        and remove these files.
    
    TODO: remove hanging objects, i.e. parameters which are not used in any simulations    
    
    TODO: remove temporary files which are not represented in the database, namely
        in the tmp_sim folder and the timecourse subfolder.
     
    TODO: setup cron jobs for database backup
    
    @author: Matthias Koenig
    @date: 2015-05-05
'''

from django.core.exceptions import ObjectDoesNotExist
from sbmlsim.models import Simulation, Timecourse
from sbmlsim.models import UNASSIGNED, ASSIGNED, ERROR


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
    ''' ! Be very careful ! Know what are you doing. '''
    for sim in Simulation.objects.all():
        unassignSimulation(sim);

def unassignSimulationsByIP(ip):
    for sim in Simulation.objects.filter(core__ip=ip):
        unassignSimulation(sim);

def unassignSimulationsByPk(pks):
    for pk in pks:
        sim = Simulation.objects.get(pk=pk)
        unassignSimulation(sim);

def unassignSimulation(sim):
    ''' Unassigns the given simulation.
        Removes the corresponding Timecourse if existing.
    '''
    delete_timecourse_for_simulation(sim)    
    # reset simulation
    sim.status = UNASSIGNED
    sim.core = None
    sim.file = None
    sim.time_assign = None
    sim.time_sim = None
    sim.save();
    print "Simulation reset: ", sim

def delete_task(task):
    ''' Deletes task and the simulations associated with the task. '''
    delete_simulations_for_task(task)
    task.delete()

def delete_simulations_for_task(task):
    ''' Deletes all simulations associated with a task. '''
    sims = Simulation.objects.filter(task=task);
    for sim in sims:
        print "remove Simulation: ", sim.pk
        delete_timecourse_for_simulation(sim)
        sim.delete()
        
def delete_timecourse_for_simulation(sim):
    try:
        tc = Timecourse.objects.get(simulation=sim)
        # TODO: delete the corresponding local file
        tc.delete();
    except ObjectDoesNotExist:
        pass

#####################################################################################################
if __name__ == "__main__":
    import django
    django.setup()
    #-----------------------------------------------
    #     Unassign hanging simulations
    #-----------------------------------------------
    # task = Task.objects.get(pk=37)
    # print task
    # unassignAssignedHangingSimulations(task=task, cutoff_minutes=-1);
    # unassignAssignedHangingSimulations(task=None, cutoff_minutes=-1);
    # unassignErrorHangingSimulations(task=None, cutoff_minutes=-1);
    # unassignErrorHangingSimulations(cutoff_minutes=-1);
    
    #-----------------------------------------------
    #     Unassign by computer
    #-----------------------------------------------
    # unassignSimulationsByIP(ip='10.39.32.106')
    
    
    #-----------------------------------------------
    #     Unassign simulations by pk
    #-----------------------------------------------
    #pks = (26985, )
    #print(pks)
    # unassignSimulationsByPk(pks)
    
    #-----------------------------------------------
    #     Remove tasks
    #-----------------------------------------------
    # task = Task.objects.get(pk=1)
    # delete_task(task)
    
    #-----------------------------------------------
    #     Remove simulations for tasks
    #-----------------------------------------------
    # task_pks = (3,)
    # for pk in task_pks:
    #    task = Task.objects.get(pk=pk)
    #    removeSimulationsForTask(task)
    
    #-----------------------------------------------
    #     Unassign all simulations
    #-----------------------------------------------
    # ! CAREFUL - KNOW WHAT YOU ARE DOING !
    # unassignAllSimulation()
    