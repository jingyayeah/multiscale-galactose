"""
Creating example simulations for the demo network.

"""
from __future__ import print_function

import simapp.db.api as db_api

import odesim.db.tools as db_tools
from odesim.dist.distributions import Distribution, DistributionType, DistributionParameterType
from odesim.models.examples import Example
from odesim.dist.sampling import Sampling, SamplingType, SampleParameter


class Demo(Example):
    file_path = 'demo/demo/Koenig_demo.xml'
    model_format = db_api.CompModelFormat.SBML

    @classmethod
    def example_distributions(cls):
        """ Example distributions for demo network.
            Definition of two lognormal distributions for Vmax_b1 and Vmax_b2.
        """
        d1 = Distribution(DistributionType.LOGNORMAL, {
            DistributionParameterType.MEAN: SampleParameter('Vmax_b1', 5.0, 'mole_per_s',
                                                            db_api.ParameterType.GLOBAL_PARAMETER),
            DistributionParameterType.STD: SampleParameter('Vmax_b1', 0.5, 'mole_per_s',
                                                           db_api.ParameterType.GLOBAL_PARAMETER),
        })

        d2 = Distribution(DistributionType.LOGNORMAL, {
            DistributionParameterType.MEAN: SampleParameter('Vmax_b2', 2.0, 'mole_per_s',
                                                            db_api.ParameterType.GLOBAL_PARAMETER),
            DistributionParameterType.STD: SampleParameter('Vmax_b2', 0.4, 'mole_per_s',
                                                           db_api.ParameterType.GLOBAL_PARAMETER)
        })
        return d1, d2

    @classmethod
    def example_samples(cls, n_samples):
        # Sample from defined distributions
        distributions = cls.example_distributions()
        sampling = Sampling(distributions=distributions, sampling_type=SamplingType.DISTRIBUTION)
        samples = sampling.sample(n_samples)
        return samples

    @classmethod
    def example_simulations(cls, n_samples):
        """ Creates the database objects for the simulations.

        :param n_samples:
        :return:
        """
        # model from example file
        model = db_api.create_model(cls.file_path, model_format=cls.model_format)

        # example samples
        samples = cls.example_samples(n_samples)

        # simulations
        settings = {db_api.SettingKey.T_START: 0.0,
                    db_api.SettingKey.T_END: 20.0,
                    db_api.SettingKey.STEPS: 200
                    }
        settings = db_api.create_settings(settings_dict=settings)
        method = db_api.create_method(method_type=db_api.MethodType.ODE,
                                      settings=settings)

        info = 'Simple demo network based on parameter distributions.'
        task = db_api.create_task(model=model, method=method, info=info)
        simulations = db_tools.create_simulations_from_samples(task, samples)
        print(simulations)
        return simulations


if __name__ == "__main__":
    import django
    django.setup()
    Demo.file_path = '../../demo/demo/Koenig_demo.xml'
    Demo.example_simulations(20)
