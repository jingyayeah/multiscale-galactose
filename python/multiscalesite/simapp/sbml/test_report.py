"""
Testing the SBML report.
"""

from __future__ import print_function
import os
from django.test import TestCase, Client
from simapp.db.api import create_model, CompModelFormat


class MyTestCase(TestCase):
    def setUp(self):
        self.c = Client()

    def tearDown(self):
        pass

    def test_report(self):
        model_path = os.path.join(os.getcwd(), 'simapp', 'testdata', 'Koenig_demo.xml')
        comp_model = create_model(model_path, model_format=CompModelFormat.SBML)
        response = self.c.get('/simapp/report/{}'.format(comp_model.pk))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'SBML')
