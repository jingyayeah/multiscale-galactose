'''
Creating simulations for the demo network.

@author: Matthias Koenig
@date: 2015-05-05
'''
from __future__ import print_function

from simapp.models import Setting, Integration

from odesim.dist.distributions import getDemoDistributions
from odesim.dist.sampling import createParametersBySampling, SamplingType
from odesim.dist.samples import createSimulationsForSamples

from odesim.db.db_tools import sbmlmodel_from_file 
from odesim.db.db_tools import create_task


def create_demo_samples(N, sampling_type):
    distributions = getDemoDistributions()
    return createParametersBySampling(distributions, N, sampling_type);


def demo_simulations(model, N, priority=0):
    info='Simple demo network based on parameter distributions.'
    
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
    # Simple demo network to test basic odesim capabilities.
    # TODO: remove simulations & model -> cleanup
    import django
    django.setup()
            
    if (1):
        print('make demo from file')
        model = sbmlmodel_from_file(sbml_file='../../examples/demo/Koenig_demo.xml', sync=False)
        sims = demo_simulations(model, N=1000)
        