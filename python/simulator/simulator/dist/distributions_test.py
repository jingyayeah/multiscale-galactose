'''
Testing for distribution definitions.

@author: Matthias Koenig
@date: 2015-05-03
'''
import unittest
from distributions import Dist, DistType, DistParsType
from samples import SampleParameter
from sbmlsim.models import GLOBAL_PARAMETER

class TestDistributions(unittest.TestCase):

    def setUp(self):
        self.d1 = Dist(DistType.NORMAL, {
                    DistParsType.MEAN : SampleParameter('Vmax_b1', 5.0, 'mole_per_s', GLOBAL_PARAMETER),
                    DistParsType.STD : SampleParameter('Vmax_b1', 0.5, 'mole_per_s', GLOBAL_PARAMETER),
                    })
        
    def tearDown(self):
        self.d1 = None
        
    def test_constant(self):
        dist = Dist(DistType.CONSTANT, {DistParsType.MEAN : SampleParameter('Km', 10.0, 'mM', GLOBAL_PARAMETER) })
        self.assertEqual(dist.dtype, DistType.CONSTANT, 'Test constant distribution type')
        self.assertEqual(len(dist.pars), 1, 'Test constant number of parameters')
    
    def test_normal(self):
        self.assertEqual(self.d1.dtype, DistType.NORMAL, 'Test normal distribution')
    
    def test_normal_pars_mean(self):
        p = self.d1.pars[DistParsType.MEAN]
        self.assertEqual(p.key, 'Vmax_b1', 'Test parameter key')
        self.assertEqual(p.value, 5.0, 'Test parameter value')
        self.assertEqual(p.unit, 'mole_per_s', 'Test parameter unit')
        self.assertEqual(p.ptype, GLOBAL_PARAMETER, 'Test parameter ptype')
    
    def test_normal_pars_std(self):
        p = self.d1.pars[DistParsType.STD]
        self.assertEqual(p.key, 'Vmax_b1', 'Test parameter key')
        self.assertEqual(p.value, 0.5, 'Test parameter value')
        self.assertEqual(p.unit, 'mole_per_s', 'Test parameter unit')
        self.assertEqual(p.ptype, GLOBAL_PARAMETER, 'Test parameter ptype')
    
       
if __name__ == '__main__':
    unittest.main()