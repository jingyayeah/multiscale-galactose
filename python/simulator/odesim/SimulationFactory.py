#!/usr/bin/python
'''
Helper functions for the creation of simulations.
The various models use these helper functions to set up all the simulations
in the database.
Simulations are based on the sampling of certain parameters.

Simulations are collected in tasks. All simulations belonging to the same task
run with the same model and the same settings for the odesim.
Parameters are the actual changes which are performed for the individual 
odesim.
Tasks have a priority associated which determines the order of execution, i.e.
tasks with higher priority are performed first. 

@author: Matthias Koenig
@date: 2015-05-03
'''

import os
import logging
from subprocess import call

import path_settings
from django.core.exceptions import ObjectDoesNotExist
from sbmlsim.models import SBMLModel, Task, Simulation, Parameter
from sbmlsim.models import UNASSIGNED


SYNC_BETWEEN_SERVERS = False # update the information for the other servers

# TODO handle parameters as named tupples & custom exceptions


def django_model_from_id(sbml_id, sync=True):
    ''' Creates the model from given sbml_id.
        The model with the given id has to be already in the correct folder.
    '''    
    model = SBMLModel.create(sbml_id, path_settings.SBML_DIR)
    model = _save_and_sync_model(model, sync)
    return model

def django_model_from_file(sbml_file, sync=False):
    ''' Creates the model from given sbml file. '''
    model = SBMLModel.create_from_file(sbml_file)
    model = _save_and_sync_model(model, sync)
    return model
    
def _save_and_sync_model(model, sync):
    model.save();
    if sync:
        print('Syncronize model with other computers ...')
        sync_sbml()
    return model

def sync_sbml():
    '''
    Copies all SBML files to the server 
        run an operating system command
        call(["ls", "-l"])
    '''
    call_command = [os.environ['MULTISCALE_GALACTOSE'] + '/' + "syncDjangoSBML.sh"]
    logging.debug(str(call_command))
    call(call_command)
    
def create_task(model, integration, info='', priority=0):
    '''
    Task is uniquely identified via model, integration and information.
    Other fields have to be updated.
    '''
    try:
        task = Task.objects.get(sbml_model=model, integration=integration, info=info)
        task.priority = priority
    except ObjectDoesNotExist:
        task = Task(sbml_model=model, integration=integration, 
                    info=info, priority=priority)
    task.save()
    print "Task created/updated: {}".format(task)    
    return task


