'''
Testing for distribution definitions.

@author: Matthias Koenig
@date: 2015-05-03
'''
import unittest
from distributions import Dist, DistType

class TestDistributions(unittest.TestCase):

    def setUp(self):
        pass
    def tearDown(self):
        pass
        
    def test_constant(self):
        dtype = DistType.CONSTANT
        pars = {'mean' : {'name': 'Km',
                          'value': 10.0,
                          'unit': 'mM'}}
        dist = Dist(dtype, pars)
        
        self.assertEqual(dist.dtype, DistType.CONSTANT, 'Test constant distribution type')
        self.assertEqual(len(dist.pars), 1, 'Test constant number of parameters')
                
if __name__ == '__main__':
    unittest.main()