from __future__ import print_function
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
import os
class CompModelFormatTestCase(TestCase):
        
    def test_equality(self):
        """ Create the demo network in the database. """
        self.assertEqual(CompModelFormat.SBML, CompModelFormat.SBML)
    

class CompModelTestCase(TestCase):
    def setUp(self):
        
        filepath = os.path.join( os.getcwd(), 'simapp', 'testdata', 'Koenig_demo.xml')
        CompModel.create(filepath, model_format=CompModelFormat.SBML)
        
    def test_model_from_filepath(self):
        """ Create the demo network in the database. """
        m1 = CompModel.objects.get(model_id='Koenig_demo')
        self.assertEqual(m1.model_id, 'Koenig_demo')
        self.assertEqual(m1.sbml_id, 'Koenig_demo')
        
    def test_model_format(self):
        """ Make the format checks. """
        m1 = CompModel.objects.get(model_id='Koenig_demo')
        self.assertTrue(m1.is_sbml())
        self.assertFalse(m1.is_cellml())
        self.assertEqual(m1.model_format, CompModelFormat.SBML)
        
#===============================================================================
# SettingTest
#===============================================================================
from simapp.models import DataType, Setting, SettingKey, SimulatorType

class SettingTestCase(TestCase):
    def setUp(self):
        Setting.objects.create(key=(SettingKey.INTEGRATOR).value, 
                               value=(SimulatorType.ROADRUNNER).value)
        
    def test_setting_fields(self):
        """ Test the setting fields. """
        s1 = Setting.objects.get(key=(SettingKey.INTEGRATOR).value,
                                  value=(SimulatorType.ROADRUNNER).value)
        self.assertEqual(s1.datatype, (DataType.STRING).value)
        
    def test_create_default_settings(self):
        settings = Setting.get_or_create_from_dict({}, add_defaults=True)
        keys = [s.key for s in settings]
        self.assertTrue((SettingKey.INTEGRATOR).value in keys)
        



#===============================================================================
# ParameterTest
#===============================================================================
from simapp.models import Parameter, ParameterType

class ParameterTestCase(TestCase):
    def setUp(self):
        Parameter.objects.create(key='L', value=1E-6, unit="m", ptype=ParameterType.GLOBAL_PARAMETER)
        Parameter.objects.create(key='N', value=20, unit="-", ptype=ParameterType.GLOBAL_PARAMETER)

    def test_parameters(self):
        """Animals that can speak are correctly identified"""
        p1 = Parameter.objects.get(key='L', unit="m")
        p2 = Parameter.objects.get(key='N', unit="-")
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

    def test_methods_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/methods/')
        self.assertEqual(response.status_code, 200)

    def test_simulations_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/simulations/')
        self.assertEqual(response.status_code, 200)
        
    def test_results_status(self):
        """ Check response status code for view. """
        response = self.c.get('/simapp/results/')
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
            
