"""
Testing the distribution examples.
"""

# TODO: implement the Galactose examples
from __future__ import print_function, division
import unittest
import django
django.setup()

from simapp.models import ParameterType
from ..dist.sampling import Sampling
from ..dist.distributions import DistributionType, DistributionParameterType
from demo.demo import Demo


class ExampleTestCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_demo_distributions(self):
        """
        d1 = Distribution(DistributionType.LOGNORMAL, {
            DistributionParameterType.MEAN: SampleParameter('Vmax_b1', 5.0, 'mole_per_s',
                                                            ParameterType.GLOBAL_PARAMETER),
            DistributionParameterType.STD: SampleParameter('Vmax_b1', 0.5, 'mole_per_s',
                                                           ParameterType.GLOBAL_PARAMETER),
        })

        d2 = Distribution(DistributionType.LOGNORMAL, {
            DistributionParameterType.MEAN: SampleParameter('Vmax_b2', 2.0, 'mole_per_s',
                                                            ParameterType.GLOBAL_PARAMETER),
            DistributionParameterType.STD: SampleParameter('Vmax_b2', 0.4, 'mole_per_s',
                                                           ParameterType.GLOBAL_PARAMETER)
        })
        """
        d1, d2 = Demo.example_distributions()
        self.assertEqual(d1.distribution_type, DistributionType.LOGNORMAL)
        p1 = d1.parameters[DistributionParameterType.MEAN]
        p2 = d1.parameters[DistributionParameterType.STD]

        self.assertEqual(p1.key, 'Vmax_b1')
        self.assertEqual(p1.value, 5.0)
        self.assertEqual(p1.unit, 'mole_per_s')
        self.assertEqual(p1.parameter_type, ParameterType.GLOBAL_PARAMETER)

        self.assertEqual(p2.key, 'Vmax_b1')
        self.assertEqual(p2.value, 0.5)
        self.assertEqual(p2.unit, 'mole_per_s')
        self.assertEqual(p2.parameter_type, ParameterType.GLOBAL_PARAMETER)

        self.assertEqual(d2.distribution_type, DistributionType.LOGNORMAL)
        p3 = d2.parameters[DistributionParameterType.MEAN]
        p4 = d2.parameters[DistributionParameterType.STD]

        self.assertEqual(p3.key, 'Vmax_b2')
        self.assertEqual(p3.value, 2.0)
        self.assertEqual(p3.unit, 'mole_per_s')
        self.assertEqual(p3.parameter_type, ParameterType.GLOBAL_PARAMETER)

        self.assertEqual(p4.key, 'Vmax_b2')
        self.assertEqual(p4.value, 0.4)
        self.assertEqual(p4.unit, 'mole_per_s')
        self.assertEqual(p4.parameter_type, ParameterType.GLOBAL_PARAMETER)

    def test_demo_samples(self):
        distributions = Demo.example_distributions()
        sampling = Sampling(distributions)
        samples = sampling.sample(n_samples=10)
        self.assertEqual(len(samples), 10)


if __name__ == '__main__':
    unittest.main()
