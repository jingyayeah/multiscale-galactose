from django.test import TestCase

#===============================================================================
# CoreTest
#===============================================================================
from simapp.models import Core

class CoreTestCase(TestCase):
    def setUp(self):
        Core.objects.create(ip='127.0.0.1', cpu=1)
        Core.objects.create(ip='1.2.3.4', cpu=2)

    def test_cores_are_active(self):
        """Animals that can speak are correctly identified"""
        c1 = Core.objects.get(ip='127.0.0.1', cpu=1)
        c2 = Core.objects.get(ip='1.2.3.4', cpu=2)
        self.assertEqual(c1.active, True)
        self.assertEqual(c2.active, True)
    
    def test_cores_computer(self):
        """Check if computers are in the COMPUTER dictionary. """
        c1 = Core.objects.get(ip='127.0.0.1', cpu=1)
        c2 = Core.objects.get(ip='1.2.3.4', cpu=2)
        self.assertEqual(c1.active, True)
        self.assertEqual(c2.active, True)
        
        
        self.assertEqual(c1.computer, 'localhost')
        self.assertEqual(c2.computer, c2.ip)


#===============================================================================
# CompModelTest
#===============================================================================
from simapp.models import CompModel

# class CompModelTestCase(TestCase):
#     def setUp(self):
#         filepath = 
#         
#         CompModel.objects.create(ip='127.0.0.1', cpu=1)
#         Core.objects.create(ip='1.2.3.4', cpu=2)
#         
#         
# 
#     def test_cores_are_active(self):
#         """Animals that can speak are correctly identified"""
#         c1 = Core.objects.get(ip='127.0.0.1', cpu=1)
#         c2 = Core.objects.get(ip='1.2.3.4', cpu=2)
#         self.assertEqual(c1.active, True)
#         self.assertEqual(c2.active, True)


#===============================================================================
# ViewTests
#===============================================================================
from django.test.client import Client

class ViewTestCase(TestCase):
    """ Use the django client to test the status of all views. 
        Tests the urls.py and views.py.
        TODO: setup basic database content.
    """
    def setUp(self):
        self.c = Client()
        
    def tearDown(self):
        self.c = None
    
    def test_models_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/models/')
        self.assertEqual(response.status_code, 200)

    def test_cores_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/cores/')
        self.assertEqual(response.status_code, 200)

    def test_tasks_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/tasks/')
        self.assertEqual(response.status_code, 200)

    # TODO: add rest of views test 

    def test_documentation_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/documentation/')
        self.assertEqual(response.status_code, 200)


# TODO: test the links on the pages, do all external links work

