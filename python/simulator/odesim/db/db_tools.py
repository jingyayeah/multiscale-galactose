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
import logging
import os


import project_settings
from django.core.exceptions import ObjectDoesNotExist
from simapp.models import CompModel, Task

# syncronize the models with the other servers
SYNC_BETWEEN_SERVERS = False 

def sbmlmodel_from_id(sbml_id, sync=True):
    ''' Creates the model from given sbml_id.
        The model with the given id has to be already in the correct folder.
    '''    
    model = CompModel.create(sbml_id, project_settings.SBML_DIR)
    model.save()
    if sync: _sync_sbml_in_network()    
    return model

def sbmlmodel_from_file(sbml_file, sync=False):
    ''' Creates the model from given sbml file. '''
    model = CompModel.create_from_file(sbml_file)
    model.save()
    if sync: _sync_sbml_in_network()
    return model
    
def _sync_sbml_in_network():
    '''
    Copies all SBML files to the server 
        run an operating system command
        call(["ls", "-l"])
    '''
    from subprocess import call
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
    logging.info("Task created/updated: {}".format(task))    
    return task




# TODO: refactor this
from simapp.models import Simulation, Parameter
from simapp.models import UNASSIGNED


from django.db import transaction

@transaction.atomic
def createSimulationsForSamples(task, samples):
    ''' Creates the simulation for a given sample.
    Does not check if the odesim already exists.
    - creates the Parameters
    - creates empty odesim and adds the parameters.
    Function does not check if the odesim with given parameters
    already exists.
    TODO: create in one transaction.
    '''
    
    # bulk create simulations
    # sims_list = [Simulation(task=task, status=UNASSIGNED) for k in xrange(samples)]
    # Simulation.objects.bulk_create(sims_list)
    
    sims = []
    for sample in samples:
        sim = Simulation(task=task, status=UNASSIGNED)
        parameters = []
        for sp in sample.parameters:
            # This takes forever to check if parameter already in db
            p, _ = Parameter.objects.get_or_create(name=sp.key, value=sp.value, unit=sp.unit, ptype=sp.ptype);
            parameters.append(p)
        
        # sim = sims_list[k]
        sim.parameters.add(*parameters)
        sims.append(sim)
        print(sim)
        
    return sims

def get_samples_from_task(task):
    ''' Returns all samples for simulations for given task. '''
    sims = Simulation.objects.filter(task=task)
    return [get_sample_from_simulation(sim) for sim in sims]
    
from odesim.dist.samples import SampleParameter, Sample

def get_sample_from_simulation(sim):
    '''
    Reads the sample structure from the database, namely the
    parameters set for a odesim.
    Important to reuse the samples of a given task for another task.
    '''
    pars = Parameter.objects.filter(simulation=sim)
    s = Sample()
    for p in pars:
        s.add_parameter(SampleParameter.fromparameter(p))
    return s
