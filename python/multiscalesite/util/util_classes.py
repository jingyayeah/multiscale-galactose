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


def hash_for_file(filepath, hash_type='MD5'):
    ''' Calculate the md5_hash for a file. 
    
        Calculating a hash for a file is always useful when you need to check if two files 
        are identical, or to make sure that the contents of a file were not changed, and to 
        check the integrity of a file when it is transmitted over a network.
        he most used algorithms to hash a file are MD5 and SHA-1. They are used because they 
        are fast and they provide a good way to identify different files.
        [http://www.pythoncentral.io/hashing-files-with-python/]
    '''
    import hashlib
    BLOCKSIZE = 65536
    if hash_type == 'MD5':
        hasher = hashlib.md5()
    elif hash_type == 'SHA1':
        hasher == hashlib.sha1()
    with open(filepath, 'rb') as afile:
        buf = afile.read(BLOCKSIZE)
        while len(buf) > 0:
            hasher.update(buf)
            buf = afile.read(BLOCKSIZE)
    return hasher.hexdigest()
