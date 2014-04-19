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
from analysis.AnalysisTools import createParameterFileForTask


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

def createMultipleIndicatorSimulationTask(model, N=10):
    '''
    Create integration settings, the task and the simulations.
    '''
    # Get or create integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=500.0, 
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
        
    return task;
    
    
def createParametersBySampling(N=100):
    '''
    Samples N values from lognormal distribution defined by the 
    given means and standard deviations.
    Here the data is generated.
    ! Here the experimental data has to be hardcoded !
    To set the seed of the random generator use: numpy.random.seed(42)
    

            name     mean      std unit   meanlog meanlog_error     sdlog sdlog_error scale_fac scale_unit
L               L 5.00e-04 1.25e-04    m 6.1842958            NA 0.2462207          NA     1e+06         mum
y_sin       y_sin 4.40e-06 4.50e-07    m 1.4652733    0.01027471 0.1017145 0.007265321     1e+06         mum
y_dis       y_dis 1.20e-06 4.00e-07    m 0.1296413            NA 0.3245928          NA     1e+06         mum
y_cell     y_cell 7.58e-06 1.25e-06    m 1.9769003    0.01404165 0.1390052 0.009928946     1e+06         mum
flow_sin flow_sin 2.70e-04 5.80e-05  m/s 5.4572075    0.02673573 0.6178210 0.018905015     1e+06       mum/s
    '''
    names = ['L', 'y_sin', 'y_dis', 'y_cell', 'flow_sin']
    meanlog = [6.1842958 , 1.4652733, 0.1296413, 1.9769003, 5.4572075 ]
    stdlog  = [0.2462207, 0.1017145, 0.3245928, 0.1390052 , 0.6178210]
    units = ['m', 'm' ,'m', 'm', 'm/s']
    
    all_pars = [];
    for kn in xrange(N):
        # create parameters
        pars = []
        for kp in range(len(names)):
            # m = means[kp]
            # std = stds[kp]
            # parameters are lognormal distributed 
            # mu = math.log(m**2 / math.sqrt(std**2+m**2));
            # sigma = math.sqrt(math.log(std**2/m**2 + 1));
            mu = meanlog[kp]
            sigma = stdlog[kp]
            # The fit parameter are for mum and mum/s, but parameters for the 
            # ode have to be provided in m and m/s.
            value = npr.lognormal(mu, sigma) * 1E-6   
            pars.append( (names[kp], value, units[kp]) )
            
        all_pars.append(pars)
    return all_pars

def createParametersByManual():
    ''' Manual parameter creation.
        TODO: parameters are hard coded ! change to one global position
    '''
    all_pars = []
    # what parameters should be sampled
    flows = np.arange(0.0, 600E-6, 60E-6)
    lengths = np.arange(400E-6, 600E-6, 100E-6)    
    for flow_sin in flows:
        for L in lengths: 
            p = (
                    ('y_cell', 7.58E-6, 'm'),
                    ('y_dis', 1.2E-6, 'm'),
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
    # After new models are generated this have to be copied 
    # to the target machines = > call the copySBML script before 
    # starting the cores to listen
   
    if (1):
    # Generate the MultipleIndicator Simulations
    # for the different peak length of the tracer
        for kp in range(0,5):
            sbml_id = "MultipleIndicator_P%02d_v10_Nc20_Nf1" % kp
            model = SBMLModel.create(sbml_id, SBML_FOLDER);
            model.save();
            if (0):
                # create dilution simulations
                N = 100     # number of simulations
                task = createMultipleIndicatorSimulationTask(model, N)
                # create the parameter file
                folder = "/home/mkoenig/multiscale-galactose-results"
                createParameterFileForTask(folder, task);
   
    if (0):
        # Create the galactose model
        sbml_id = "Galactose_v8_Nc20_Nf1"   
        model = SBMLModel.create(sbml_id, SBML_FOLDER);
        model.save();
        # create the galactose simulations
        # if no deficiencies are set, only the normal case is simulated
        N = 45     # number of simulations per deficiency and galactose
        gal_range = np.arange(0, 6, 1.0)
        # createGalactoseSimulationTask(model, N, gal_range, deficiencies=[0])
        createGalactoseSimulationTask(model, N, gal_range, deficiencies=range(1,24))

    

        
