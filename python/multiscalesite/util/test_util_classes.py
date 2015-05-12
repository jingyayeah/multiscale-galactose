#!/usr/bin/env python
"""
Testing the utility classes.

@author: Matthias Koenig
@date: 2015-05-06
"""
from __future__ import print_function
import unittest

from enum import Enum
from util.util_classes import EnumType


class Test(unittest.TestCase):
    class TestType(EnumType, Enum):
        GLOBAL_PARAMETER = 'GLOBAL_PARAMETER'
        BOUNDARY_INIT = 'BOUNDARY_INIT'
        FLOATING_INIT = 'FLOATING_INIT'
        NONE_SBML_PARAMETER = 'NONE_SBML_PARAMETER'   

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_enum_values(self):
        self.assertEqual(len(self.TestType.values()), 4, "test number of entries in enum")
        
    def test_enum_check_typestr_yes(self):
        self.TestType.check_type_string("GLOBAL_PARAMETER")

    def test_enum_check_typestr_no(self):
        self.assertRaises(self.TestType.EnumTypeException, self.TestType.check_type_string, 'test')

    def test_enum_check_type_yes(self):
        self.TestType.check_type(self.TestType.GLOBAL_PARAMETER)
        
    def test_choices(self):
        choices = self.TestType.choices()
        for key, value in choices:
            self.assertEqual(key, value)
        self.assertEqual(len(choices), len(self.TestType.values()))
    
    def test_from_string(self):
        """ Test creation from string. """
        s = 'GLOBAL_PARAMETER'
        ptype = self.TestType.from_string(s)
        self.assertEqual(ptype, self.TestType.GLOBAL_PARAMETER)
    
    def test_from_string2(self):
        """ Test creation from class based string. """
        s = 'TestType.GLOBAL_PARAMETER'
        ptype = self.TestType.from_string(s)
        self.assertEqual(ptype, self.TestType.GLOBAL_PARAMETER)
        

if __name__ == "__main__":
    # import sys;sys.argv = ['', 'Test.testName']
    unittest.main()