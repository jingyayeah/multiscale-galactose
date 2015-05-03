#!/usr/bin/python
'''
Helper functions for the creation of simulations.
The various models use these helper functions to set up all the simulations
in the database.
Simulations are based on the sampling of certain parameters.

Simulations are collected in tasks. All simulations belonging to the same task
run with the same model and the same settings for the simulation.
Parameters are the actual changes which are performed for the individual 
simulation.
Tasks have a priority associated which determines the order of execution, i.e.
tasks with higher priority are performed first. 

@author: Matthias Koenig
@date: 2015-05-03
'''

import logging
from subprocess import call
from copy import deepcopy

import path_settings
from sbmlsim.models import *

SYNC_BETWEEN_SERVERS = False # update the information for the other servers

# TODO handle parameters as named tupples & custom exceptions


def deepcopy_samples(samples):
    ''' Returns a deepcopy of the list of samples. 
        Required for the creation of derived samples
    '''
    return deepcopy(samples)

def setParameterInSamples(samples, pid, value, unit, ptype):
    check_parameter_type(ptype)
    for s in samples:
        s[pid] = (pid, value, unit, ptype)
    return samples


def setParameterValuesInSamples(raw_samples, p_list):
    ''' ? how is the p_list structured ? '''
    for pset in p_list:
        check_parameter_type(pset['ptype'])
            
    Np = len(p_list)                # numbers of parameters to set
    Nval = len(p_list[0]['values']) # number of values from first p_dict
    
    samples = []
    for s in raw_samples:
        for k in range(Nval):
            # make a copy of the dictionary
            snew = s.copy()
            # set all the information
            for i in range(Np):
                p_dict = p_list[i]
                snew[p_dict['pid']] = (p_dict['pid'], p_dict['values'][k], p_dict['unit'], p_dict['ptype'])
            samples.append(snew)
    return samples

    
def django_model_from_id(sbml_id, sync=True):
    ''' Creates the model from given sbml_id.
        The model with the given id has to be already in the correct folder.
    '''    
    model = SBMLModel.create(sbml_id, path_settings.SBML_DIR)
    model = _save_and_sync_model(model, sync)
    return model

def django_model_from_file(sbml_file, sync=True):
    ''' Creates the model from given sbml file. '''
    model = SBMLModel.create_from_file(sbml_file)
    model = _save_and_sync_model(model, sync)
    return model
    
def _save_and_sync_model(model, sync):
    model.save();
    if sync:
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


def createSimulationsForSamples(task, samples):
    ''' Create all Django simulations for the given samples. '''
    return [createSimulationForSample(task, sample=s) for s in samples]    
        
def createSimulationForSample(task, sample):
    ''' 
    Creates the simulation for a given sample.
    Does not check if the simulation already exists.
    - creates the Parameters
    - creates empty simulation and adds the parameters.
    The function does not check if the simulation with these parameters
    already exist. This must be controlled on level of the samples.
    '''
    # Parameters are generated in a unique way
    parameters = []
    for data in sample.values():
        name, value, unit, ptype = data
        p, _ = Parameter.objects.get_or_create(name=name, value=value, unit=unit, ptype=ptype);
        parameters.append(p)

    sim = Simulation(task=task, status = UNASSIGNED)
    sim.save()
    
    sim.parameters.add(*parameters)
    print "{}".format(sim)
    return sim
