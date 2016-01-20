"""
Test the RoadRunner simulation tools.
"""

from __future__ import print_function, division
import unittest

from multiscale.examples.testdata import demo_sbml
import multiscale.odesim.simulate.roadrunner_tools as rt

class TestRoadRunnerToolsCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_load_model(self):
        r = rt.MyRunner(demo_sbml)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[c__A]' in r.selections)
        self.assertTrue('[c__B]' in r.selections)
        self.assertTrue('[c__C]' in r.selections)

    def test_global_parameters(self):
        r = rt.MyRunner(demo_sbml)
        gp = rt.global_parameters_dataframe(r)
        self.assertEqual(2.0, gp.value['Vmax_bB'])

    def test_floating_species(self):
        r = rt.load_model(demo_sbml)
        f_species = rt.floating_species_dataframe(r)
        self.assertEqual(10.0, f_species.concentration['e__A'])
        self.assertEqual(0.0, f_species.concentration['c__A'])

    def test_bounding_species(self):

        r = rt.MyRunner(demo_sbml)

        # r = roadrunner_tools.load_model(demo_sbml)

        b_species = rt.boundary_species_dataframe(r)
        self.assertEqual(0, len(b_species))

    def test_simulation_fixedsteps(self):
        """ Test fixed step size simulation. """
        r = rt.load_model(demo_sbml)
        rt.set_integrator_settings(r, variable_step_size=False)

        r.selections = ['time'] + ['[{}]'.format(s) for s in r.model.getFloatingSpeciesIds()]
        res, __ = rt.simulate(r, start=0, end=20, steps=100, debug=True)

        self.assertFalse(r.getIntegrator().getSetting('variable_step_size'))
        self.assertEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_simulation_fixedsteps2(self):
        """ Test fixed step size simulation. """
        r = rt.load_model(demo_sbml)
        r.selections = ['time'] + ['[{}]'.format(s) for s in r.model.getFloatingSpeciesIds()]
        res = r.simulate(0, 10)

        self.assertFalse(r.getIntegrator().getSetting('variable_step_size'))
        self.assertEqual(51, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_simulation_varsteps(self):
        """ Test variable step size simulation. """
        r = rt.load_model(demo_sbml)
        r.integrator.setSetting('variable_step_size', True)
        r.selections = ['time'] + ['[{}]'.format(s) for s in r.model.getFloatingSpeciesIds()]
        res, __ = rt.simulate(r, start=0, end=20, debug=False)

        self.assertTrue(r.getIntegrator().getSetting('variable_step_size'))
        self.assertNotEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])
        self.assertEqual(res['time'][0], 0.0)
        self.assertEqual(res['time'][-1], 20.0)

    def test_parameters(self):
        """ Test setting parameters in model. """
        r = rt.load_model(demo_sbml)
        r.selections = ['time', 'Vmax_bA', 'Vmax_bB']
        parameters = {'Vmax_bA': 10.0,
                      'Vmax_bB': 7.15}
        res, gp = rt.simulate(r, start=0, end=20,
                              parameters=parameters, debug=False)
        self.assertEqual(10.0, gp.value['Vmax_bA'])
        self.assertEqual(7.15, gp.value['Vmax_bB'])
        self.assertEqual(10.0, res['Vmax_bA'][0])
        self.assertEqual(7.15, res['Vmax_bB'][0])

    def test_initial_concentrations(self):
        """ Test setting initial concentrations in model. """
        r = rt.load_model(demo_sbml)
        init_concentrations = {'e__A': 5.0,
                               'e__B': 2.0}
        res, __ = rt.simulate(r, start=0, end=20,
                              init_concentrations=init_concentrations, debug=False)
        self.assertEqual(5.0, res['[e__A]'][0])
        self.assertEqual(2.0, res['[e__B]'][0])

    def test_initial_values(self):
        """ Test setting initial amounts in model. """
        r = rt.load_model(demo_sbml)
        r.selections = ['time', 'e__A', 'e__B']
        init_amounts = {'e__A': 0.01,
                        'e__B': 0.004}
        res, __ = rt.simulate(r, start=0, end=20,
                              init_amounts=init_amounts, debug=False)
        self.assertEqual(0.01, res['e__A'][0])
        self.assertEqual(0.004, res['e__B'][0])

    def test_selections(self):
        """ Test the standard selection of roadrunner. """
        r = rt.load_model(demo_sbml)
        self.assertEqual(len(r.selections), 7)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[e__A]' in r.selections)
        self.assertTrue('[e__B]' in r.selections)
        self.assertTrue('[e__C]' in r.selections)
        self.assertTrue('[c__A]' in r.selections)
        self.assertTrue('[c__B]' in r.selections)
        self.assertTrue('[c__C]' in r.selections)


if __name__ == '__main__':
    unittest.main()
