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
from subprocess import call
import shlex
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
import numpy as np
from sim.models import *
from django.db.models import Count
import numpy.random as npr
from analysis.AnalysisTools import createParameterFileForTask
from RandomSampling import createSamplesByDistribution, createSamplesByLHS


def createGalactoseSimulationTask(model, N=10, gal_range=range(0,8), deficiencies=[0], sampling='LHS'):
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
    samples = createParametersBySampling(N, sampling);
    for deficiency in deficiencies:
        for s in samples:
            for galactose in gal_range:
                # make a copy !
                snew = s[:]
                snew.append(('deficiency', deficiency, '-'))
                snew.append(('PP__gal', galactose, 'mM'))
                createSimulationForParameterSample(task, sample=snew)

def createMultipleIndicatorSimulationTask(model, N=10, sampling="LHS"):
    ''' Create integration settings, the task and the simulations. '''
    # integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=500.0, 
                                                             tsteps=2000,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
    if (created):
        print "Integration created: {}".format(integration)
    
    # task
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    if (created):
        print "Task created: {}".format(task)
    info = '''Simulation of multiple-indicator dilution curves (tracer peak periportal)'''
    task.info = info
    task.save()
    
    # simulations
    samples = createParametersBySampling(N, sampling);
    for s in samples:
        createSimulationForParameterSample(task=task, sample=s)
        
    return task;

def createParametersBySampling(N, sampling):
    if (sampling == "distribution"):
        samples = createSamplesByDistribution(N);
    elif (sampling == "LHS"):
        samples = createSamplesByLHS(N);
    elif (sampling == "mixed"):
        samples = createSamplesByDistribution(N/2);
        samples = createSamplesByLHS(N/2);
    
    return samples


def createSimulationForParameterSample(task, sample):
    ''' 
    Create the single Parameters, the combined ParameterCollection
    and the simulation based on the Parametercollection for the
    iterable sample, which contains triples of (name, value, unit).
    # TODO: write a whole set of simulations at once. 
    # TODO: This part is very inefficient and not completely clear what
    #        is happening here.
    '''
    ps = []
    for data in sample:
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
            # TODO: Do something based on the errors contained in e.message_dict.
            # Display them to a user, or deal with them properly.
            pass


if __name__ == "__main__":
    # TODO: automatically call the shell script
    # After new models are generated this have to be copied 
    # to the target machines = > call the copySBML script before 
    # starting the cores to listen
    results_dir = "/home/mkoenig/multiscale-galactose-results"
    code_dir = "/home/mkoenig/multiscale-galactose"
   
    if (1):
    # Generate the MultipleIndicator Simulations
    # for the different peak length of the tracer
        for kp in range(0,5):
            sbml_id = "MultipleIndicator_P%02d_v14_Nc20_Nf1" % kp
            model = SBMLModel.create(sbml_id, SBML_FOLDER);
            model.save();
            if (1):
                # create dilution simulations
                task = createMultipleIndicatorSimulationTask(model, N=500, sampling="distribution") 
                createParameterFileForTask(results_dir, task);
   
    if (0):
        # Create the galactose model
        sbml_id = "Galactose_v11_Nc20_Nf1"   
        model = SBMLModel.create(sbml_id, SBML_FOLDER);
        model.save();
        # create the galactose simulations
        # if no deficiencies are set, only the normal case is simulated
        N = 45     # number of simulations per deficiency and galactose
        gal_range = np.arange(0, 6, 1.0)
        # createGalactoseSimulationTask(model, N, gal_range, deficiencies=[0])
        createGalactoseSimulationTask(model, N, gal_range, deficiencies=range(1,24))

    # run an operating system command
    # call(["ls", "-l"])
    # call_command = [code_dir + '/' + "copySBML.sh"]
    # print call_command
    # call(call_command)
