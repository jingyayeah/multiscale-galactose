"""
Testing the simapp database api.
"""

from __future__ import print_function
from simapp.db.api import *
import os
from django.test import TestCase

import django
django.setup()


class MyTestCase(TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_create_model(self):
        model_path = os.path.join(os.getcwd(), 'simapp', 'testdata', 'Koenig_demo.xml')
        m1 = create_model(model_path, model_format=CompModelFormat.SBML)
        self.assertEqual(m1.model_id, 'Koenig_demo')
        self.assertEqual(m1.sbml_id, 'Koenig_demo')
        self.assertTrue(m1.is_sbml())
        self.assertFalse(m1.is_cellml())
        self.assertEqual(m1.model_format, CompModelFormat.SBML)

    def test_create_parameter(self):
        p1 = create_parameter(key='L', value=1E-6, unit="m",
                              parameter_type=ParameterType.GLOBAL_PARAMETER)
        p2 = create_parameter(key='N', value=20, unit="-",
                              parameter_type=ParameterType.BOUNDARY_INIT)
        self.assertEqual(p1.key, 'L')
        self.assertEqual(p2.key, 'N')
        self.assertEqual(p1.value, 1E-6)
        self.assertEqual(p2.value, 20)
        self.assertEqual(p1.unit, 'm')
        self.assertEqual(p2.unit, '-')
        self.assertEqual(p1.parameter_type, ParameterType.GLOBAL_PARAMETER)
        self.assertEqual(p2.parameter_type, ParameterType.BOUNDARY_INIT)

    def test_create_task(self):
        # TODO: implement test
        pass

    def test_create_method_from_settings(self):
        # TODO: implement test
        pass

    def test_create_simulation(self):
        # TODO: implement test
        pass

    def test_get_simulation_for_task(self):
        # TODO: implement test
        pass

    def get_parameters_for_simulation(self):
        # TODO: implement test
        pass


