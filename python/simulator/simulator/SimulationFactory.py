#!/usr/bin/python
'''
This module generates the simulation definitions in the database.
The parameters for the individual simulations are generated by sampling
from the provided parameter distributions for the models.

Simulations are collected in tasks. All simulations belonging to the same task
run with the same model and the same settings for the simulation.
Parameters are the actual changes which are performed for the individual 
simulation.
Tasks have a priority associated which determines the order of execution, i.e.
tasks with higher priority are performed first. 
     
@author: Matthias Koenig
@date: 2014-03-14
'''

import os
import logging
import numpy as np
from subprocess import call
from django.core.exceptions import ObjectDoesNotExist

import sim.PathSettings
from sim.PathSettings import SBML_DIR
from sim.models import *


from simulator.distribution.distributions import getGalactoseDistributions, getDemoDistributions
from simulator.distribution.sampling import createParametersBySampling


def createDemoSamples(N, sampling):
    dist_data = getDemoDistributions()
    return createParametersBySampling(dist_data, N, sampling);

def createGalactoseSamples(N, sampling):
    dist_data = getGalactoseDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);
    samples = adaptFlowInSamples(samples)
    samples = setDeficiencyInSamples(samples, deficiency=0)
    return samples

def setDeficiencyInSamples(samples, deficiency=0):
    return setParameterInSamples(samples, 'deficiency', deficiency, '-', GLOBAL_PARAMETER)

def setParameterInSamples(samples, pid, value, unit, ptype):
    if ptype not in PTYPES:
        print 'ptype not supported', ptype
        return    
    for s in samples:
        s[pid] = (pid, value, unit, ptype)
    return samples

def setParameterValuesInSamples(raw_samples, pid, values, unit, ptype):
    if ptype not in PTYPES:
        print 'ptype not supported', ptype
        return
    samples = []
    for s in raw_samples:
        for value in values:
            # make a copy of the dictionary
            snew = s.copy()
            # add information
            snew[pid] = (pid, value, unit, ptype)
            samples.append(snew)
    return samples

    
def adaptFlowInSamples(samples):
    '''
    flow is adapted due to scaling to full liver architecture
        TODO: make this consistent, this is not good and seems like dirty fix
        TODO: make a class for the parameters
    '''
    print 'flow adaptation'
    f_flow = 0.47
    for s in samples:
        if (s.has_key("flow_sin")):
            name, value, unit, ptype = s["flow_sin"];
            s["flow_sin"] = (name, value*f_flow, unit, ptype)
    return samples


def create_django_model(sbml_id, sync=True):
    ''' Creates the model from given sbml_id '''    
    model = SBMLModel.create(sbml_id, SBML_DIR);
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
    Task is uniquely identified via the model and integration.
    Other fields have to be updated.
    '''
    try:
        task = Task.objects.get(sbml_model=model, integration=integration)
        task.info = info
        task.priority = priority
    except ObjectDoesNotExist:
        task = Task(sbml_model=model, integration=integration, 
                    info=info, priority=priority)
    task.save()
    print "Task created/updated: {}".format(task)    
    return task


def createSimulationsForSamples(task, samples):
    for s in samples:
        createSimulationForSample(task, sample=s)
        
        
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

#----------------------------------------------------------------------#
def make_demo(sbml_id, N, priority=0):
    info='Simple demo network to test database and simulations.'
    model = create_django_model(sbml_id, sync=False)
    
    # parameter samples
    samples = createDemoSamples(N=N, sampling="distribution")
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':500.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info, priority)
    createSimulationsForSamples(task, samples)
        
#----------------------------------------------------------------------#
def make_glucose(sbml_id):
    ''' Model of hepatic glucose metabolism '''
    create_django_model(sbml_id, sync=True)

#----------------------------------------------------------------------#
def make_galactose_core(sbml_id, N):
    info = '''Simulation of varying galactose concentrations periportal to steady state.'''
    model = create_django_model(sbml_id, sync=True)
    
    # create parameter samples
    samples = createGalactoseSamples(N=N, sampling='distribution') 
    gal_range = np.arange(0, 6, 0.5)
    samples = setParameterValuesInSamples(samples, 'PP__gal', gal_range, 'mM', BOUNDERY_INIT)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)
    
    return (task, samples)

#----------------------------------------------------------------------#
def make_galactose_dilution(sbml_id, N, sync=True, priority=0):
    info = '''Simulation of multiple-indicator dilution curves (tracer peak periportal).'''
    model = create_django_model(sbml_id, sync=sync)
    
    # parameter samples
    raw_samples = createGalactoseSamples(N=N, sampling="distribution")
    samples = setParameterInSamples(raw_samples, 'PP__gal', 0.0, 'mM', BOUNDERY_INIT)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':5000.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info, priority=priority)
    createSimulationsForSamples(task, samples)

    return (task, samples)

#----------------------------------------------------------------------#
def make_galactose_challenge(sbml_id, N):        
    info = '''Simulation of varying galactose challenge periportal to steady state.'''
    model = create_django_model(sbml_id, sync=True)
    
    # parameter samples
    raw_samples = createGalactoseSamples(N=N, sampling='distribution') 
    gal_challenge = np.arange(0, 6.5, 0.5)
    samples = setParameterValuesInSamples(raw_samples, 'gal_challenge', gal_challenge, 'mM', GLOBAL_PARAMETER)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)
    
    return (task, samples)
#----------------------------------------------------------------------#
def make_galactose_step(sbml_id, N):        
    info = '''Simulation of stepwise increase of periportal galactose.'''
    model = create_django_model(sbml_id, sync=True)
    
    # parameter samples
    samples = createGalactoseSamples(N=N, sampling='distribution') 
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':30000.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)
    
    return (task, samples)

#----------------------------------------------------------------------#
def derive_deficiency_simulations(task, samples, deficiencies):
    ''' Takes a given set of samples for the normal case and
        creates the corresponding deficiency simulations. 
        The information is stored in the settings dict
        '''
    sdict = task.integration.get_settings_dict()
    for d in deficiencies:
        sdict['condition'] = 'GDEF_' + str(d)
        settings = Setting.get_settings(sdict)
        integration = Integration.get_or_create_integration(settings)
        # Creates a new derived task (the integr
        task_d = create_task(task.sbml_model, integration, info=task.info)
        
        # create the simulations (adaption of samples)
        samples = setDeficiencyInSamples(samples, deficiency=d)
        createSimulationsForSamples(task_d, samples)    


####################################################################################
if __name__ == "__main__":
    VERSION = 20
    
    #----------------------------------------------------------------------#
    if (0):
        print 'make demo'
        make_demo(sbml_id='Koenig2014_demo_kinetic_v7', N=20, priority=10)
    #----------------------------------------------------------------------#
    if (0):
        make_glucose(sbml_id='Koenig2014_Hepatic_Glucose_Model_annotated')
    #----------------------------------------------------------------------#
    if (0):
        sbml_id = 'Galactose_v{}_Nc20_core'.format(VERSION)
        [task, samples] = make_galactose_core(sbml_id, N=50)
    
        # Create deficiency samples belonging to the original samples
        deficiencies = range(1, 24)
        derive_deficiency_simulations(task, samples, deficiencies)
 
    #----------------------------------------------------------------------#
    if (0):
        '''
        Multiple Indicator Dilution peaks after certain time.
        The peaks are combined with additional galactose background 
        challenges.
        In case of additional changes the system must be in steady
        '''
        sbml_id = 'Galactose_v{}_Nc20_dilution'.format(VERSION)
        [task, raw_samples] = make_galactose_dilution(sbml_id, 
                                                      N=1, sync=True, priority=10)
        
        # additional galactose challenge
        # PP__gal = (0.28, 5, 12.5, 17.5) # [mM]
        # The galactose values have to be adapted for already occured
        # clearance
        PP__gal = (2.3, 5, 14.8, 19.8) # [mM]
        samples = setParameterValuesInSamples(raw_samples, 'PP__gal', PP__gal, 'mM', BOUNDERY_INIT)
        createSimulationsForSamples(task, samples)
        
    #----------------------------------------------------------------------#
    if (0):
        '''
        Galactose challenge after certain time and simulation to steady state.
        '''
        sbml_id = "Galactose_v{}_Nc20_galactose-challenge".format(VERSION)
        task, samples = make_galactose_challenge(sbml_id, N=100)
        
        # Create deficiency samples belonging to the original samples
        deficiencies = range(1,3)
        # deficiencies = range(1, 24)
        derive_deficiency_simulations(task, samples, deficiencies)
    
    if (0):
        ''' Reuse the samples from task.
            Necessary to generate the identical geometries than
            for the normal case.
        '''
        from simulator.distribution.sampling_tools import get_samples_from_task
        task = Task.objects.get(pk=1)
        samples = get_samples_from_task(task)
        
        derive_deficiency_simulations(task, samples, deficiencies=range(5,24))
        
        
    #----------------------------------------------------------------------#
    if (0):
        '''
        Galactose stepwise increase.
        '''
        # make_galactose_step(sbml_id="Galactose_v{}_Nc1_galactose-step".format(VERSION), N=10)    
        make_galactose_step(sbml_id="Galactose_v{}_Nc20_galactose-step".format(VERSION), N=100) 
        
    #----------------------------------------------------------------------#
    if (0):
        pass
        # TODO: implement
        # make_galactose_cirrhosis(N=10)
    
####################################################################################

