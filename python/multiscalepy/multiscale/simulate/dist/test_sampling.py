"""
Testing the sampling of parameters from distributions.
"""

from __future__ import print_function, division
import unittest

import sampling as samp
from multiscale.simulate.analysis.demo.demo import Demo


class TestSampling(unittest.TestCase):
    def setUp(self):
        self.distributions = Demo.example_distributions()
        
    def tearDown(self):
        self.dist_data = None
        
    def test_demo_distribution(self):
        sampling = samp.Sampling(distributions=self.distributions,
                                 sampling_type=samp.SamplingType.DISTRIBUTION)
        samples = sampling.sample(n_samples=5)
        self.assertEqual(len(samples), 5, 'check number samples')
        s = samples[0]
        self.assertIsNotNone(s['Vmax_b1'], 'check for parameter')

#     def test_LHS(self):
#         samples = _createSamplesByLHS(self.dist_data, N=7)
#         self.assertEqual(len(samples), 7, 'check number samples')
#         s = samples[0]
#         self.assertIsNotNone(s['L'], 'check for parameter')
        
    def test_mean(self):
        sampling = samp.Sampling(distributions=self.distributions,
                                 sampling_type=samp.SamplingType.MEAN)
        samples = sampling.sample(n_samples=2)
        self.assertEqual(len(samples), 2, 'check number samples')
        s0 = samples[0]
        s1 = samples[1]
        self.assertIsNotNone(s0['Vmax_b1'], 'check for parameter')
        # check that samples are identical
        self.assertIsNotNone(s0['Vmax_b1'].unit, s1['Vmax_b1'].unit)
        self.assertIsNotNone(s0['Vmax_b1'].value, s1['Vmax_b1'].value)
        self.assertIsNotNone(s0['Vmax_b1'].key, s1['Vmax_b1'].key)
        self.assertIsNotNone(s0['Vmax_b1'].parameter_type, s1['Vmax_b1'].parameter_type)


if __name__ == '__main__':
    unittest.main()
