'''
Created on March 20, 2014
@author: Matthias Koenig

Simulations in C++ (CopasiModelSimulator) are called with SBML file
& file of parameter settings.
The SimulationFactory generates sets of parameters and simulations.

UNASSIGNED simulations can be taken by processors and be performed.
'''

import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
import numpy as np
from sim.models import *
from django.db.models import Count

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


def createDilutionCurvesSimulationTask(sbml_id, folder):
    '''
        Create the SBMLModel and the respective simulations.
        
    '''
    # Get or create the model
    model = SBMLModel.create(sbml_id, folder);
    model.save();
    print 'name: ' + model.file.name
    print 'path: ' + model.file.path
    print 'url: '  + model.file.url
    
    # Get or create integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=100.0, 
                                                             tsteps=1000,
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
    
    # Careful with creating objects again and again
    # Get the parameter collection which contains all the parameters in the list
    # Here every time a new Parameter collection is created
    # TODO: ?? What does this mean, understand
    '''
    pars = (('deficiency', 0, '-'),
            ('flow', 60E-6, 'm/s'),
            ('L',   500E-6, 'm'),)
    createSimulationForParametersInTask(pars, task);
    pars = (('deficiency', 0, '-'),
            ('flow_sin', 200E-6, 'm/s'),
            ('L',   200E-6, 'm'),)
    createSimulationForParametersInTask(pars, task);
    '''
  
    # what parameters should be sampled
    # TODO: write sampler from the distributions
    flows = np.arange(0.0, 600E-6, 30E-6)
    lengths = np.arange(200E-6, 600E-6, 200E-6)
    for flow_sin in flows:
        for L in lengths: 
            pars = (('flow_sin', flow_sin, 'm/s'),
                    ('L',   L, 'm'),)
            createSimulationForParametersInTask(pars, task);


if __name__ == "__main__":
    # remove all simulations
    print "Deleting all simulations !!!"
    Simulation.objects.all().delete()
    
    # create new simulations for SBML with sbml_id 
    folder = "/home/mkoenig/multiscale-galactose-results/test"
    sbml_id = "Dilution_Curves_v4_Nc20_Nf1"
    createDilutionCurvesSimulationTask(sbml_id, folder)
    