"""
Testing the SBML report.
"""

from __future__ import print_function
import os
from django.test import TestCase, Client
from simapp.db.api import create_model, CompModelFormat

from examples.testdata import demo_filepath

class ReportTestCase(TestCase):
    def setUp(self):
        self.c = Client()

    def tearDown(self):
        pass

    def test_report(self):
        comp_model = create_model(demo_filepath, model_format=CompModelFormat.SBML)
        response = self.c.get('/simapp/report/{}'.format(comp_model.pk))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'SBML')


