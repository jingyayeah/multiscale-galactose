"""
Testing ode simulations.
"""
from __future__ import print_function, division

import django
import simapp.db.api as db_api
from django.test import TestCase
from multiscale.odesim.simulate.solve_io import create_simulation_directory
from simapp.models import Result

from multiscale.examples.testdata import demo_sbml
from multiscale.odesim import solve_ode
django.setup()


class SolveODETestCase(TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_solve_roadrunner(self):
        # create a set of test simulations and run
        model = db_api.create_model(demo_sbml, db_api.CompModelFormat.SBML)
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


    def test_solve_roadrunner_2(self):

        # TODO: use the django test utils
        self.assertEqual(0, 1)
        import django
        django.setup()

        from simapp.models import Simulation, Task
        # sim_ids = range(1,2)
        # sims = [Simulation.objects.get(pk=sid) for sid in sim_ids]

        task = Task.objects.get(pk=43)
        simulations = Simulation.objects.filter(task=task)
        print('Task:', task)

        # perform all the integrations
        solve_io.create_simulation_directory(task)

        print('* Start integration *')
        print('Simulation: ', simulations)
        solve_roadrunner(simulations)



