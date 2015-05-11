"""
Testing the distribution examples.

@author: 'mkoenig'
@date: 2015-05-11
"""
# TODO: implement the Galactose tests

import unittest
from simapp.models import ParameterType
from odesim.dist import sampling
from odesim.dist.distributions import DistributionType, DistributionParameterType
from odesim.dist.examples import Demo, GalactoseFlow




class MyTestCase(unittest.TestCase):
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
        d1, d2 = Demo.get_distributions()
        self.assertEqual(d1.distribution_type, DistributionType.LOGNORMAL)

        # ???
        self.assertEqual(d1.distribution_type, DistributionParameterType.MEAN)
        self.assertIsNotNone(d1[DistributionParameterType.STD])
        self.assertEqual(d1[DistributionParameterType.STD].key, 'Vmax_b1')
        self.assertEqual(d1[DistributionParameterType.STD].value, 5.0)
        self.assertEqual(d1[DistributionParameterType.STD].unit, 'mole_per_s')
        self.assertEqual(d1[DistributionParameterType.STD].parameter_type, ParameterType.GLOBAL_PARAMETER)

        self.assertEqual(d1[DistributionParameterType.MEAN].key, 'Vmax_b1')
        self.assertEqual(d1[DistributionParameterType.MEAN].value, 0.5)
        self.assertEqual(d1[DistributionParameterType.MEAN].unit, 'mole_per_s')
        self.assertEqual(d1[DistributionParameterType.MEAN].parameter_type, ParameterType.GLOBAL_PARAMETER)

        self.assertEqual(d2.distribution_type, DistributionType.LOGNORMAL)
        self.assertIsNotNone(d2[DistributionParameterType.MEAN])
        self.assertIsNotNone(d2[DistributionParameterType.STD])
        self.assertEqual(d2[DistributionParameterType.STD].key, 'Vmax_b2')
        self.assertEqual(d2[DistributionParameterType.STD].value, 2.0)
        self.assertEqual(d2[DistributionParameterType.STD].unit, 'mole_per_s')
        self.assertEqual(d2[DistributionParameterType.STD].parameter_type, ParameterType.GLOBAL_PARAMETER)

        self.assertEqual(d2[DistributionParameterType.STD].key, 'Vmax_b2')
        self.assertEqual(d2[DistributionParameterType.STD].value, 0.4)
        self.assertEqual(d2[DistributionParameterType.STD].unit, 'mole_per_s')
        self.assertEqual(d2[DistributionParameterType.STD].parameter_type, ParameterType.GLOBAL_PARAMETER)

    def test_demo_samples(self):
        distributions = Demo.get_distributions()
        samples = sampling.sample_from_distribution(distributions, n_samples=10)
        self.assertEqual(len(samples), 10)

if __name__ == '__main__':
    unittest.main()
