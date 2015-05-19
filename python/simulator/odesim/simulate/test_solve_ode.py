"""
Testing the ode simulations.
"""

import django
from odesim.simulate.solve_io import create_simulation_directory

django.setup()

from django.test import TestCase
from odesim.examples.testdata import demo_filepath
import simapp.db.api as db_api
from simapp.models import Result
from odesim.simulate import solve_ode


class SolveODETestCase(object):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_solve_roadrunner(self):
        # create a set of test simulations and run
        model = db_api.create_model(demo_filepath, db_api.CompModelFormat.SBML)
        settings = db_api.create_settings({db_api.SettingKey.T_START: 0.0,
                                           db_api.SettingKey.T_END: 20.0,
                                           db_api.SettingKey.STEPS: 100,
                                           db_api.SettingKey.VAR_STEPS: False})
        method = db_api.create_method(method_type=db_api.MethodType.ODE, settings=settings)
        task = db_api.create_task(model=model, method=method, info="Test roadrunner ode solve.")
        simulations = []
        for k in xrange(10):
            parameter = db_api.create_parameter(key='Vmax_bA', value=k, unit="mole_per_s",
                                                parameter_type=db_api.ParameterType.GLOBAL_PARAMETER)
            simulations.append(db_api.create_simulation(task=task, parameters=[parameter]))
        # perform all the integrations
        create_simulation_directory(task)

        # perform all the integrations
        solve_ode.solve_roadrunner(simulations)
        # Now perform the checks
        for simulation in simulations:
            # There should be one result associated with the simulation
            result = Result.objects.get(simulation=simulation)
            self.assertIsNotNone(result)
            self.assertEqual(db_api.ResultType.HDF5, result.result_type)



