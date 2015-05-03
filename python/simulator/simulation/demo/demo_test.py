'''
Testing the samples for the demo network.

@author: Matthias Koenig
@date: 2015-05-03
'''
import unittest
from demo import create_demo_samples


from simulator.dist.samples import Sample, SampleParameter
from sbmlsim.models import GLOBAL_PARAMETER

class TestDemo(unittest.TestCase):

    def setUp(self):
        pass
    def tearDown(self):
        pass
        

    def test_demo_samples(self):
        samples = create_demo_samples(N=1, sampling="distribution")
        s = samples[0]
        self.assertIsInstance(s, Sample, "Demo sample is Sample")
        keys =  s.keys()
        
        
if __name__ == '__main__':
    unittest.main()
    