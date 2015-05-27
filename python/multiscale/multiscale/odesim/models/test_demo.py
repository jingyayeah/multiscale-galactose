"""
Testing the samples for the demo network.
"""

from django.test import TestCase
from multiscale.odesim.dist.samples import Sample
from multiscale.odesim.models.demo import Demo


class TestDemo(TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_example_distributions(self):
        distributions = Demo.example_distributions()
        self.assertEqual(len(distributions), 2)

    def test_example_samples(self):
        samples = Demo.example_samples(n_samples=10)
        self.assertIsInstance(samples[0], Sample)
        self.assertEqual(len(samples), 10)

    def test_example_simulations(self):
        simulations = Demo.example_simulations(n_samples=10)
        self.assertEqual(len(simulations), 10)

