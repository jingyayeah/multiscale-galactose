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
        """ Test if cores are active. """
        c1 = Core.objects.get(ip='127.0.0.1', cpu=1)
        c2 = Core.objects.get(ip='1.2.3.4', cpu=2)
        self.assertEqual(c1.active, True)
        self.assertEqual(c2.active, True)
    
    def test_cores_computer(self):
        """ Check if computers are in the COMPUTER dictionary. """
        c1 = Core.objects.get(ip='127.0.0.1', cpu=1)
        c2 = Core.objects.get(ip='1.2.3.4', cpu=2)
        self.assertEqual(c1.computer, 'localhost')
        self.assertEqual(c2.computer, c2.ip)


#===============================================================================
# CompModelTest
#===============================================================================
from simapp.models import CompModel, CompModelFormat
from multiscalesite import settings
import os

class CompModelTestCase(TestCase):
    def setUp(self):
        
        filepath = os.path.join(settings.MEDIA_ROOT, 'simapp', 'tests', 'Koenig_demo.xml')
        # is this destroyed again ?
        CompModel.create_from_file(filepath, model_format=CompModelFormat.SBML)
        # CompModel.objects.create(ip='127.0.0.1', cpu=1)
        
    def test_model_from_filepath(self):
        """Animals that can speak are correctly identified"""
        m1 = CompModel.objects.get(model_id='Koenig_demo')
        self.assertEqual(m1.model_id, 'Koenig_demo')


#===============================================================================
# ParameterTest
#===============================================================================
from simapp.models import Parameter, ParameterType

class ParameterTestCase(TestCase):
    def setUp(self):
        Parameter.objects.create(name='L', value=1E-6, unit="m", ptype=ParameterType.GLOBAL_PARAMETER)
        Parameter.objects.create(name='N', value=20, unit="-", ptype=ParameterType.GLOBAL_PARAMETER)

    def test_parameters(self):
        """Animals that can speak are correctly identified"""
        p1 = Parameter.objects.get(name='L', unit="m")
        p2 = Parameter.objects.get(name='N', unit="-")
        self.assertEqual(p1.key, 'L')
        self.assertEqual(p2.key, 'N')
        self.assertEqual(p1.value, 1E-6)
        self.assertEqual(p2.value, 20)
        self.assertEqual(p1.unit, 'm')
        self.assertEqual(p2.unit, '-')
        self.assertEqual(ParameterType.from_string(p1.ptype), ParameterType.GLOBAL_PARAMETER)
        self.assertEqual(ParameterType.from_string(p2.ptype), ParameterType.GLOBAL_PARAMETER)


#===============================================================================
# ViewTests
#===============================================================================
from django.test.client import Client

class ViewTestCase(TestCase):
    """ Use the django client to test the status of all views. 
        Tests the urls.py and views.py.
        TODO: setup basic database content and test the views on it.
    """
    def setUp(self):
        self.c = Client()
        
    def tearDown(self):
        self.c = None
    
    def test_models_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/models/')
        self.assertEqual(response.status_code, 200)
        
        # Check that the rendered context contains 5 customers.
        # self.assertEqual(len(response.context['customers']), 5)
        

    def test_cores_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/cores/')
        self.assertEqual(response.status_code, 200)

    def test_tasks_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/tasks/')
        self.assertEqual(response.status_code, 200)

    def test_integrations_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/integrations/')
        self.assertEqual(response.status_code, 200)

    def test_simlations_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/simulations/')
        self.assertEqual(response.status_code, 200)
        
    def test_timecourses_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/timecourses/')
        self.assertEqual(response.status_code, 200)

    def test_documentation_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/docs/')
        self.assertEqual(response.status_code, 200)


# TODO: test the links on the pages, do all external links work

#===============================================================================
# AdminTests
#===============================================================================

class AdminTestCase(TestCase):
    """ TODO: Test if all the attributes defined in the admin classes can be accessed. """
    def setUp(self):
        pass
        
    def tearDown(self):
        pass
    
    def test_core_admin(self):
        """ Check response status code for view. """
        from admin import CoreAdmin
        pass
            
