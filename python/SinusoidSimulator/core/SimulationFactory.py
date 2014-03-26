'''
Created on March 20, 2014
@author: Matthias Koenig

TODO: rewrite

Simulations in C++ (CopasiModelSimulator) are called with SBML file
& file of parameter settings.
The SimulationFactory generates sets of parameters and simulations.

UNASSIGNED simulations can be taken by processors and be performed.

    Create the necessary parameter sets for the simulations
    (flow, L, y_sin, y_dis, y_cell, PP__gal)
    Parameters are lists of triples, consisting of name, value and unit.
    
    In the simulation definition the parameter sets have to be created.
    For every parameterset a simulation is created

TODO: after creation of files these have to copied to the server, i.e
      mainly the sbml files

'''

SBML_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sbml"

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
import numpy as np
from sim.models import *
from django.db.models import Count
import numpy.random as npr
import math


def createSimulationsFromParametersInTask(pars, task):
    ''' 
    Create the single Parameters, the combined ParameterCollection
    and the simulation based on the Parametercollection for the
    iterable pars, which contains triples of (name, value, unit).
    '''
    ps = []
    for data in pars:
        name, value, unit = data
        p, tmp = Parameter.objects.get_or_create(name=name, value=value, unit=unit);
        ps.append(p)
    
    # Get the pset for the parameters if it exists
    # This is necessary to have unique collections regarding the parameters
    # Reduce the queryset with filters until 

    # Annotate with count first and use than to filter    
    querySet = ParameterCollection.objects.annotate(num_parameters=Count('parameters')).filter(num_parameters__eq=len(ps))
    for p in ps:
        querySet = querySet.filter(parameters = p)
        
    if (len(querySet)>0):
        pset = querySet[0]
    else:
        pset = ParameterCollection();
        pset.save()
        for p in ps:
            pset.parameters.add(p)
        pset.save()
    
    # Simulation
    sim, created = Simulation.objects.get_or_create(task=task, 
                                                      parameters = pset,
                                                      status = UNASSIGNED)
    if (created):
        print "Simulation created: {}".format(sim)
        try:
            sim.full_clean()
            # Validation check in the creation
        except ValidationError, e:
            # Do something based on the errors contained in e.message_dict.
            # Display them to a user, or handle them programatically.
            pass


def createGalactoseSimulationTask(sbml_id, N=10):
    '''
        Create the SBMLModel object and create simulations
        associated with the object.
    '''
    # TODO: check if already exists ??
    # Get or create the model
    model = SBMLModel.create(sbml_id, SBML_FOLDER);
    model.save();
    
    # Get or create integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=2000.0, 
                                                             tsteps=2000,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
    if (created):
        print "Integration created: {}".format(integration)
    
    # Create task 
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    if (created):
        print "Task created: {}".format(task)
    
    # Create the parameters for all deficiencies
    all_pars = createParametersBySampling(N);
    for deficiency in range(0,24):
        for pars in all_pars:
            pars.append( ('deficiency', deficiency, '-') )
            createSimulationsFromParametersInTask(pars, task)
    

def createDilutionCurvesSimulationTask(sbml_id, N=10):
    '''
        Create the SBMLModel object and create simulations
        associated with the object.
    '''
    # TODO: manage better 
    # Get or create the model
    model = SBMLModel.create(sbml_id, SBML_FOLDER);
    model.save();
    
    # Get or create integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=200.0, 
                                                             tsteps=2000,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
    if (created):
        print "Integration created: {}".format(integration)
    
    # Create task 
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    if (created):
        print "Task created: {}".format(task)
    
    # Create the parameters
    # pars = createParametersByManual();
    pars = createParametersBySampling(N)
    createSimulationsFromParametersInTask(pars, task)
    
    
def createParametersBySampling(N=100):
    '''
    Samples N values from lognormal distribution defined by the 
    given means and standard deviations.
    To set the seed of the random generator use: numpy.random.seed(42)
    '''
    names = ['L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin']
    means = [500E-6, 4.4E-6, 0.8E-6, 6.25E-6, 60E-6]
    stds  = [50E-6, 0.45E-6, 0.3E-6, 6.25E-6, 50E-6]
    units = ['m', 'm' ,'m', 'm', 'm/s']
    
    all_pars = [];
    for kn in xrange(N):
        # create parameters
        pars = []
        for kp in range(len(names)):
            m = means[kp]
            std = stds[kp]
            # parameters are lognormal distributed 
            mu = math.log(m**2 / math.sqrt(std**2+m**2));
            sigma = math.sqrt(math.log(std**2/m**2 + 1));
            value = npr.lognormal(mu, sigma)  
            pars.append( (names[kp], value, units[kp]) )
            
        all_pars.append(pars)
    return all_pars

def createParametersByManual():
    all_pars = []
    # what parameters should be sampled
    flows = np.arange(0.0, 600E-6, 60E-6)
    lengths = np.arange(400E-6, 600E-6, 100E-6)    
    for flow_sin in flows:
        for L in lengths: 
            p = (
                    ('y_cell', 6.25E-6, 'm'),
                    ('y_dis', 8.0E-7, 'm'),
                    ('y_sin', 4.4E-6, 'm'),
                    ('flow_sin', flow_sin, 'm/s'),
                    ('L',   L, 'm'),)
            all_pars.append(p)
    return all_pars

if __name__ == "__main__":
    # in a first step the models have to be created
     
    if (0):
        # create new dilution simulations    
        sbml_id = "Dilution_Curves_v5_Nc20_Nf1"
        N = 1000     # number of simulations
        createDilutionCurvesSimulationTask(sbml_id, N)
    
    if (1):
        # create the galactose simulations
        sbml_id = "Galactose_v5_Nc20_Nf1"
        N = 10     # number of simulations per deficiency
        createGalactoseSimulationTask(sbml_id, N)
    
    
    