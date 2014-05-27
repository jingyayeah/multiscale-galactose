#!/usr/bin/python
'''
The SimulationFactory generates simulations for the models.
The parameters for the simulations are generated by various sampling
methods. Every simulation has a set of paramters.
Simulations can than be run with COPASI based on the SBML model and
the parameter settings files.
Parameters are lists of triples, consisting of name, value and unit.
    
@author: Matthias Koenig
@date: 2014-03-14

TODO: Create the simulations in bulk -> much faster than the individual
    database commit for every simulation.

'''
import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'


from sim.models import *
import numpy as np
from distribution.Distributions import getMultipleIndicatorDistributions, getDemoDistributions
from distribution.RandomSampling import createParametersBySampling

# here the local sbml files are located
SBML_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sbml"

def createTask(model, integration, simulator, info='', priority=0):
    ''' Creates the task from given information. '''
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration, 
                                               simulator=simulator, info=info, priority=priority)
    if (created):
        print "Task created: {}".format(task)
    return task


def createDemoSimulations(task, N=10, sampling='distribution'):
    ''' Creates simple demo simulation to test the network visualization. '''    
    # get the parameter sets by sampling (same parameters for all galactose settings)
    # the same parameter sampling is used for all deficiencies
    dist_data = getDemoDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);
    for s in samples:
        createSimulationForParameterSample(task, sample=s)
    return task


def createMultipleIndicatorSimulationTask(task, simulator, N=10, sampling="distribution"):
    ''' MulitpleIndicator simulations '''
    dist_data = getMultipleIndicatorDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);
    for s in samples:
        createSimulationForParameterSample(task=task, simulator=simulator, sample=s)


def createGalactoseSimulations(task, gal_range, flow_range, N=1, deficiencies=[0], sampling='mean'):
    ''' Galactose simulations '''
    # get the parameter sets by sampling (same parameters for all galactose settings)
    # the same parameter sampling is used for all deficiencies
    dist_data = getMultipleIndicatorDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);    
    for deficiency in deficiencies:
        for s in samples:
            for galactose in gal_range:
                for flow in flow_range:
                    # make a copy of the dictionary
                    snew = s.copy()
                    # add information
                    snew['deficiency'] = ('deficiency', deficiency, '-', GLOBAL_PARAMETER)
                    snew['PP_gal'] = ('PP__gal', galactose, 'mM', BOUNDERY_INIT)
                    snew['flow_sin'] = ('flow_sin', flow, 'm/s', GLOBAL_PARAMETER)
                    createSimulationForParameterSample(task, sample=snew)


def createSimulationForParameterSample(task, sample):
    ''' 
    Create the single Parameters, the combined ParameterCollection
    and the simulation based on the Parametercollection for the
    iterable sample, which contains triples of (name, value, unit).
    '''
    # Parameters
    ps = []
    for data in sample.values():
        name, value, unit, ptype = data
        p, created = Parameter.objects.get_or_create(name=name, value=value, unit=unit, ptype=ptype);
        ps.append(p)
    # ParameterCollection
    pset = ParameterCollection();
    pset.save()
    for p in ps:
        pset.parameters.add(p)
    pset.save()
    
    sim, created = Simulation.objects.get_or_create(task=task, 
                                                      parameters = pset,
                                                      status = UNASSIGNED)
    if (created):
        print "Simulation created: {}".format(sim)

###################################################################################
def syncDjangoSBML():
    ''' Copy all the SBML files to the server '''
    from subprocess import call
    # run an operating system command
    # call(["ls", "-l"])
    call_command = [code_dir + '/' + "syncDjangoSBML.sh"]
    print call_command
    call(call_command)

###################################################################################
if __name__ == "__main__":
    results_dir = "/home/mkoenig/multiscale-galactose-results"
    code_dir = "/home/mkoenig/multiscale-galactose"
    
    #----------------------------------------------------------------------#
    if (1):
        print '*** DEMO ***'

        sbml_id = "Koenig2014_demo_kinetic_v7"
        model = SBMLModel.create(sbml_id, SBML_FOLDER);
        model.save();
        syncDjangoSBML()
        
        integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=100.0, 
                                                             tsteps=2000,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)

        task = createTask(model, integration, simulator=ROADRUNNER, 
                          info='Simulation of the demo network for visualization.')
        
        createDemoSimulations(task, N=2000, sampling="distribution") 
        
    #----------------------------------------------------------------------#
    if (0):
        print '*** MULTIPLE INDICATOR ***'
        # MultipleIndicator Simulations with variable tracer peak duration
        # The peak time definition is done in the model generation.
        # -> adapt the simulations 
        
        info = '''Simulation of multiple-indicator dilution curves (tracer peak periportal).
        Flow adapted via the liver scaling factor after sampling!'''
        # integration
        integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=500.0, 
                                                             tsteps=4000,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
#         integration, created = Integration.objects.get_or_create(tstart=0.0, 
#                                                              tend=30.0, 
#                                                              tsteps=120,
#                                                              abs_tol=1E-6,
#                                                              rel_tol=1E-6)
        peaks = range(0,3)
        priorities = [10 + item*10 for item in peaks]
        for kp in peaks:
            # model
            sbml_id = "MultipleIndicator_P%02d_v20_Nc20_Nf1" % kp
            model = SBMLModel.create(sbml_id, SBML_FOLDER);
            model.save();
            syncDjangoSBML()
            # Simulations
            task = createTask(model=model, integration=integration, 
                              info=info, priority=priorities[kp]);
            createMultipleIndicatorSimulationTask(task, simulator=ROADRUNNER, N=990, sampling="distribution")
            # createMultipleIndicatorSimulationTask(task, N=100, sampling="mean") 
    #----------------------------------------------------------------------#
    if (0):
        print '*** GALACTOSE SIMULATIONS ***'
        # Create the galactose model
        sbml_id = "Galactose_v20_Nc20_Nf1"   
        info = '''Simulation of varying galactose concentrations periportal to steady state.'''
        model = SBMLModel.create(sbml_id, SBML_FOLDER);
        model.save();
        syncDjangoSBML()
        
        # integration
        integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=2000.0, 
                                                             tsteps=400,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
        # simulation
        simulator = ROADRUNNER
        gal_range = np.arange(0, 6, 1.0)
        flow_range = np.arange(0, 1000E-6, 100E-6)
        task = createTask(model, integration, simulator, info, priority=100)
        # create mean
        createGalactoseSimulations(task, gal_range, flow_range, N=1, 
                                   deficiencies=range(0,24), sampling='mean')
        # create from distribution
        #createGalactoseSimulations(task, gal_range, flow_range, N=10, 
        #                           deficiencies=range(0,24), sampling='distribution')
        #----------------------------------------------------------------------#        
