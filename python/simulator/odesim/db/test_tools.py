"""
Testing the database interaction tools.

"""
from __future__ import print_function
import os

from django.test import TestCase
import django
django.setup()

import simapp.db.api as db_api
from odesim.db.tools import get_sample_from_simulation, get_samples_for_task


class MyTestCase(TestCase):
    def setUp(self):
        model_path = os.path.join(os.getcwd(), 'examples', 'demo', 'Koenig_demo.xml')
        model = db_api.create_model(model_path, model_format=db_api.CompModelFormat.SBML)
        settings = {db_api.SettingKey.ABS_TOL: 1E-8}
        method = db_api.create_method_from_settings(method_type=db_api.MethodType.ODE,
                                                    settings_dict=settings,
                                                    add_defaults=True)
        self.task = db_api.create_task(model=model, method=method)
        parameters = [
            db_api.create_parameter(key='L', value=1E-6, unit="m",
                                    parameter_type=db_api.ParameterType.GLOBAL_PARAMETER),
            db_api.create_parameter(key='N', value=20, unit="-",
                                    parameter_type=db_api.ParameterType.GLOBAL_PARAMETER)
            ]

        self.sim = db_api.create_simulation(self.task, parameters=parameters)

    def tearDown(self):
        self.sim = None
        self.task = None

    def test_get_samples_for_task(self):
        samples = get_samples_for_task(self.task)
        self.assertEqual(len(samples), 1)



