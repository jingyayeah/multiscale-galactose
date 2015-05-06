'''
Helper functions for the interaction with the django database layer.
This module is used to create models, simulations and tasks in the database.

A task is a set of simulations with given integration settings, i.e. the 
individual simulations of one task are comparable between each other.
All simulations belonging to the same task run with the same model 
and the same settings.
Tasks have a priority which determines the order of execution,
tasks with higher priority are performed first. 

If possible all interactions with the django database layer should 
go via this intermediate module.

@author: Matthias Koenig
@date: 2015-05-06
'''
from __future__ import print_function

import os
import logging
from subprocess import call

import path_settings
from django.core.exceptions import ObjectDoesNotExist
from sbmlsim.models import SBMLModel, Task

# syncronize the models with the other servers
SYNC_BETWEEN_SERVERS = False 

def sbmlmodel_from_id(sbml_id, sync=True):
    ''' Creates the model from given sbml_id.
        The model with the given id has to be already in the correct folder.
    '''    
    model = SBMLModel.create(sbml_id, path_settings.SBML_DIR)
    model = _save_and_sync_model(model, sync)
    return model

def sbmlmodel_from_file(sbml_file, sync=False):
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
    print("Task created/updated: {}".format(task))    
    return task
