"""
Helper functions and tools to create objects in the database.

All interactions with the database should go via this module.
No direct interactions with the database should occur

@author: Matthias Koenig
@date: 2015-05-10
"""
import logging
from django.core.exceptions import ObjectDoesNotExist

# provide the formats and types via the API
from simapp.models import CompModelFormat
from simapp.models import MethodType
from simapp.models import ParameterType
from simapp.models import SimulationStatus
from simapp.models import SettingKey

from simapp.models import CompModel, Task, Simulation, Parameter, Method, Setting

# ===============================================================================
# Creators
# ===============================================================================
def create_model(file_path, model_format=CompModelFormat.SBML):
    """ Create django CompModel.
    Provide the path of the file. Use the enum CompModelFormat to specify
    the model format.

    :param file_path: file_path of the model file
    :param model_format: CompModelFormat (SBML, CELLML, ...)
    :return: models.CompModel
    """
    return CompModel.create(file_path=file_path, model_format=model_format)


def create_parameter(key, value, unit, parameter_type):
    """ Create models.Parameter from given information.
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
    """ Create models.Task.
    Task is uniquely identified via model, integration and information.
    Other fields have to be updated.
    :param model:
    :param method:
    :param info:
    :param priority:
    :return:
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


def create_method_from_settings(method_type, settings_dict, add_defaults=True):
    """ Create method for given settings.
    :param method_type:
    :param settings_dict:
    :param add_defaults:
    :return:
    """
    settings = Setting.get_or_create_from_dict(settings_dict, add_defaults=add_defaults)
    return Method.get_or_create(method_type=method_type, settings=settings)


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

def get_simulations_for_task(task):
    # get by task.pk
    if isinstance(task, int):
        return Simulation.objects.filter(task__pk=task)
    # get by task
    return Simulation.objects.filter(task=task)


def get_parameters_for_simulation(simulation):
    return Parameter.objects.filter(simulation=simulation)
