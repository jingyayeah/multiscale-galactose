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
        return [item.value for item in cls]
    
    @classmethod
    def check_type(cls, test_type):
        if test_type not in cls.values():
            raise cls.EnumTypeException('type not supported: {}'.format(test_type))    
        

class EnumTypeExample(EnumType, Enum):
    SETTING_A = 'SETTING_A'
    SETTING_B = 'SETTING_B'

