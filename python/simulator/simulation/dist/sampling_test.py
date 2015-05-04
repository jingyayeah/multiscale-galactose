'''
Testing for sampling from distributions generation.

@author: Matthias Koenig
@date: 2015-05-03
'''

import unittest
from sampling import _createSamplesByDistribution
# from sampling import _createSamplesByLHS
from sampling import _createSamplesByMean

class TestSampling(unittest.TestCase):

    def setUp(self):
        from distributions import getDemoDistributions, getGalactoseDistributions
        self.dist_demo = getDemoDistributions();
        self.dist_gal = getGalactoseDistributions()
        
    def tearDown(self):
        self.dist_data = None
        
    def test_demo_distribution(self):
        samples = _createSamplesByDistribution(self.dist_demo, N=5)
        self.assertEqual(len(samples), 5, 'check number samples')
        s = samples[0]
        self.assertIsNotNone(s['Vmax_b1'], 'check for parameter')

#     def test_LHS(self):
#         samples = _createSamplesByLHS(self.dist_data, N=7)
#         self.assertEqual(len(samples), 7, 'check number samples')
#         s = samples[0]
#         self.assertIsNotNone(s['L'], 'check for parameter')
        
    def test_mean(self):
        samples = _createSamplesByMean(self.dist_demo, N=1)
        self.assertEqual(len(samples), 1, 'check number samples')
        s = samples[0]
        self.assertIsNotNone(s['Vmax_b1'], 'check for parameter')
                
                
if __name__ == '__main__':
    unittest.main()