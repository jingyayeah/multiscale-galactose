'''
Created on March 20, 2014
@author: Matthias Koenig

The SimulationFactory generates sets of simulations for a model.
ParameterSets are generated by sampling from the defined parameter
distributions and a set of simulations is generated for every set of
parameters.
Simulations are run with COPASI based on the given SBML file &
parameter settings files.
Simulations have different states, which are changed depending on
where in the lifecycle of the simulation it is. 
    UNASSIGNED -> ASSIGNED -> DONE    

Parameters varied in the galactose case are:
    (flow, L, y_sin, y_dis, y_cell, PP__gal)
Parameters are lists of triples, consisting of name, value and unit.
    

TODO: after creation of files these have to copied to the server, i.e
      mainly the sbml files
TODO: handle the deficiencies properly

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


def createGalactoseSimulationTask(model, N=10, gal_range=range(0,8), deficiencies=[0]):
    '''
    Create integration settings, the task and the simulations.
    Related to the Galactose simulations.
    '''
    # Get or create integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=200.0, 
                                                             tsteps=100,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
    if (created):
        print "Integration created: {}".format(integration)
    
    # Create the task
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    if (created):
        print "Task created: {}".format(task)
    info = '''Simulation of varying galactose concentrations periportal
     to steady state.'''
    task.info = info
    task.save()
    
    # get the parameter sets by sampling (same parameters for all galactose settings)
    # the same parameter sampling is used for all deficiencies
    all_pars = createParametersBySampling(N);
    for deficiency in deficiencies:
        for pars in all_pars:
            for galactose in gal_range:
                # make a copy !
                p = pars[:]
                p.append(('deficiency', deficiency, '-'))
                p.append(('PP__gal', galactose, 'mM'))
                createSimulationsFromParametersInTask(p, task)

def createDilutionCurvesSimulationTask(model, N=10):
    '''
    Create integration settings, the task and the simulations.
    '''
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
    info = '''Simulation of tracer peak periportal with resulting dilution curves.'''
    task.info = info
    task.save()
    
    # Create the parameters
    # pars = createParametersByManual();
    
    all_pars = createParametersBySampling(N);
    for p in all_pars:
        createSimulationsFromParametersInTask(p, task)
    
    
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



if __name__ == "__main__":
    # TODO: fix that model is created every time (is it ?)
    # Create the galactose model in the database
    # call the copySBML script afterwards, to transfer the
    # sbml to the computers.
    
    sbml_id = "Galactose_v8_Nc20_Nf1"   
    model = SBMLModel.create(sbml_id, SBML_FOLDER);
    model.save();
    if (1):
        # create the galactose simulations
        # if no deficiencies are set, only the normal case is simulated
        N = 5     # number of simulations per deficiency and galactose
        gal_range = np.arange(0, 6, 1.0)
        # createGalactoseSimulationTask(model, N, gal_range, deficiencies=[0])
        createGalactoseSimulationTask(model, N, gal_range, deficiencies=range(0,24))

    
    if (0):
        sbml_id = "Dilution_Curves_v8_Nc20_Nf1"
        model = SBMLModel.create(sbml_id, SBML_FOLDER);
        model.save();
        if (1):
            # create dilution simulations
            N = 2000     # number of simulations
            createDilutionCurvesSimulationTask(model, N)
        
