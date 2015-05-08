from django.utils import unittest

from django.test import TestCase

#===============================================================================
# CoreTest
#===============================================================================

from simapp.models import Core

class CoreTestCase(TestCase):
    def setUp(self):
        # are these in the database ?
        Core.objects.create(ip='127.0.0.1', cpu=1)
        Core.objects.create(ip='10.39.34.27', cpu=2)

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

