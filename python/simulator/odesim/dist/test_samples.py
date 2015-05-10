"""
Testing the samples.

@author: Matthias Koenig
@date: 2015-05-03
"""
from __future__ import print_function
import unittest

from odesim.dist.samples import Sample, SampleParameter
from odesim.dist.sampling import SamplingType
from simapp.models import ParameterType


class TestSamples(unittest.TestCase):

    def setUp(self):
        self.p1 = SampleParameter(key='Vmax', value=2.17, unit='mole_per_s', parameter_type=ParameterType.GLOBAL_PARAMETER)
        self.p2 = SampleParameter(key='Km', value=0.1, unit='mM', parameter_type=ParameterType.GLOBAL_PARAMETER)
      
    def tearDown(self):
        self.p1 = None
        self.p2 = None
        
    def test_add_parameters(self):
        sample = Sample()
        sample.add_parameter(self.p1)
        self.assertEqual(len(sample), 1, "1 SampleParameter in Sample")
        self.assertEqual(sample[self.p1.key], self.p1, "Parameter should be the parameter")

    def test_add_parameters_multi(self):
        """ Multiple addition of SampleParameter should only contain it once. """
        sample = Sample()
        sample.add_parameter(self.p1)
        sample.add_parameter(self.p1)
        self.assertEqual(len(sample), 1, "1 SampleParameter in Sample")
        self.assertEqual(sample[self.p1.key], self.p1, "Parameter should be the parameter")

    def test_add_parameters(self):
        parameters = [self.p1, self.p2]
        sample = Sample()
        sample.add_parameters(parameters)
        self.assertEqual(len(sample), 2)
        self.assertEqual(sample[self.p1.key], self.p1, "Parameter should be the parameter")
        self.assertEqual(sample[self.p2.key], self.p2, "Parameter should be the parameter")

    def test_sample_pars_attributes(self):
        self.assertEqual(self.p1.key, "Vmax", "test key")
        self.assertEqual(self.p1.value, 2.17, "test value")
        self.assertEqual(self.p1.unit, "mole_per_s", "test unit")
        self.assertEqual(self.p1.ptype, ParameterType.GLOBAL_PARAMETER, "test pytpe")
        
    def test_sample_pars_repr(self):
        # print(self.p1.__repr__())
        self.assertEqual(self.p1.__repr__(), "<Vmax = 2.170E+00 [mole_per_s] (GLOBAL_PARAMETER)>", "test_repr")
        
    def test_demo_samples(self):
        from odesim.models.demo import create_demo_samples
        samples = create_demo_samples(N=1, sampling_type=SamplingType.DISTRIBUTION)
        s = samples[0]
        self.assertIsInstance(s, Sample, "Demo sample is Sample")
        
    def test_fromparameters1(self):
        """ Create SampleParameter from SampleParameter """
        p = SampleParameter.from_parameter(self.p1)
        self.assertEqual(p.key, 'Vmax', "test key")
        self.assertEqual(p.value, 2.17, "test value")
        self.assertEqual(p.unit, "mole_per_s", "test unit")
        self.assertEqual(p.ptype, ParameterType.GLOBAL_PARAMETER, "test pytpe")

    def test_fromparameters2(self):
        """ Create SampleParameter from django Parameter """
        from simapp.models import Parameter
        parameter = Parameter(name='test', value=1.0, unit='mM', ptype=ParameterType.GLOBAL_PARAMETER)
        p = SampleParameter.from_parameter(parameter)
        self.assertEqual(p.key, 'test', "test key")
        self.assertEqual(p.value, 1.0, "test value")
        self.assertEqual(p.unit, "mM", "test unit")
        self.assertEqual(p.ptype, ParameterType.GLOBAL_PARAMETER, "test pytpe")


if __name__ == '__main__':
    unittest.main()