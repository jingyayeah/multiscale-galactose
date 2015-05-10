"""
Creating simulations for the demo network.

@author: Matthias Koenig
@date: 2015-05-05
"""
from __future__ import print_function

from simapp.models import SettingKey, MethodType, CompModelFormat
import simapp.db.api as db_api

import odesim.db.tools as db_tools

from odesim.dist.distributions import getDemoDistributions
from odesim.dist.sampling import sample_parameters, SamplingType


def demo_simulations(comp_model, n_samples):
    info = 'Simple demo network based on parameter distributions.'
    
    # parameter samples
    samples = create_demo_samples(n_samples=n_samples, sampling_type=SamplingType.DISTRIBUTION)
    
    # simulations
    settings = {SettingKey.T_START: 0.0,
                SettingKey.T_END: 500.0,
                SettingKey.STEPS: 100
                }
    method = db_api.create_method_from_settings(method_type=MethodType.ODE,
                                                settings_dict=settings)

    task = db_api.create_task(comp_model, method, info)
    simulations = db_tools.create_simulations_for_samples(task, samples)
    return simulations


def create_demo_samples(n_samples, sampling_type):
    """ Create demo samples base on the given sampling type.

    :param n_samples:
    :param sampling_type:
    :return:
    """
    distributions = getDemoDistributions()
    return sample_parameters(distributions, n_samples, sampling_type)


if __name__ == "__main__":    
    # Simple demo network to test basic simulation capabilities.
    import django
    django.setup()
            
    if True:
        print('make demo from file')
        model = db_api.create_model(file_path='../../examples/demo/Koenig_demo.xml',
                                    model_format=CompModelFormat.SBML)
        sims = demo_simulations(model, n_samples=10)