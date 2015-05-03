'''
Created on May 3, 2015

@author: mkoenig
'''

import unittest

from samples import Sample, SampleParameter
from sbmlsim.models import GLOBAL_PARAMETER

class TestSamples(unittest.TestCase):

    def setUp(self):
        self.p1 = SampleParameter(name='Vmax', value=2.17, unit='mole_per_s', ptype=GLOBAL_PARAMETER)
        self.p2 = SampleParameter(name='Km', value=0.1, unit='mM', ptype=GLOBAL_PARAMETER)        
      
    def tearDown(self):
        self.p1 = None
        self.p2 = None
        
    def test_add_parameters(self):
        sample = Sample()
        sample.add_parameter(self.p1)
        self.assertEqual(len(sample), 1, "1 SampleParameter in Sample")
        self.assertEqual(sample[self.p1.name], self.p1, "Parameter should be the parameter")
            

    def test_add_parameters_multi(self):
        ''' Multiple addition of SampleParameter should only contain it once. '''
        sample = Sample()
        sample.add_parameter(self.p1)
        sample.add_parameter(self.p1)
        self.assertEqual(len(sample), 1, "1 SampleParameter in Sample")
        self.assertEqual(sample[self.p1.name], self.p1, "Parameter should be the parameter")

    def test_sample_pars_attrs(self):
        self.assertEqual(self.p1.name, "Vmax", "test name")
        self.assertEqual(self.p1.value, 2.17, "test value")
        self.assertEqual(self.p1.unit, "mole_per_s", "test unit")
        self.assertEqual(self.p1.ptype, GLOBAL_PARAMETER, "test pytpe")
        
    def test_sample_pars_repr(self):
        self.assertEqual(self.p1.__repr__(), "<Vmax = 2.170 [mole_per_s] (GLOBAL_PARAMETER)>", 
                         "test_repr")
        
    def test_demo_samples(self):
        from simulation.demo.demo import create_demo_samples
        samples = create_demo_samples(N=1, sampling="distribution")
        s = samples[0]
        self.assertIsInstance(s, Sample, "Demo sample is Sample")
        keys =  s.keys()
        

if __name__ == '__main__':
    unittest.main()