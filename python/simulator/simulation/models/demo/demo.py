'''


Created on May 3, 2015

@author: mkoenig
'''
from __future__ import print_function

from sbmlsim.models import Setting, Integration

from simulator.dist.distributions import getDemoDistributions
from simulator.dist.sampling import createParametersBySampling, SamplingType
from simulator.dist.samples import createSimulationsForSamples

from simulation.SimulationFactory import django_model_from_id, django_model_from_file 
from simulation.SimulationFactory import create_task


def create_demo_samples(N, sampling_type):
    distributions = getDemoDistributions()
    return createParametersBySampling(distributions, N, sampling_type);


def demo_simulations(model, N, priority=0):
    info='Simple demo network to test database and simulations.'
    
    # parameter samples
    samples = create_demo_samples(N=N, sampling_type=SamplingType.DISTRIBUTION)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':500.0, 'steps':100} )
    integration = Integration.get_or_create_integration(settings)
    task = create_task(model, integration, info, priority)
    sims = createSimulationsForSamples(task, samples)
    return sims


####################################################################################
if __name__ == "__main__":    
    # Simple demo network to test basic simulation capabilities.
    # TODO: remove simulations & model -> cleanup
    import django
    django.setup()
    
    if (1):
        print('make demo from id')
        model = django_model_from_id(sbml_id='Koenig2014_demo_kinetic_v7', sync=False)
        sims = demo_simulations(model, N=10, priority=10)
        # TODO: remove simulations & model -> cleanup
        
    if (1):
        print('make demo from file')
        model = django_model_from_file(sbml_file='../../examples/Koenig_demo.xml', sync=False)
        sims = demo_simulations(model, N=10, priority=10)
        
       
        
