"""
Test the RoadRunner simulation tools.
"""

from __future__ import print_function, division
import unittest

from roadrunner import SelectionRecord
from multiscale.examples.testdata import demo_sbml
import multiscale.odesim.simulate.roadrunner_tools as rt


class TestRoadRunnerToolsCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    #########################################################################
    # Settings
    #########################################################################
    def test_default_settings(self):
        r = rt.MyRunner(demo_sbml)
        integrator = r.getIntegrator()
        self.assertEqual(integrator.getSetting("variable_step_size"), True)
        self.assertEqual(integrator.getSetting("stiff"), True)
        self.assertTrue(integrator.getSetting("absolute_tolerance") < 1E-8)
        self.assertEqual(integrator.getSetting("relative_tolerance"), 1E-8)

    def test_integrator_settings(self):
        r = rt.MyRunner(demo_sbml)
        integrator = r.getIntegrator()
        r.set_integrator_settings(variable_step_size=False)
        self.assertEqual(integrator.getSetting("variable_step_size"), False)
        r.set_integrator_settings(stiff=False)
        self.assertEqual(integrator.getSetting("stiff"), False)

    #########################################################################
    # Simulation
    #########################################################################
    def test_load_model(self):
        r = rt.MyRunner(demo_sbml)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[c__A]' in r.selections)
        self.assertTrue('[c__B]' in r.selections)
        self.assertTrue('[c__C]' in r.selections)

    def test_simulate_comparison(self):
        """ Test fixed step size simulation. """
        r = rt.MyRunner(demo_sbml)
        r.set_integrator_settings(variable_step_size=False)
        r.selections_floating_concentrations()
        # simulate with complex
        s1, __ = r.simulate_complex(start=0, end=20, steps=100)
        r.reset(SelectionRecord.ALL)
        # same simulation with basic
        s2 = r.simulate(0, 20, 101)

        self.assertEqual(101, s1.shape[0])
        self.assertEqual(7, s1.shape[1])
        self.assertEqual(101, s2.shape[0])
        self.assertEqual(7, s2.shape[1])
        import numpy
        self.assertTrue(numpy.array_equal(s1, s2))

    def test_simulation_fixedsteps(self):
        """ Test fixed step size simulation. """
        r = rt.MyRunner(demo_sbml)
        r.set_integrator_settings(variable_step_size=False)
        r.selections_floating_concentrations()
        res, __ = r.simulate_complex(start=0, end=20, steps=100)
        self.assertFalse(r.getIntegrator().getSetting('variable_step_size'))
        self.assertEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])

    def test_simulation_fixedsteps2(self):
        """ Test fixed step size simulation. """
        import roadrunner
        r1 = roadrunner.RoadRunner(demo_sbml)
        s1 = r1.simulate(0, 10)
        self.assertFalse(r1.getIntegrator().getSetting('variable_step_size'))
        self.assertEqual(51, s1.shape[0])
        self.assertEqual(7, s1.shape[1])

        r2 = rt.MyRunner(demo_sbml)
        r2.selections_floating_concentrations()
        r2.set_integrator_settings(variable_step_size=False)
        s2 = r2.simulate(0, 10)
        self.assertFalse(r1.getIntegrator().getSetting('variable_step_size'))
        self.assertEqual(51, s2.shape[0])
        self.assertEqual(7, s2.shape[1])

    def test_simulation_varsteps(self):
        """ Test variable step size simulation. """
        r = rt.MyRunner(demo_sbml)
        r.integrator.setSetting('variable_step_size', True)
        r.selections_floating_concentrations()
        res, __ = r.simulate_complex(start=0, end=20)

        self.assertTrue(r.getIntegrator().getSetting('variable_step_size'))
        self.assertNotEqual(101, res.shape[0])
        self.assertEqual(7, res.shape[1])
        self.assertEqual(res['time'][0], 0.0)
        self.assertEqual(res['time'][-1], 20.0)

    def test_simulate_parameters(self):
        """ Test setting parameters in model. """
        r = rt.MyRunner(demo_sbml)
        r.selections = ['time', 'Vmax_bA', 'Vmax_bB']
        parameters = {'Vmax_bA': 10.0, 'Vmax_bB': 7.15}
        res, gp = r.simulate_complex(start=0, end=20, parameters=parameters)
        self.assertEqual(10.0, gp.value['Vmax_bA'])
        self.assertEqual(7.15, gp.value['Vmax_bB'])
        self.assertEqual(10.0, res['Vmax_bA'][0])
        self.assertEqual(7.15, res['Vmax_bB'][0])

    def test_simulate_initial_concentrations(self):
        """ Test setting initial concentrations in model. """
        r = rt.MyRunner(demo_sbml)
        concentrations = {'init([e__A])': 5.0, 'init([e__B])': 2.0}
        res, __ = r.simulate_complex(start=0, end=20, initial_concentrations=concentrations)
        self.assertEqual(5.0, res['[e__A]'][0])
        self.assertEqual(2.0, res['[e__B]'][0])

    def test_simulate_initial_amounts(self):
        """ Test setting initial amounts in model. """
        r = rt.MyRunner(demo_sbml)
        r.selections = ['time', 'e__A', 'e__B']
        amounts = {'init(e__A)': 0.01, 'init(e__B)': 0.004}
        res, __ = r.simulate_complex(start=0, end=20, initial_amounts=amounts)
        self.assertEqual(0.01, res['e__A'][0])
        self.assertEqual(0.004, res['e__B'][0])

    #########################################################################
    # Setting values in model
    #########################################################################
    def test_store_amounts(self):
        r = rt.MyRunner(demo_sbml)
        amounts = r.store_amounts()
        self.assertEqual(len(amounts), 6)
        self.assertEqual(amounts['e__A'], r['e__A'])
        self.assertEqual(amounts['e__B'], r['e__B'])
        self.assertEqual(amounts['e__C'], r['e__C'])
        self.assertEqual(amounts['c__A'], r['c__A'])
        self.assertEqual(amounts['c__B'], r['c__B'])
        self.assertEqual(amounts['c__C'], r['c__C'])

    def test_store_concentrations(self):
        r = rt.MyRunner(demo_sbml)
        concentrations = r.store_concentrations()
        self.assertEqual(len(concentrations), 6)
        self.assertEqual(concentrations['[e__A]'], r['[e__A]'])
        self.assertEqual(concentrations['[e__B]'], r['[e__B]'])
        self.assertEqual(concentrations['[e__C]'], r['[e__C]'])
        self.assertEqual(concentrations['[c__A]'], r['[c__A]'])
        self.assertEqual(concentrations['[c__B]'], r['[c__B]'])
        self.assertEqual(concentrations['[c__C]'], r['[c__C]'])

    def test__set_values(self):
        r = rt.MyRunner(demo_sbml)
        d = {'Km_C': 1.0, 'Vmax_v3': 14.3, 'Keq_v1': -3.0,
             'init([e__A])': 1.0, 'init([e__B])': 14.3, 'init([c__C])': -3.0}
        r._set_values(d)
        for key in d:
            self.assertEqual(d[key], r[key])

    def test__set_parameters(self):
        r = rt.MyRunner(demo_sbml)
        d = {'Km_C': 1.0, 'Vmax_v3': 14.3, 'Keq_v1': -3.0}
        r._set_parameters(d)
        for key in d:
            self.assertEqual(d[key], r[key])

    def test__set_initial_concentrations(self):
        r = rt.MyRunner(demo_sbml)
        d = {'init([e__A])': 1.0, 'init([e__B])': 14.3, 'init([c__C])': -3.0}
        r._set_initial_concentrations(d)
        for key in d:
            self.assertEqual(d[key], r[key])

    def test__set_concentrations(self):
        r = rt.MyRunner(demo_sbml)
        d = {'[e__A]': 1.0, '[e__B]': 14.3, '[c__C]': -3.0}
        r._set_concentrations(d)
        for key in d:
            self.assertEqual(d[key], r[key])

    def test__set_initial_amounts(self):
        # failing due to roadrunner issue
        # https://github.com/sys-bio/roadrunner/issues/271
        r = rt.MyRunner(demo_sbml)
        d = {'init(e__A)': 1.0, 'init(e__B)': 14.3, 'init(c__C)': -3.0}
        r._set_initial_amounts(d)
        for key in d:
            self.assertEqual(d[key], r[key])

    def test__set_amounts(self):
        r = rt.MyRunner(demo_sbml)
        d = {'e__A': 1.0, 'e__B': 14.3, 'c__C': -3.0}
        r._set_amounts(d)
        for key in d:
            self.assertEqual(d[key], r[key])

    #########################################################################
    # Helper for units & selections
    #########################################################################
    def test_selections(self):
        """ Test the standard selection of roadrunner. """
        r = rt.MyRunner(demo_sbml)
        self.assertEqual(len(r.selections), 7)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[e__A]' in r.selections)
        self.assertTrue('[e__B]' in r.selections)
        self.assertTrue('[e__C]' in r.selections)
        self.assertTrue('[c__A]' in r.selections)
        self.assertTrue('[c__B]' in r.selections)
        self.assertTrue('[c__C]' in r.selections)

    def test_selections_floating_concentrations(self):
        r = rt.MyRunner(demo_sbml)
        r.selections_floating_concentrations()
        self.assertEqual(len(r.selections), 7)
        self.assertTrue('time' in r.selections)
        self.assertTrue('[e__A]' in r.selections)
        self.assertTrue('[e__B]' in r.selections)
        self.assertTrue('[e__C]' in r.selections)
        self.assertTrue('[c__A]' in r.selections)
        self.assertTrue('[c__B]' in r.selections)
        self.assertTrue('[c__C]' in r.selections)

    def test_selections_floating_amounts(self):
        r = rt.MyRunner(demo_sbml)
        r.selections_floating_amounts()
        self.assertEqual(len(r.selections), 7)
        self.assertTrue('time' in r.selections)
        self.assertTrue('e__A' in r.selections)
        self.assertTrue('e__B' in r.selections)
        self.assertTrue('e__C' in r.selections)
        self.assertTrue('c__A' in r.selections)
        self.assertTrue('c__B' in r.selections)
        self.assertTrue('c__C' in r.selections)

    #########################################################################
    # DataFrames
    #########################################################################
    def test_global_parameters(self):
        r = rt.MyRunner(demo_sbml)
        gp = r.global_parameters_dataframe()
        self.assertEqual(2.0, gp.value['Vmax_bB'])

    def test_floating_species(self):
        r = rt.MyRunner(demo_sbml)
        f_species = r.floating_species_dataframe()
        self.assertEqual(10.0, f_species.concentration['e__A'])
        self.assertEqual(0.0, f_species.concentration['c__A'])

    def test_bounding_species(self):
        r = rt.MyRunner(demo_sbml)
        b_species = r.boundary_species_dataframe()
        self.assertEqual(0, len(b_species))


if __name__ == '__main__':
    unittest.main()
