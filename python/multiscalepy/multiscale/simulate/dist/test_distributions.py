"""
Test the distribution definitions.
"""
from __future__ import print_function, division
import unittest

from simapp.models import ParameterType

from distributions import Distribution, DistributionType, DistributionParameterType
from samples import SampleParameter


class TestDistributions(unittest.TestCase):
    def setUp(self):
        self.d1 = Distribution(
            DistributionType.NORMAL, {
                DistributionParameterType.MEAN: SampleParameter('Vmax_b1', 5.0, 'mole_per_s',
                                                                ParameterType.GLOBAL_PARAMETER),
                DistributionParameterType.STD: SampleParameter('Vmax_b1', 0.5, 'mole_per_s',
                                                               ParameterType.GLOBAL_PARAMETER),
                })
        
    def tearDown(self):
        self.d1 = None
        
    def test_constant(self):
        dist = Distribution(DistributionType.CONSTANT,
                            {DistributionParameterType.MEAN: SampleParameter('Km', 10.0, 'mM',
                                                                             ParameterType.GLOBAL_PARAMETER)})
        self.assertEqual(dist.distribution_type, DistributionType.CONSTANT, 'Test constant distribution type')
        self.assertEqual(len(dist.parameters), 1, 'Test constant number of parameters')
    
    def test_normal(self):
        self.assertEqual(self.d1.distribution_type, DistributionType.NORMAL, 'Test normal distribution')
    
    def test_normal_pars_mean(self):
        p = self.d1.parameters[DistributionParameterType.MEAN]
        self.assertEqual(p.key, 'Vmax_b1', 'Test parameter key')
        self.assertEqual(p.value, 5.0, 'Test parameter value')
        self.assertEqual(p.unit, 'mole_per_s', 'Test parameter unit')
        self.assertEqual(p.parameter_type, ParameterType.GLOBAL_PARAMETER, 'Test parameter parameter_type')
    
    def test_normal_pars_std(self):
        p = self.d1.parameters[DistributionParameterType.STD]
        self.assertEqual(p.key, 'Vmax_b1', 'Test parameter key')
        self.assertEqual(p.value, 0.5, 'Test parameter value')
        self.assertEqual(p.unit, 'mole_per_s', 'Test parameter unit')
        self.assertEqual(p.parameter_type, ParameterType.GLOBAL_PARAMETER, 'Test parameter parameter_type')
        
    def test_key(self):
        self.assertEqual(self.d1.key, 'Vmax_b1', 'Test key of parameters.')
        
    def test_unit(self):
        self.assertEqual(self.d1.unit, 'mole_per_s', 'Test unit of parameters.')
        
    def test_parameter_type(self):
        self.assertEqual(self.d1.parameter_type, ParameterType.GLOBAL_PARAMETER, 'Test parameter_type of parameters.')
    
    def test_mean(self):
        self.assertEqual(self.d1.mean(), 5.0, 'Test mean of distribution')
        
    def test_samples(self):
        samples = self.d1.samples(n_samples=10)
        self.assertEqual(len(samples), 10, 'Test sample creation')


if __name__ == '__main__':
    unittest.main()
