'''
Additional utility classes simplifying things.

Created on May 6, 2015

@author: mkoenig
'''
from enum import Enum

class EnumType(object):
    ''' Template class for all EnumTypes. '''
    class EnumTypeException(Exception):
        pass
    
    @classmethod
    def values(cls):
        ''' Returns the values. '''
        return [entry.value for entry in cls]
    
    @classmethod
    def items(cls):
        ''' Returns the items. '''
        return [entry.item for entry in cls]
    
    @classmethod
    def check_type(cls, test_type):
        if not isinstance(test_type, cls):
            raise cls.EnumTypeException('type not supported: {}'.format(test_type))    
    
    @classmethod
    def check_type_string(cls, test_typestr):
        if test_typestr not in cls.values():
            raise cls.EnumTypeException('type not supported: {}'.format(test_typestr))    
        

class EnumTypeExample(EnumType, Enum):
    SETTING_A = 'SETTING_A'
    SETTING_B = 'SETTING_B'

