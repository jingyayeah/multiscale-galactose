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

    def test_global_parameters(self):
        filepath = os.path.join(test_dir, 'sbml', 'Koenig_demo_v02.xml')
        r = roadrunner_tools.load_model(filepath)
        gp = roadrunner_tools.getGlobalParameters(r)
        self.assertEqual(2.0, gp.value['Vmax_bB'])

    def test_floating_species(self):
        filepath = os.path.join(test_dir, 'sbml', 'Koenig_demo_v02.xml')
        r = roadrunner_tools.load_model(filepath)
        f_species = roadrunner_tools.getFloatingSpecies(r)
        self.assertEqual(10.0, f_species.concentration['A_ext'])
        self.assertEqual(0.0, f_species.concentration['A'])

    def test_bounding_species(self):
        filepath = os.path.join(test_dir, 'sbml', 'Koenig_demo_v02.xml')
        r = roadrunner_tools.load_model(filepath)
        gp = roadrunner_tools.getGlobalParameters(r)
        self.assertEqual(gp.ix['Vmax_bB'], 2.0)
        # TODO

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
        filepath = os.path.join(test_dir, 'sbml', 'Koenig_demo_v02.xml')
        r = roadrunner_tools.load_model(filepath)
        parameters = {'Vmax_bA': 10.0,
                      'Vmax_bB': 7.15}
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20,
                                              parameters=parameters, init_concentrations={}, init_values={},
                                              absTol=1E-8, relTol=1E-8, info=True)
        print(gp)
        self.assertEqual(10.0, gp.Vmax_bA)
        self.assertEqual(7.15, gp.Vmax_bB)

    def test_initial_concentrations(self):
        pass

    def test_initial_values(self):
        pass



if __name__ == '__main__':
    unittest.main()
