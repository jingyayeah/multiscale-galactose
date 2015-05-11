"""
Testing for sampling from distributions generation.

@author: Matthias Koenig
@date: 2015-05-03
"""

import unittest
from odesim.dist.sampling import sample_from_distribution, sample_from_mean
from odesim.dist.examples import Demo


class TestSampling(unittest.TestCase):

    def setUp(self):
        self.dist_demo = Demo.get_distributions()
        
    def tearDown(self):
        self.dist_data = None
        
    def test_demo_distribution(self):
        samples = sample_from_distribution(self.dist_demo, n_samples=5)
        self.assertEqual(len(samples), 5, 'check number samples')
        s = samples[0]
        self.assertIsNotNone(s['Vmax_b1'], 'check for parameter')

#     def test_LHS(self):
#         samples = _createSamplesByLHS(self.dist_data, N=7)
#         self.assertEqual(len(samples), 7, 'check number samples')
#         s = samples[0]
#         self.assertIsNotNone(s['L'], 'check for parameter')
        
    def test_mean(self):
        samples = sample_from_mean(self.dist_demo, n_samples=1)
        self.assertEqual(len(samples), 1, 'check number samples')
        s = samples[0]
        self.assertIsNotNone(s['Vmax_b1'], 'check for parameter')
                
                
if __name__ == '__main__':
    unittest.main()