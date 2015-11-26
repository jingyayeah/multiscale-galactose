"""
Creates the cell model from given module name.
The underlying idea is to import the respective model information and use
the module dictionaries to create the actual model.

Uses the importlib to import the information.

TODO: necessary to handle the case of multiple model parts, analoque to the
    tissue model.

"""

class CellModel(object):
    """ InstanceKeys are the available information. """
    _keys = ['mid',
             'version',
             'main_units',
             'species',
             'names',
             'pars',
             'assignments',
             'rules',
             'reactions']

    def __init__(self, cell_dict):
        for key, value in cell_dict.iteritems():
            setattr(self, key, value)
        
    def info(self):
        for key in CellModel._keys:
            print key, ' : ', getattr(self, key)

    @staticmethod
    def create_model(module_dirs):
        mdict = CellModel.createCellDict(module_dirs)
        return CellModel(mdict)

    @staticmethod
    def createCellDict(module_dirs):
        """
        Creates one information dictionary from various modules by combining the information.
        Information in earlier modules if overwritten by information in later modules.
        """
        import copy
        cdict = dict()
        for directory in module_dirs:
            mdict = CellModel._createDict(directory)
            for key, value in mdict.iteritems():
                if type(value) is list:
                    # create new list
                    if key not in cdict:
                        cdict[key] = []
                    # now add the elements by copy
                    cdict[key].extend(copy.deepcopy(value))

                elif type(value) is dict:
                    # create new dict
                    if key not in cdict:
                        cdict[key] = dict()
                    # now add the elements by copy
                    old_value = cdict.get(key)
                    for k, v in value.iteritems():
                        old_value[k] = copy.deepcopy(v)
        return cdict

    @staticmethod
    def _createDict(module_dir, package=None):
        """
        A module which encodes a cell model is given and
        used to create the instance of the CellModel from
        the given global variables of the module.
        """
        # dynamically import module
        import importlib
        module_name = ".".join([module_dir, "Cell"])
        module = importlib.import_module(module_name, package=package)

        # get attributes from class
        print '\n***', module_name, '***'
        print module
        print dir(module)

        d = dict()
        for key in CellModel._keys:
            if hasattr(module, key):
                d[key] = getattr(module, key)
            else:
                print('missing:', key)

        return d
