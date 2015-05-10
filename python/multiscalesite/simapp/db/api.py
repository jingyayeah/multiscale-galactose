'''
Helper functions and tools to create objects in the database.

All interactions with the database should go via this module. 
No direct interactions with the database should occur



@author: Matthias Koenig
@date: 2015-05-10
'''
import logging
from django.core.exceptions import ObjectDoesNotExist

from simapp.models import Task, Simulation, Parameter

#===============================================================================
# Creators
#===============================================================================
def create_parameter(key, value, unit, parameter_type):
    p, _ = Parameter.objects.get_or_create(key=key, value=value, unit=unit, 
                                               parameter_type=parameter_type);
    return p

def create_simulation(task, parameters):
    """ Create simulation from given task and parameters. """
    sim = Simulation(task=task)
    sim.save()
    sim.parameters.add(*parameters)
    return sim

def create_task(model, method, info=None, priority=0):
    '''
    Task is uniquely identified via model, integration and information.
    Other fields have to be updated.
    '''
    try:
        # query via the unique combination
        task = Task.objects.get(model=model, method=method, info=info)
        task.priority = priority
    except ObjectDoesNotExist:
        task = Task(model=model, method=method, info=info, priority=priority)
    task.save()
    logging.info("Task created/updated: {}".model_format(task))    
    return task

#===============================================================================
# Getters
#===============================================================================



def set_priority_for_task(tid, priority):
    task = Task.objects.get(pk=tid)
    print task, task.pk, task.priority
    task.priority = priority
    task.save()
    

if __name__ == "__main__":
    import django
    django.setup()
    tid = 3
    set_priority_for_task(tid, priority=30)
    
    
    
    