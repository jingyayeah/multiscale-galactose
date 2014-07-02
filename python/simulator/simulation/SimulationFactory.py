#!/usr/bin/python
'''
The SimulationFactory generates all simulations in the database.
The parameters for the individual simulations are generated by sampling
from the provided parameter distributions for the models.
     
@author: Matthias Koenig
@date: 2014-03-14
'''

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
import numpy as np

from sim.models import *
from simulation.distribution.Distributions import getMultipleIndicatorDistributions, getDemoDistributions
from simulation.distribution.RandomSampling import createParametersBySampling

SBML_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sbml"
MULTISCALE_GALACTOSE = "/home/mkoenig/multiscale-galactose"


def syncDjangoSBML():
    '''
    Copy all the SBML files to the server 
        run an operating system command
        call(["ls", "-l"])
    '''
    from subprocess import call
    call_command = [MULTISCALE_GALACTOSE + '/' + "syncDjangoSBML.sh"]
    print call_command
    call(call_command)


def createTask(model, integration, info='', priority=0):
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration, 
                                               info=info, priority=priority)
    if (created):
        print "Task created: {}".format(task)
    return task


def createSimulationsForSamples(task, samples):
    for s in samples:
        createSimulationForSample(task, sample=s)
        
        
def createSimulationForSample(task, sample):
    ''' 
    Create the single Parameters, the combined ParameterCollection
    and the simulation based on the Parametercollection for the
    iterable sample, which contains triples of (name, value, unit).
    '''
    # Parameters are generated in a unique way
    parameters = []
    for data in sample.values():
        name, value, unit, ptype = data
        p, created = Parameter.objects.get_or_create(name=name, value=value, unit=unit, ptype=ptype);
        parameters.append(p)

    sim = Simulation(task=task, status = UNASSIGNED)
    sim.save()
    sim.parameters.add(*parameters)
    print "{}".format(sim)        
        

def createDemoSamples(N, sampling):
    dist_data = getDemoDistributions()
    return createParametersBySampling(dist_data, N, sampling);


def createMultipleIndicatorSamples(N, sampling):
    ''' MulitpleIndicator simulations. '''
    dist_data = getMultipleIndicatorDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);
    samples = adaptFlowInSamples(samples)
    return samples


def createGalactoseSamples(gal_range, N=1, sampling='mean'):
    ''' 
    Raw sample is taken from the distributions.
    The same raw_sample is used to generate all the galactose simulations, 
    i.e. the identical sinusoidal units are simulated with varying 
    inputs (here of galactose).
    TODO: make more general with a given id and range. 
    '''
    raw_samples = createMultipleIndicatorSamples(N, sampling) 
    raw_samples = setDeficiencyInSamples(raw_samples)
    samples = []
    for s in raw_samples:
        for galactose in gal_range:
            # make a copy of the dictionary
            snew = s.copy()
            # add information
            snew['deficiency'] = ('deficiency', 0, '-', GLOBAL_PARAMETER)
            snew['PP_gal'] = ('PP__gal', galactose, 'mM', BOUNDERY_INIT)
            samples.append(snew)
    return samples


def setDeficiencyInSamples(samples, deficiency=0):
    for s in samples:
        s['deficiency'] = ('deficiency', deficiency, '-', GLOBAL_PARAMETER)
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


#----------------------------------------------------------------------#
def makeDemo(N):
    print '*** DEMO ***'
    
    model = SBMLModel.create('Koenig2014_demo_kinetic_v7', SBML_FOLDER);
    model.save();
    # syncDjangoSBML()
    
    sdict = dict(default_settings)
    sdict['tstart'] = 0.0;
    sdict['tend']  = 500.0;
    sdict['steps'] = 100;
    settings = Setting.get_settings_for_dict(sdict)
    integration = Integration.get_or_create_integration(settings)
        
    task = createTask(model, integration, 
                      info='Simulation of the demo network for visualization.')
    samples = createDemoSamples(N=N, sampling="distribution")
    createSimulationsForSamples(task, samples)
#----------------------------------------------------------------------#
def makeGlucose():
    print '*** Hepatic Glucose Metabolism ***'
    model = SBMLModel.create("Koenig2014_Hepatic_Glucose_Model_annotated", 
                             SBML_FOLDER);
    model.save();
    syncDjangoSBML()
    
#----------------------------------------------------------------------#
def makeMultipleIndicator(N):
    '''
    MultipleIndicator Simulations with variable tracer peak duration
    The peak time definition is specified in the model generation.
    '''
    print '*** MULTIPLE INDICATOR ***'
    info = '''Simulation of multiple-indicator dilution curves (tracer peak periportal).'''
    
    sdict = dict(default_settings)
    sdict['tstart'] = 0.0;
    sdict['tend']  = 5000.0;
    sdict['steps'] = 100;
    settings = Setting.get_settings_for_dict(sdict)
    integration = Integration.get_or_create_integration(settings)
    
    sbml_id = 'Galactose_v11_Nc20_dilution'
    model = SBMLModel.create(sbml_id, SBML_FOLDER);
    model.save();
    syncDjangoSBML()
            
    task = createTask(model, integration, info=info) 
    samples = createMultipleIndicatorSamples(N=N, sampling="distribution")
    createSimulationsForSamples(task, samples)

#----------------------------------------------------------------------#
def makeMultiscaleGalactose(N, singleCell=False):
    print '*** MULTISCALE_GALACTOSE_SIMULATIONS ***'
    if singleCell:
        sbml_id = "Galactose_v11_Nc1_core"
    else:
        sbml_id = "Galactose_v11_Nc20_core"
            
    info = '''Simulation of varying galactose concentrations periportal to steady state.'''
    model = SBMLModel.create(sbml_id, SBML_FOLDER);
    model.save();
    syncDjangoSBML()
    
    # integration
    sdict = dict(default_settings)
    sdict['tstart'] = 0.0;
    sdict['tend']  = 10000.0;
    sdict['steps'] = 100;
    settings = Setting.get_settings_for_dict(sdict)
    integration = Integration.get_or_create_integration(settings)
    
    # simulations
    task = createTask(model, integration, info=info)
    gal_range = np.arange(0, 6, 0.5)
    samples = createGalactoseSamples(gal_range, N=N, sampling="distribution")
    createSimulationsForSamples(task, samples)
    
    return (task, samples)

####################################################################################
if __name__ == "__main__":

    #----------------------------------------------------------------------#
    if (0):
        makeDemo(N=1000)
    #----------------------------------------------------------------------#
    if (0):
        makeGlucose()
    #----------------------------------------------------------------------#
    if (0):
        # Create the normal case for 1 cell or all cells
        singleCell = False
        [task, samples] = makeMultiscaleGalactose(N=10, singleCell=singleCell)
    
        # Use the samples to create deficiencies
        deficiencies = ()
        # deficiencies = range(1, 24)
        for d in deficiencies:
            sdict = task.integration.get_settings_dict()
            sdict['condition'] = 'GDEF_' + str(d)
            settings = Setting.get_settings_for_dict(sdict)
            integration = Integration.get_or_create_integration(settings)
            
            task_d = createTask(task.sbml_model, integration, info=task.info)
            # create the simulations
            samples = setDeficiencyInSamples(samples, deficiency=d)
            createSimulationsForSamples(task_d, samples)
            
    #----------------------------------------------------------------------#
    if (1):
        makeMultipleIndicator(N=10)
    #----------------------------------------------------------------------#

    
####################################################################################

