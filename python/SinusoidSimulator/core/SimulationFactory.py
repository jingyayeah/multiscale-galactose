'''
Created on March 20, 2014
@author: Matthias Koenig

Simulations in C++ (CopasiModelSimulator) are called with SBML file
& file of parameter settings.
The SimulationFactory generates sets of parameters and simulations.

UNASSIGNED simulations can be taken by processors and be performed.
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

def createSimulationForParametersInTask(pars, task):
    '''
    Create the necessary parameter sets for the simulations
    (flow, L, y_sin, y_dis, y_cell, PP__gal)
    Parameters are lists of triples, consisting of name, value and unit.
    
    In the simulation definition the parameter sets have to be created.
    For every parameterset a simulation is created
    '''
    ps = []
    for data in pars:
        name, value, unit = data
        p, created = Parameter.objects.get_or_create(name=name, value=value, unit=unit);
        if (created):
            print name, 'created'
            p.save()
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
        print 'ParameterSet found already'
    else:
        pset = ParameterCollection();
        pset.save()
        for p in ps:
            pset.parameters.add(p)
        pset.save()
        print "ParameterSet created"
    
    # Simulation
    print task, task.id
    sim, created = Simulation.objects.get_or_create(task=task, 
                                                      parameters = pset,
                                                      status = UNASSIGNED)
    if (created):
        print "Simulation created"
        try:
            sim.full_clean()
        except ValidationError, e:
            # Do something based on the errors contained in e.message_dict.
            # Display them to a user, or handle them programatically.
            pass
        sim.save()


def createDilutionCurvesSimulationTask(sbml_id, N=10):
    '''
        Create the SBMLModel object and create simulations
        associated with the object.
    '''
    # TODO: manage better 
    # Get or create the model
    model = SBMLModel.create(sbml_id, SBML_FOLDER);
    model.save();
    print 'name: ' + model.file.name
    print 'path: ' + model.file.path
    print 'url: '  + model.file.url
    
    # Get or create integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=200.0, 
                                                             tsteps=2000,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
    if (created):
        print ('integration created')
        integration.save()
    
    # Create task 
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    if (created):
        print ("task created")
        task.save()
    
    # Create the parameters
    # createParametersByManual(task);
    createParametersBySampling(task, N);
    
    
def createParametersByManual(task):
    # what parameters should be sampled
    flows = np.arange(0.0, 600E-6, 60E-6)
    lengths = np.arange(400E-6, 600E-6, 100E-6)    
    for flow_sin in flows:
        for L in lengths: 
            pars = (
                    ('y_cell', 6.25E-6, 'm'),
                    ('y_dis', 8.0E-7, 'm'),
                    ('y_sin', 4.4E-6, 'm'),
                    ('flow_sin', flow_sin, 'm/s'),
                    ('L',   L, 'm'),)
            createSimulationForParametersInTask(pars, task);


def createParametersBySampling(task, N=100):
    '''
        Samples N values from lognormal distribution defined by the 
        given means and standard deviations.
        TODO: create with seed to be sure which random numbers are taken.
    '''
    names = ['L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin']
    means = [500E-6, 4.4E-6, 0.8E-6, 6.25E-6, 60E-6]
    stds  = [50E-6, 0.45E-6, 0.3E-6, 6.25E-6, 50E-6]
    units = ['m', 'm' ,'m', 'm', 'm/s']
    
    for kn in range(N):
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
        
        createSimulationForParametersInTask(pars, task);


if __name__ == "__main__":

    # create new simulations for SBML with sbml_id 
    sbml_id = "Dilution_Curves_v5_Nc20_Nf1"
    N = 10     # number of simulations
    createDilutionCurvesSimulationTask(sbml_id, N)
    