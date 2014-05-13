'''
The SimulationFactory generates simulations for the models.
The parameters for the simulations are generated by various sampling
methods. Every simulation has a set of paramters.

Simulations can than be run with COPASI based on the SBML model and
the parameter settings files.

Parameters are lists of triples, consisting of name, value and unit.
    
TODO: after creation of files these have to copied to the server, i.e
      mainly the sbml files
TODO: handle the deficiencies properly

@author: Matthias Koenig
@date: 2014-03-14
'''
import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

from django.db.models import Count
from sim.models import *
from RandomSampling import *
from Distributions import *

# here the local sbml files are located
SBML_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sbml"


def createGalactoseSimulationTask(model, gal_range, flow_range, N=1, deficiencies=[0], sampling='mean'):
    ''' Galactose simulations '''
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=200.0, 
                                                             tsteps=100,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
    # Create the task
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    info = '''Simulation of varying galactose concentrations periportal to steady state.'''
    task.info = info
    task.save()
    
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
                    snew['deficiency'] = ('deficiency', deficiency, '-')
                    snew['PP_gal'] = ('PP__gal', galactose, 'mM')
                    snew['flow_sin'] = ('flow_sin', flow, 'm/s')
                    createSimulationForParameterSample(task, sample=snew)


def createMultipleIndicatorSimulationTask(model, N=10, sampling="LHS"):
    ''' Create integration settings, the task and the simulations. '''
    # integration
    integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=100.0, 
                                                             tsteps=4000,
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
    dist_data = getMultipleIndicatorDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);
    for s in samples:
        createSimulationForParameterSample(task=task, sample=s)
        
    return task;

def createParametersBySampling(dist_data, N, sampling):
    if (sampling == "distribution"):
        samples = createSamplesByDistribution(dist_data, N);
    elif (sampling == "LHS"):
        samples = createSamplesByLHS(dist_data, N);
    elif (sampling == "mean"):
        samples = createSamplesByMean(dist_data, N);
    elif (sampling == "mixed"):
        samples1 = createSamplesByDistribution(dist_data, N/2);
        samples2 = createSamplesByLHS(dist_data, N/2);
        samples = samples1 + samples2
    return samples


def createSimulationForParameterSample(task, sample):
    ''' 
    Create the single Parameters, the combined ParameterCollection
    and the simulation based on the Parametercollection for the
    iterable sample, which contains triples of (name, value, unit).
    '''
    # Create the parameters
    ps = []
    for data in sample.values():
        name, value, unit = data
        p, created = Parameter.objects.get_or_create(name=name, value=value, unit=unit);
        ps.append(p)
    # create the parameter collection
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


def createDemoTask(model, integration, N=10, sampling='distribution'):
    '''
    Creates simple demo simulation to test the network visualization.
    '''    
    # Create the task
    task, created = Task.objects.get_or_create(sbml_model=model, integration=integration)
    if (created):
        print "Task created: {}".format(task)
    info = '''Simulation of the demo network for visualization.'''
    task.info = info
    task.save()
    
    # get the parameter sets by sampling (same parameters for all galactose settings)
    # the same parameter sampling is used for all deficiencies
    dist_data = getDemoDistributions()
    samples = createParametersBySampling(dist_data, N, sampling);
    for s in samples:
        createSimulationForParameterSample(task, sample=s)
    return task



###################################################################################
if __name__ == "__main__":
    # TODO: automatically call the shell script
    # After new models are generated this have to be copied 
    # to the target machines = > call the copySBML script before 
    # starting the cores to listen
    results_dir = "/home/mkoenig/multiscale-galactose-results"
    code_dir = "/home/mkoenig/multiscale-galactose"
   
    # Generate demo network & simulations for visualization
    if (0):
        sbml_id = "Koenig2014_demo_kinetic_v7" 
        model = SBMLModel.create(sbml_id, SBML_FOLDER);
        model.save();
        # Get or create integration
        integration, created = Integration.objects.get_or_create(tstart=0.0, 
                                                             tend=100.0, 
                                                             tsteps=2000,
                                                             abs_tol=1E-6,
                                                             rel_tol=1E-6)
        if (0):
            task = createDemoTask(model, integration, N=200, sampling="distribution") 

   
    if (1):
    # Generate the MultipleIndicator Simulations
    # for the different peak length of the tracer
        peaks = range(0,4)
        for kp in peaks:
            sbml_id = "MultipleIndicator_P%02d_v17_Nc20_Nf1" % kp
            model = SBMLModel.create(sbml_id, SBML_FOLDER);
            model.save();
        # TODO: copy the SBML to the servers
        if (1):
            for kp in peaks:            
                # create dilution simulations
                task = createMultipleIndicatorSimulationTask(model, N=1000, sampling="distribution") 
   
    if (0):
        # Create the galactose model
        sbml_id = "Galactose_v16_Nc20_Nf1"   
        model = SBMLModel.create(sbml_id, SBML_FOLDER);
        model.save();
        if (1):
            gal_range = np.arange(0, 6, 0.5)
            flow_range = np.arange(0, 1000E-6, 200E-6)
            createGalactoseSimulationTask(model, gal_range, flow_range, N=1, deficiencies=[0,])

    # TODO
    # run an operating system command
    # call(["ls", "-l"])
    # call_command = [code_dir + '/' + "copySBML.sh"]
    # print call_command
    # call(call_command)
