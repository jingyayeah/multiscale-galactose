"""
Testing the samples for the demo network.

@author: Matthias Koenig
@date: 2015-05-03
"""
import unittest
from demo import create_demo_samples

from odesim.dist.samples import Sample
from odesim.dist.sampling import SamplingType


class TestDemo(unittest.TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_demo_samples(self):
        samples = create_demo_samples(n_samples=1, sampling_type=SamplingType.DISTRIBUTION)
        s = samples[0]
        self.assertIsInstance(s, Sample, "Demo sample is Sample")
        

if __name__ == '__main__':
    unittest.main()