'''
Created on May 3, 2015

@author: mkoenig
'''

import unittest

from samples import Sample, SampleParameter
from sampling import SamplingType
from sbmlsim.models import ParameterType

class TestSamples(unittest.TestCase):

    def setUp(self):
        self.p1 = SampleParameter(key='Vmax', value=2.17, unit='mole_per_s', ptype=ParameterType.GLOBAL_PARAMETER)
        self.p2 = SampleParameter(key='Km', value=0.1, unit='mM', ptype=ParameterType.GLOBAL_PARAMETER)        
      
    def tearDown(self):
        self.p1 = None
        self.p2 = None
        
    def test_add_parameters(self):
        sample = Sample()
        sample.add_parameter(self.p1)
        self.assertEqual(len(sample), 1, "1 SampleParameter in Sample")
        self.assertEqual(sample[self.p1.key], self.p1, "Parameter should be the parameter")
            

    def test_add_parameters_multi(self):
        ''' Multiple addition of SampleParameter should only contain it once. '''
        sample = Sample()
        sample.add_parameter(self.p1)
        sample.add_parameter(self.p1)
        self.assertEqual(len(sample), 1, "1 SampleParameter in Sample")
        self.assertEqual(sample[self.p1.key], self.p1, "Parameter should be the parameter")

    def test_sample_pars_attrs(self):
        self.assertEqual(self.p1.key, "Vmax", "test key")
        self.assertEqual(self.p1.value, 2.17, "test value")
        self.assertEqual(self.p1.unit, "mole_per_s", "test unit")
        self.assertEqual(self.p1.ptype, ParameterType.GLOBAL_PARAMETER, "test pytpe")
        
    def test_sample_pars_repr(self):
        self.assertEqual(self.p1.__repr__(), "<Vmax = 2.170E+00 [mole_per_s] (ParameterType.GLOBAL_PARAMETER)>", 
                         "test_repr")
        
    def test_demo_samples(self):
        from odesim.models.demo import create_demo_samples
        samples = create_demo_samples(N=1, sampling_type=SamplingType.DISTRIBUTION)
        s = samples[0]
        self.assertIsInstance(s, Sample, "Demo sample is Sample")
        
    def test_fromparameters1(self):
        ''' Create SampleParameter from SampleParameter '''
        ptmp = SampleParameter.fromparameter(self.p1)
        self.assertEqual(ptmp.key, 'Vmax', "test key")
        self.assertEqual(ptmp.value, 2.17, "test value")
        self.assertEqual(ptmp.unit, "mole_per_s", "test unit")
        self.assertEqual(ptmp.ptype, ParameterType.GLOBAL_PARAMETER, "test pytpe")
        
    
    def test_fromparameters2(self):
        ''' Create SampleParameter from django Parameter '''
        from sbmlsim.models import Parameter
        p = Parameter(name='test', value=1.0, unit='mM', ptype=ParameterType.GLOBAL_PARAMETER)
        ptmp = SampleParameter.fromparameter(p)
        self.assertEqual(ptmp.key, 'test', "test key")
        self.assertEqual(ptmp.value, 1.0, "test value")
        self.assertEqual(ptmp.unit, "mM", "test unit")
        self.assertEqual(ptmp.ptype, ParameterType.GLOBAL_PARAMETER, "test pytpe")        


if __name__ == '__main__':
    unittest.main()