"""
Test the RoadRunner simulation tools.
"""

from __future__ import print_function
import unittest
import os
from testdata.testdata import test_dir
from odesim.roadrunner import roadrunner_tools

class MyTestCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_load_model(self):
        filepath = os.path.join(test_dir, 'sbml', 'Koenig_demo_v02.xml')
        r = roadrunner_tools.load_model(filepath)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[A]' in r.selections)
        self.assertTrue('[B]' in r.selections)
        self.assertTrue('[C]' in r.selections)

    def test_simulation(self):
        filepath = os.path.join(test_dir, 'sbml', 'Koenig_demo_v02.xml')
        r = roadrunner_tools.load_model(filepath)
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20, steps=100,
                                              parameters={}, init_concentrations={}, init_values={},
                                              absTol=1E-8, relTol=1E-8, info=True)
        self.assertEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_simulation_varsteps(self):
        filepath = os.path.join(test_dir, 'sbml', 'Koenig_demo_v02.xml')
        r = roadrunner_tools.load_model(filepath)
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20,
                                              parameters={}, init_concentrations={}, init_values={},
                                              absTol=1E-8, relTol=1E-8, info=True)
        self.assertNotEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_parameters(self):


    def test_initial_concentrations(self):
        pass

    def test_initial_values(self):
        pass

    def test_




if __name__ == '__main__':
    unittest.main()
