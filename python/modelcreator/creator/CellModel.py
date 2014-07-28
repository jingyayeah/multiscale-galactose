'''
Created on Jul 23, 2014

@author: mkoenig
'''

class CellModel(object):
    '''
    InstanceKeys are the available information.
    '''
    _keys = ['mid', 'species', 'pars', 'assignments', 'rules',
            'reactions', 'deficiencies_units', 'deficiencies']

    def __init__(self, mdict):
        for key, value in mdict.iteritems():
            setattr(self, key, value)
        
    def info(self):
        for key in CellModel._keys:
            print key, ' : ', getattr(self, key)
    
    
    @staticmethod
    def createModel(module_name):
        '''
        A module which encodes a cell model is given and
        used to create the instance of the CellModel from
        the given global variables of the module.
        '''
        # dynamically import module
        cell_module = __import__(module_name)
        
        # get attributes from the class
        # print dir(cell_module)
        mdict = dict()
        for key in CellModel._keys:
            mdict[key] = getattr(cell_module, key)
        
        return CellModel(mdict)
        