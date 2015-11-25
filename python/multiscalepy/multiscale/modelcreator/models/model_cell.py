"""
Creates the cell model from given module name.
The underlying idea is to import the respective model information and use
the module dictionaries to create the actual model.

Uses the importlib to import the information.
"""

class CellModel(object):
    """ InstanceKeys are the available information. """
    _keys = ['mid', 'species', 'pars', 'assignments', 'rules',
             'reactions', 'deficiencies_units', 'deficiencies']

    def __init__(self, mdict):
        for key, value in mdict.iteritems():
            setattr(self, key, value)
        
    def info(self):
        for key in CellModel._keys:
            print key, ' : ', getattr(self, key)

    @staticmethod
    def create_model(module_name, package=None):
        """
        A module which encodes a cell model is given and
        used to create the instance of the CellModel from
        the given global variables of the module.
        """
        # dynamically import module
        print '\n***', module_name, '***'
        
        # cell_module = __import__(module_name)
        # problems with relative path settings
        import importlib
        cell_module = importlib.import_module(module_name, package=package)

        # get attributes from the class
        print cell_module
        print dir(cell_module)
        mdict = dict()
        for key in CellModel._keys:
            mdict[key] = getattr(cell_module, key)
        
        return CellModel(mdict)