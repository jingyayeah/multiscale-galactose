"""
Test the RoadRunner simulation tools.
"""

from __future__ import print_function
import unittest

from multiscale.examples.testdata import demo_sbml
import multiscale.odesim.simulate.roadrunner_tools as roadrunner_tools


class TestRoadRunnerToolsCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_load_model(self):
        r = roadrunner_tools.load_model(demo_sbml)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[c__A]' in r.selections)
        self.assertTrue('[c__B]' in r.selections)
        self.assertTrue('[c__C]' in r.selections)

    def test_global_parameters(self):
        r = roadrunner_tools.load_model(demo_sbml)
        gp = roadrunner_tools.global_parameters_dataframe(r)
        self.assertEqual(2.0, gp.value['Vmax_bB'])

    def test_floating_species(self):
        r = roadrunner_tools.load_model(demo_sbml)
        f_species = roadrunner_tools.floating_species_dataframe(r)
        self.assertEqual(10.0, f_species.concentration['e__A'])
        self.assertEqual(0.0, f_species.concentration['c__A'])

    def test_bounding_species(self):
        r = roadrunner_tools.load_model(demo_sbml)
        b_species = roadrunner_tools.boundary_species_dataframe(r)
        self.assertEqual(0, len(b_species))

    def test_simulation(self):
        r = roadrunner_tools.load_model(demo_sbml)
        # Always set your selections manually
        r.selections = ['time'] + ['[{}]'.format(s) for s in r.model.getFloatingSpeciesIds()]
        res, gp = roadrunner_tools.simulate(r, t_start=0, t_stop=20, steps=100,
                                            absTol=1E-8, relTol=1E-8, debug=True)
        print(res)
        print(res.shape)
        print(r.selections)
        self.assertEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_simulation_varsteps(self):
        r = roadrunner_tools.load_model(demo_sbml)
        r.selections = ['time'] + ['[{}]'.format(s) for s in r.model.getFloatingSpeciesIds()]
        res, gp = roadrunner_tools.simulate(r, t_start=0, t_stop=20,
                                            absTol=1E-8, relTol=1E-8, debug=False)
        self.assertNotEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_parameters(self):
        r = roadrunner_tools.load_model(demo_sbml)
        parameters = {'Vmax_bA': 10.0,
                      'Vmax_bB': 7.15}
        res, gp = roadrunner_tools.simulate(r, t_start=0, t_stop=20,
                                            parameters=parameters,
                                            absTol=1E-8, relTol=1E-8, debug=False)
        self.assertEqual(10.0, gp.value['Vmax_bA'])
        self.assertEqual(7.15, gp.value['Vmax_bB'])

    def test_initial_concentrations(self):
        r = roadrunner_tools.load_model(demo_sbml)
        init_concentrations = {'e__A': 5.0,
                               'e__B': 2.0}
        res, gp = roadrunner_tools.simulate(r, t_start=0, t_stop=20,
                                            init_concentrations=init_concentrations,
                                            absTol=1E-8, relTol=1E-8, debug=False)
        print('res:', res)
        self.assertEqual(5.0, res['[e__A]'][0])
        self.assertEqual(2.0, res['[e__B]'][0])

    def test_initial_values(self):
        r = roadrunner_tools.load_model(demo_sbml)
        r.selections = r.selections + r.model.getFloatingSpeciesIds()
        init_amounts = {'e__A': 0.01,
                        'e__B': 0.004}
        res, gp = roadrunner_tools.simulate(r, t_start=0, t_stop=20,
                                            init_amounts=init_amounts,
                                            absTol=1E-8, relTol=1E-8, debug=False)
        self.assertEqual(0.01, res['e__A'][0])
        self.assertEqual(0.004, res['e__B'][0])


if __name__ == '__main__':
    unittest.main()
