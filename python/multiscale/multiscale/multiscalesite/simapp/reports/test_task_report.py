"""
Testing the Task Report.
"""

from __future__ import print_function
from django.test import TestCase, Client
from multiscale.examples.testdata import demo_filepath
from simapp.db.api import *

class TaskReportTestCase(TestCase):
    def setUp(self):
        # create task with simulations
        comp_model = create_model(demo_filepath, model_format=CompModelFormat.SBML)

        # TODO: setup a task
        self.task = None
        self.c = Client()

    def tearDown(self):
        pass

    def test_report(self):

        response = self.c.get('/simapp/task/T{}'.format(self.task.pk))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'pk')
