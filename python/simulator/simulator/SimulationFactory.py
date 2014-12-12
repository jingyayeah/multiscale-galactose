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


import logging
import numpy as np
from subprocess import call
from copy import deepcopy

import sim.PathSettings
from sim.PathSettings import SBML_DIR
from sim.models import *


from simulator.distribution.distributions import getGalactoseDistributions, getDemoDistributions
from simulator.distribution.sampling import createParametersBySampling


def deep_copy_samples(samples):
    ''' A full deep copy of the samples list. 
        Necessary to create derived samples.
    '''
    new_samples = deepcopy(samples)
    return new_samples


def createDemoSamples(N, sampling):
    dist_data = getDemoDistributions()
    return createParametersBySampling(dist_data, N, sampling);

def createGalactoseSamples(N, sampling):
    dist_data = getGalactoseDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);
    samples = setDeficiencyInSamples(samples, deficiency=0)
    return samples

def createFlowSamples(N, sampling, f_flows):
    ''' Create samples for the different flow adaptions. '''
    dist_data = getGalactoseDistributions()
    raw_samples = createParametersBySampling(dist_data, N, sampling);
    raw_samples = setDeficiencyInSamples(raw_samples, deficiency=0)
    samples = []
    # Go over the flow range and create the flow samples, set the flow parameter in all cases
    for f_flow in f_flows:
        tmp_samples = deep_copy_samples(raw_samples)
        tmp_samples = adapt_flow_in_samples(tmp_samples, f_flow)
        samples.extend(tmp_samples)
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


def setParameterValuesInSamples(raw_samples, p_list):
    for pset in p_list:
        if pset['ptype'] not in PTYPES:
            print 'ptype not supported', pset['ptype']
            return
    
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

    
def adapt_flow_in_samples(samples, f_flow):
    '''
    Flow is adapted via scaling of all samples with a constant factor f_flow.
    The sample distribution is linearly scaled with the provided factor.
    '''
    for s in samples:
        if (s.has_key("flow_sin")):
            name, value, unit, ptype = s["flow_sin"];
            s["flow_sin"] = (name, value*f_flow, unit, ptype)
            s["f_flow"] = ("f_flow", f_flow, '-', NONE_SBML_PARAMETER)
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
    samples = adapt_flow_in_samples(samples, f_flow=0.5)
    gal_range = np.arange(0, 6, 0.5)
    samples = setParameterValuesInSamples(samples, 'PP__gal', gal_range, 'mM', BOUNDERY_INIT)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)
    
    return (task, samples)

#----------------------------------------------------------------------#
def make_galactose_dilution(sbml_id, N, sampling):
    info = 'Multiple-indicator dilution curves ({})'.format(sampling)
    model = create_django_model(sbml_id, sync=True)
    
    # adapt flow in samples with the given f_flows
    f_flows = (1.0, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.01)
    raw_samples = createFlowSamples(N=N, sampling=sampling, f_flows=f_flows)
    
    samples = setParameterInSamples(raw_samples, 'PP__gal', 0.0, 'mM', BOUNDERY_INIT)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info, priority=0)
    # createSimulationsForSamples(task, samples)

    return (task, samples)

#----------------------------------------------------------------------#
def make_galactose_challenge(sbml_id, N, sampling):        
    info = 'Galactose challenge periportal ({})'.format(sampling)
    model = create_django_model(sbml_id, sync=True)
    
    # parameter samples
    raw_samples = createGalactoseSamples(N=N, sampling=sampling) 
    # gal_challenge = np.arange(0.5, 7.0, 0.5)
    gal_challenge = (0.5, 1.0, 2.0, 4.0, 8.0)
    samples = setParameterValuesInSamples(raw_samples, 'gal_challenge', gal_challenge, 'mM', GLOBAL_PARAMETER)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)
    
    return (task, samples)

#----------------------------------------------------------------------#

def make_galactose_flow(sbml_id, N, sampling):        
    info = 'Galactose clearance under given perfusion ({}).'.format(sampling)
    model = create_django_model(sbml_id, sync=True)
    
    # adapt flow in samples with the given f_flows
    f_flows = (1.0, 0.7, 0.5, 0.4, 0.3, 0.2, 0.15, 0.1, 0.05, 0.01)
    raw_samples = createFlowSamples(N=N, sampling=sampling, f_flows=f_flows)
    
    # only test the max GEC
    # gal_challenge = (8.0, 2.0, 0.5)
    gal_challenge = (8.0,)
    samples = setParameterValuesInSamples(raw_samples, 
                [{'pid': 'gal_challenge', 'values': gal_challenge, 'unit': 'mM', 'ptype':GLOBAL_PARAMETER}])
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':50} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)

    return (task, samples)

#----------------------------------------------------------------------#
def make_galactose_aging(sbml_id, N, sampling):        
    info = 'Galactose clearance under given perfusion for different age({}).'.format(sampling)
    model = create_django_model(sbml_id, sync=True)
    
    # adapt flow in samples with the given f_flows
    f_flows = (1.0, 0.7, 0.5, 0.4, 0.3, 0.2, 0.15, 0.1, 0.05, 0.01)
    raw_samples = createFlowSamples(N=N, sampling=sampling, f_flows=f_flows)
    
    # only test max GEC
    gal_challenge = (8.0,)
    samples = setParameterValuesInSamples(raw_samples, 
                [{'pid': 'gal_challenge', 'values': gal_challenge, 'unit': 'mM', 'ptype':GLOBAL_PARAMETER}])
    
    # age represents : [20, 40, 60, 80, 100]
    y_end = [165E-9*x for x in [1, 1.375, 1.75, 2.125, 2.5]]  # [nm]
    N_fen = [1E13*x for x in [1, 0.5, 0.25, 0.125, 0.0625]]  # [1/m^2]
    p_list = [ {'pid': 'y_end', 'values': y_end, 'unit': 'nm', 'ptype':GLOBAL_PARAMETER},
                   {'pid': 'N_fen', 'values': N_fen, 'unit': 'per_m2', 'ptype':GLOBAL_PARAMETER}]
    samples = setParameterValuesInSamples(samples, p_list)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':50} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)

    return (task, samples)

#----------------------------------------------------------------------#
def make_galactose_metabolic_change(sbml_id, N, sampling):        
    info = 'Galactose clearance per perfusion for varying metabolic capacity (rules) ({}).'.format(sampling)
    model = create_django_model(sbml_id, sync=True)
    
    # adapt flow in samples with the given f_flows
    f_flows = (1.0, 0.7, 0.5, 0.4, 0.3, 0.2, 0.15, 0.1, 0.05, 0.01)
    raw_samples = createFlowSamples(N=N, sampling=sampling, f_flows=f_flows)
    
    # only test max GEC
    gal_challenge = (8.0,)
    samples = setParameterValuesInSamples(raw_samples, 
                [{'pid': 'gal_challenge', 'values': gal_challenge, 'unit': 'mM', 'ptype':GLOBAL_PARAMETER}])
    
    # age represents : [20, 40, 60, 80, 100]
    scale_f = [5.3E-15*x for x in [0.75, 0.9, 1, 1.1, 1.25]]  # [-]
    p_list = [ {'pid': 'scale_f', 'values': scale_f, 'unit': '-', 'ptype':GLOBAL_PARAMETER}, ]
    samples = setParameterValuesInSamples(samples, p_list)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':50} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info=info)
    createSimulationsForSamples(task, samples)

    return (task, samples)


#----------------------------------------------------------------------#
def make_galactose_step(sbml_id, N, sampling):        
    info = 'Stepwise increase of periportal galactose ({})'.format(sampling)
    model = create_django_model(sbml_id, sync=True)
    
    # parameter samples
    samples = createGalactoseSamples(N=N, sampling=sampling) 
    
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
    VERSION = 51
    
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
        GEC curves.
        Galactose elimination under different flow distributions (scaled).
        '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".format(VERSION)
        # sample from distribution
        task, samples = make_galactose_flow(sbml_id, N=500, sampling='distribution')
        # mean sinusoidal unit
        task, samples = make_galactose_flow(sbml_id, N=1, sampling='mean')

    #----------------------------------------------------------------------#
    if (0):
        ''' GEC curves in aging. 
            Age dependent change in N_fen and y_end.
        '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".format(VERSION)
        # sample from distribution & add additional changes in aging
        task, samples = make_galactose_aging(sbml_id, N=100, sampling='distribution')
        
        # mean sinusoidal unit
        task, samples = make_galactose_aging(sbml_id, N=0, sampling='mean')
   
    #----------------------------------------------------------------------#
    if (0):
        ''' GEC curves under different metabolic capacity of galactose metabolism. 
            Change in the maximal scale of metabolism
        '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".format(VERSION)
        # sample from distribution & add additional changes in aging
        task, samples = make_galactose_metabolic_change(sbml_id, N=100, sampling='distribution')
        
        # mean sinusoidal unit
        task, samples = make_galactose_metabolic_change(sbml_id, N=0, sampling='mean')
   
    #----------------------------------------------------------------------#
    if (1):
        '''
        Multiple Indicator Dilution.
        Combination with different galactose challenge, i.e. dilution curves
        under varying galactose concentrations periportal.
        The galactose values periportal must be corrected for already occurred clearance,
        i.e the periportal concentrations are higher than the reported values.
        A correction factor of ~2.3 was applied to the reported galactose values of
        PP__gal = (2.3, 5, 14.8, 19.8) # [mM]
        '''
        sbml_id = 'Galactose_v{}_Nc20_dilution'.format(VERSION)
        PP__gal = (0.28, 12.5, 17.5) # [mM]
        p_list = [ {'pid': 'PP__gal', 'values': PP__gal, 'unit': 'mM', 'ptype':BOUNDERY_INIT}]
        
        
        # basic dilution curves with additional galactose challenge
        [task, raw_samples] = make_galactose_dilution(sbml_id, N=500, sampling="distribution")
        samples = setParameterValuesInSamples(raw_samples, p_list)
        createSimulationsForSamples(task, samples)
        
        # mean sinusoid for comparison
        [task, raw_samples] = make_galactose_dilution(sbml_id, N=1, sampling="mean")
        samples = setParameterValuesInSamples(raw_samples, p_list)
        createSimulationsForSamples(task, samples)
        
    #----------------------------------------------------------------------#
    if (0):
        ''' Galactose challenge in galactosemias. '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".format(VERSION)
        deficiencies = range(1, 24)
        
        # Create deficiency samples belonging to the original samples
        task, samples = make_galactose_challenge(sbml_id, N=5, sampling='distribution')
        derive_deficiency_simulations(task, samples, deficiencies)
    
        # mean sinusoidal unit
        task, samples = make_galactose_challenge(sbml_id, N=1, sampling='mean')
        derive_deficiency_simulations(task, samples, deficiencies)
    #===========================================================================
    # if (0):
    #     ''' Reuse the samples from task.
    #         Necessary to generate the identical geometries than
    #         for the normal case.
    #         This is only for testing. For final simulations all galactosemias
    #         should be generated in batch.
    #     '''
    #     from simulator.distribution.sampling_tools import get_samples_from_task
    #     task = Task.objects.get(pk=26)
    #     samples = get_samples_from_task(task)
    #     deficiencies = range(4,24)
    #     derive_deficiency_simulations(task, samples, deficiencies=deficiencies)
    #===========================================================================
        
    #----------------------------------------------------------------------#
    if (0):
        ''' Galactose stepwise increase. '''
        # sample from distribution
        task, samples = make_galactose_step(sbml_id="Galactose_v{}_Nc20_galstep".format(VERSION), 
                                            N=100, sampling='distribution')
        # mean sinusoidal unit
        task, samples = make_galactose_step(sbml_id="Galactose_v{}_Nc20_galstep".format(VERSION), 
                                            N=1, sampling='mean')

####################################################################################

