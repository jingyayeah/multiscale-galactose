"""
Test the RoadRunner simulation tools.
"""

from __future__ import print_function
import unittest
from odesim.examples.testdata import demo_filepath
import odesim.roadrunner.roadrunner_tools as roadrunner_tools

class TestRoadRunnerToolsCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_load_model(self):
        r = roadrunner_tools.load_model(demo_filepath)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[A]' in r.selections)
        self.assertTrue('[B]' in r.selections)
        self.assertTrue('[C]' in r.selections)

    def test_global_parameters(self):
        r = roadrunner_tools.load_model(demo_filepath)
        gp = roadrunner_tools.getGlobalParameters(r)
        self.assertEqual(2.0, gp.value['Vmax_bB'])

    def test_floating_species(self):
        r = roadrunner_tools.load_model(demo_filepath)
        f_species = roadrunner_tools.getFloatingSpecies(r)
        self.assertEqual(10.0, f_species.concentration['A_ext'])
        self.assertEqual(0.0, f_species.concentration['A'])

    def test_bounding_species(self):
        r = roadrunner_tools.load_model(demo_filepath)
        b_species = roadrunner_tools.getBoundarySpecies(r)
        self.assertEqual(0, len(b_species))

    def test_simulation(self):
        r = roadrunner_tools.load_model(demo_filepath)
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20, steps=100,
                                              absTol=1E-8, relTol=1E-8, debug=False)
        self.assertEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_simulation_varsteps(self):
        r = roadrunner_tools.load_model(demo_filepath)
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20,
                                              absTol=1E-8, relTol=1E-8, debug=False)
        self.assertNotEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_parameters(self):
        r = roadrunner_tools.load_model(demo_filepath)
        parameters = {'Vmax_bA': 10.0,
                      'Vmax_bB': 7.15}
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20,
                                              parameters=parameters,
                                              absTol=1E-8, relTol=1E-8, debug=False)
        self.assertEqual(10.0, gp.value['Vmax_bA'])
        self.assertEqual(7.15, gp.value['Vmax_bB'])

    def test_initial_concentrations(self):
        r = roadrunner_tools.load_model(demo_filepath)
        init_concentrations = {'A_ext': 5.0,
                               'B_ext': 2.0}
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20,
                                              init_concentrations=init_concentrations,
                                              absTol=1E-8, relTol=1E-8, debug=False)
        print('res:', res)
        self.assertEqual(5.0, res['[A_ext]'][0])
        self.assertEqual(2.0, res['[B_ext]'][0])

    def test_initial_values(self):
        r = roadrunner_tools.load_model(demo_filepath)
        r.selections = r.selections + r.model.getFloatingSpeciesIds()
        init_amounts = {'A_ext': 0.01,
                        'B_ext': 0.004}
        res, gp = roadrunner_tools.simulation(r, t_start=0, t_stop=20,
                                              init_amounts=init_amounts,
                                              absTol=1E-8, relTol=1E-8, debug=False)
        self.assertEqual(0.01, res['A_ext'][0])
        self.assertEqual(0.004, res['B_ext'][0])


if __name__ == '__main__':
    unittest.main()
