"""
Creates the cell model from given module name.
The underlying idea is to import the respective model information and use
the module dictionaries to create the actual model.

Uses the importlib to import the information.

TODO: the parts which can be reused have to be exported to a BaseClass.

"""

from __future__ import print_function
import warnings
from libsbml import SBMLDocument, SBMLWriter

from multiscale.modelcreator.factory.model_helper import *
from multiscale.modelcreator.processes.ReactionFactory import *
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate
from multiscale.modelcreator.sbml.SBMLUtils import check
from multiscale.modelcreator.sbml.SBMLValidator import SBMLValidator


class CellModel(object):
    """
    Class creates the SBML models from given dictionaries and lists
    of information.
    """
    # keys of possible information in the modules.
    _keys = ['mid',
             'version',
             'description',
             'history',
             'main_units',
             'units',
             'compartments',
             'species',
             'names',
             'parameters',
             'assignments',
             'rules',
             'reactions']

    # Dictionary keys for respective lists
    _dictkeys = {
        'compartments': ('spatialDimension', 'unit', 'constant', 'assignment'),
        'species': ('compartment', 'value', 'unit'),
        'parameters': ('value', 'unit', 'constant'),
        'assignments': ('assignment', 'unit'),
        'rules': ('rule', 'unit'),
    }

    def __init__(self, model_id, cell_dict, events=None):
        """
        Initialize with the tissue information dictionary and
        the respective cell model used for creation.
        """
        self.model_id = model_id
        self.cell_dict = cell_dict

        for key, value in cell_dict.iteritems():
            setattr(self, key, value)
        self.events = events

        # sbml
        self.doc = SBMLDocument(SBML_LEVEL, SBML_VERSION)
        self.model = self.doc.createModel()

        check(self.model.setId(self.model_id), 'set id')
        check(self.model.setName(self.model_id), 'set name')

        # add dynamical parameters
        self.parameters.update({})
        print('\n', '*'*40, '\n', self.model_id, '\n', '*'*40)


    def info(self):
        for key in CellModel._keys:
            print(key, ' : ', getattr(self, key))

    @staticmethod
    def createCellDict(module_dirs):
        """
        Creates one information dictionary from various modules by combining the information.
        Information in earlier modules if overwritten by information in later modules.
        """
        import copy
        cdict = dict()
        for directory in module_dirs:
            # get single module dict
            mdict = CellModel._createDict(directory)
            # add information to overall dict
            for key, value in mdict.iteritems():

                if type(value) is list:
                    # create new list
                    if key not in cdict:
                        cdict[key] = []
                    # now add elements by copy
                    cdict[key].extend(copy.deepcopy(value))

                elif type(value) is dict:
                    # create new dict
                    if key not in cdict:
                        cdict[key] = dict()
                    # now add the elements by copy
                    old_value = cdict.get(key)
                    for key, value in value.iteritems():
                        old_value[key] = copy.deepcopy(value)
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
        print('\n***', module_name, '***')
        print(module)
        print(dir(module))

        d = dict()
        for key in CellModel._keys:
            if hasattr(module, key):
                info = getattr(module, key)
                if key in CellModel._dictkeys:
                    # zip info with dictkeys and add id
                    dzip = dict()
                    for k, v in info.iteritems():
                        dzip[k] = dict(zip(CellModel._dictkeys[key], v))
                        dzip[k]['id'] = k
                    d[key] = dzip
                else:
                    d[key] = info
            else:
                warnings.warn(" ".join(['missing:', key]))

        return d


    def create_sbml(self):
        # extend the base names to the compartments


        self.createUnits()
        self.createAllParameters()
        self.createInitialAssignments()
        self.createAllCompartments()
        # self.createExternalSpecies()
        """

        self.createAssignmentRules()
        self.createTransportReactions()
        self.createBoundaryConditions()


        # cell model
        self.createCellCompartments()
        self.createCellSpecies()
        self.createCellParameters()
        self.createCellInitialAssignments()
        self.createCellAssignmentRules()
        self.createCellReactions()
        # events
        self.createCellEvents()
        self.createSimulationEvents()
        """

    def write_sbml(self, filepath, validate=True):

        print('Write : {}\n'.format(self.model_id, filepath))
        writer = SBMLWriter()
        writer.writeSBMLToFile(self.doc, filepath)

        # validate the model with units (only for small models)
        if validate:
            # validator = SBMLValidator(ucheck=(self.Nc < 4))
            validator = SBMLValidator(ucheck=True)
            validator.validate(filepath)
        return filepath


    def addName(self, d):
        """ Looks up name of the id and adds to dictionary.
            Changes dictionary in place.
        """
        for key, data in d.iteritems():
            name = self.names.get(key, None)
            if type(data) is list:
                d[key] = [key, name] + list(data)
            elif type(data) is dict:
                data['name'] = name
                d[key] = data

    ##########################################################################
    # Units
    ##########################################################################
    def createUnits(self):
        # creates all the individual unit definitions
        for key, value in self.units.iteritems():
            createUnitDefinition(self.model, key, value)
        # sets the main units of model
        setMainUnits(self.model, self.main_units)

    ##########################################################################
    # Parameters
    ##########################################################################
    def createAllParameters(self):
        self.addName(self.parameters)
        createParameters(self.model, self.parameters)

    #########################################################################
    # Compartments
    #########################################################################
    def createAllCompartments(self):
        self.addName(self.compartments)
        createCompartments(self.model, self.compartments)

    ##########################################################################
    # Species
    ##########################################################################
    def createExternalSpecies(self):
        species = self.createExternalSpeciesDict()
        createSpecies(self.model, species)

    def createCellSpecies(self):
        species = self.createCellSpeciesDict()
        createSpecies(self.model, species)

    def createExternalSpeciesDict(self):
        """
        All species which are defined external are generated in all
        external compartments, i.e. PP, PV, sinusoid and disse space.
        """
        sdict = dict()
        for data in self.external:
            (sid, init, units, boundaryCondition) = self.getItemsFromSpeciesData(data)
            name = self.names[sid]
            # PP
            sdict[getPPSpeciesId(sid)] = (getPPSpeciesName(name), init, units, getPPId(), boundaryCondition)
            for k in self.comp_range():
                sdict[getSinusoidSpeciesId(sid, k)] = (getSinusoidSpeciesName(name, k), init, units, getSinusoidId(k), boundaryCondition)
                sdict[getDisseSpeciesId(sid, k)] = (getDisseSpeciesName(name, k), init, units, getDisseId(k), boundaryCondition)
            # PV
            sdict[getPVSpeciesId(sid)] = (getPVSpeciesName(name), init, units, getPVId(), boundaryCondition)
        return sdict

    def createCellSpeciesDict(self):
        sdict = dict()
        for data in self.cellModel.species:
            (full_id, init, units, boundaryCondition) = self.getItemsFromSpeciesData(data)

            tokens = full_id.split('__')
            sid = tokens[1]
            name = self.names[sid]
            for k in self.cell_range():
                # TODO: only covers species in cytosol (has to work with arbitrary number of compartments)
                # necessary to have a mapping of the compartments to the functions which generate id and names
                if full_id.startswith('h__'):
                    sdict[getHepatocyteSpeciesId(sid, k)] = (getHepatocyteSpeciesName(name, k), init, units,
                                                             getHepatocyteId(k), boundaryCondition)
                if full_id.startswith('c__'):
                    sdict[getCytosolSpeciesId(sid, k)] = (getCytosolSpeciesName(name, k), init, units,
                                                          getCytosolId(k), boundaryCondition)
        return sdict

    def getItemsFromSpeciesData(self, data):
        sid, init, units = data[0], data[1], data[2]
        # handle the constant species
        if len(data) == 4:
            boundaryCondition = data[3]
        else:
            boundaryCondition = False
        return sid, init, units, boundaryCondition

    ##########################################################################
    # Assignments
    ##########################################################################
    def createInitialAssignments(self):
        self.addName(self.assignments)
        createInitialAssignments(self.model, self.assignments)

    #########################################################################
    # Rules
    #########################################################################

    # Assignment Rules
    def createAssignmentRules(self):
        self.addName(self.rules)
        createAssignmentRules(self.model, self.rules)

    def createCellAssignmentRules(self):
        rules = []
        rep_dicts = self.createCellExtReplacementDicts()
        for rule in self.cellModel.rules:
            for d in rep_dicts:
                r_new = [initString(rpart, d) for rpart in rule]
                rules.append(r_new)
        createAssignmentRules(self.model, rules, self.names)


    def createCellReplacementDicts(self):
        """ Definition of replacement information for initialization of the cell ids.
            Creates all possible combinations.
        """
        init_data = []
        for k in self.cell_range():
            d = dict()
            d['h__'] = '{}__'.format(getHepatocyteId(k))
            d['c__'] = '{}__'.format(getCytosolId(k))
            init_data.append(d)
        return init_data

    def createCellExtReplacementDicts(self):
        """ Definition of replacement information for initialization of the cell ids.
            Creates all possible combinations.
        """
        init_data = []
        for k in self.cell_range():
            for i in range( (k-1)*self.Nf+1, k*self.Nf+1):
                d = dict()
                d['h__'] = '{}__'.format(getHepatocyteId(k))
                d['c__'] = '{}__'.format(getCytosolId(k))
                d['e__'] = '{}__'.format(getDisseId(i))
                init_data.append(d)
        return init_data

    # Boundary Conditions
    def createBoundaryConditions(self):
        ''' Set constant in periportal. '''
        sdict = self.createExternalSpeciesDict()
        for key in sdict.keys():
            if isPPSpeciesId(key):
                s = self.model.getSpecies(key)
                s.setBoundaryCondition(True)

    # Reactions
    def createCellReactions(self):
        """ Initializes the generic compartments with the actual
            list of compartments for the given geometry.
        """
        # set the model for the template
        ReactionTemplate.model = self.model

        rep_dicts = self.createCellReplacementDicts()
        for r in self.cellModel.reactions:
            # Get the right replacement dictionaries for the reactions
            if ('c__' in r.compartments) and not ('e__' in r.compartments):
                rep_dicts = self.createCellReplacementDicts()
            if ('c__' in r.compartments) and ('e__' in r.compartments):
                rep_dicts = self.createCellExtReplacementDicts()
            r.createReactions(self.model, rep_dicts)

    # Events
    def createCellEvents(self):
        """ Creates the additional events defined in the cell model.
            These can be metabolic deficiencies, or other defined
            parameter changes.
            TODO: make this cleaner and more general.
        """

        ddict = self.cellModel.deficiencies
        dunits = self.cellModel.deficiencies_units

        for deficiency, data in ddict.iteritems():
            e = createDeficiencyEvent(self.model, deficiency)
            # create all the event assignments for the event
            for key, value in data.iteritems():
                p = self.model.getParameter(key)
                p.setConstant(False)
                formula = '{} {}'.format(value, dunits[key])
                astnode = libsbml.parseL3FormulaWithModel(formula, self.model)
                ea = e.createEventAssignment()
                ea.setVariable(key)
                ea.setMath(astnode)

    def createSimulationEvents(self):
        """ Create the simulation timecourse events based on the
            event data.
        """
        if self.events:
            createSimulationEvents(self.model, self.events)
