"""
Helper functions and tools to create objects in the database.

All interactions with the database should go via this module.
No direct interactions with the database should occur

@author: Matthias Koenig
@date: 2015-05-10
"""
import logging
from django.core.exceptions import ObjectDoesNotExist

from simapp.models import Task, Simulation, Parameter

# ===============================================================================
# Creators
# ===============================================================================


def create_parameter(key, value, unit, parameter_type):
    """
    Create models.Parameter from given information.
    :param key:
    :param value:
    :param unit:
    :param parameter_type:
    :return: models.Parameter
    """
    p, _ = Parameter.objects.get_or_create(key=key, value=value, unit=unit, parameter_type=parameter_type)
    logging.info("Parameter created/updated: {}".format(p))
    return p


def create_task(model, method, info=None, priority=0):
    """
    Task is uniquely identified via model, integration and information.
    Other fields have to be updated.
    """
    try:
        # query via the unique combination
        task = Task.objects.get(model=model, method=method, info=info)
        task.priority = priority
    except ObjectDoesNotExist:
        task = Task(model=model, method=method, info=info, priority=priority)
    task.save()
    logging.info("Task created/updated: {}".format(task))
    return task


def create_simulation(task, parameters):
    """ Create simulation from given task and parameters.
    :param task: models.Task
    :param parameters: iterable of models.Parameter
    :return:
    """
    sim = Simulation(task=task)
    sim.save()
    sim.parameters.add(*parameters)
    logging.info("Simulation created/updated: {}".format(task))
    return sim


# ===============================================================================
# Getters
# ===============================================================================