#!/usr/bin/env python
'''
Testing the utility classes.

@author: Matthias Koenig
@date: 2015-05-06
'''
import unittest
from util_classes import EnumType, Enum

class Test(unittest.TestCase):
    class ParameterType(EnumType, Enum):
        GLOBAL_PARAMETER = 'GLOBAL_PARAMETER'
        BOUNDERY_INIT = 'BOUNDERY_INIT'
        FLOATING_INIT = 'FLOATING_INIT'
        NONE_SBML_PARAMETER = 'NONE_SBML_PARAMETER'   


    def setUp(self):
        pass

    def tearDown(self):
        pass


    def test_enum_values(self):
        self.assertEqual(len(self.ParameterType.values()), 4, "test number of entries in enum")
        
    def test_enum_check_typestr_yes(self):
        self.ParameterType.check_type_string("GLOBAL_PARAMETER")

    def test_enum_check_typestr_no(self):
        self.assertRaises(EnumType.EnumTypeException,self.ParameterType.check_type_string, 'test')

    def test_enum_check_type_yes(self):
        self.ParameterType.check_type(self.ParameterType.GLOBAL_PARAMETER)
        
    def test_choices(self):
        choices = self.ParameterType.choices()
        for key, value in choices:
            self.assertEqual(key, value)
        self.assertEqual(len(choices), len(self.ParameterType.values()))
    


if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()