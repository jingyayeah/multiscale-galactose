"""
Creates the cell model from given module name.
The underlying idea is to import the respective model information and use
the module dictionaries to create the actual model.

Uses the importlib to import the information.

TODO: the parts which can be reused have to be exported to a BaseClass.

"""

from __future__ import print_function

from libsbml import SBMLDocument, SBMLNamespaces
from ..modelcreator_settings import PROGRAM_NAME, PROGRAM_VERSION
from ..processes.ReactionFactory import *
from ..processes.ReactionTemplate import ReactionTemplate
from ..utils import naming

from multiscale.sbmlutils.factory import *
from multiscale.sbmlutils.io import check, write_sbml
import multiscale.sbmlutils.annotation as annotation


class CellModel(object):
    """
    Class creates the SBML models from given dictionaries and lists
    of information.
    """
    # keys of possible information in the modules.
    _keys = ['mid',
             'version',
             'notes',
             'creators',
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
        'creators': ('FamilyName', 'GivenName', 'Email', 'Organization'),
        'compartments': ('spatialDimension', 'unit', 'constant', 'assignment'),
        'species': ('compartment', 'value', 'unit', 'boundaryCondition'),
        'parameters': ('value', 'unit', 'constant'),
        'assignments': ('assignment', 'unit'),
        'rules': ('assignment', 'unit'),
    }

    def __init__(self, cell_dict):
        """
        Initialize with the tissue information dictionary and
        the respective cell model used for creation.
        """
        self.cell_dict = cell_dict

        for key, value in cell_dict.iteritems():
            setattr(self, key, value)

        self.model_id = '{}_{}'.format(self.mid, self.version)
        self.doc = None
        self.model = None

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

                # lists of higher modules are extended
                if type(value) is list:
                    # create new list
                    if key not in cdict:
                        cdict[key] = []
                    # now add elements by copy
                    cdict[key].extend(copy.deepcopy(value))

                # dictionaries of higher modules are extended
                elif type(value) is dict:
                    # create new dict
                    if key not in cdict:
                        cdict[key] = dict()
                    # now add the elements by copy
                    d = cdict[key]
                    for k, v in value.iteritems():
                        d[k] = copy.deepcopy(v)

                # !everything else is overwritten
                else:
                    cdict[key] = value

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

        # sbmlutils
        sbmlns = SBMLNamespaces(SBML_LEVEL, SBML_VERSION, "fbc", 2)
        self.doc = SBMLDocument(sbmlns)
        self.doc.setPackageRequired("fbc", False)
        self.model = self.doc.createModel()
        mplugin = self.model.getPlugin("fbc")
        mplugin.setStrict(False)
        # name & id
        check(self.model.setId(self.model_id), 'set id')
        check(self.model.setName(self.model_id), 'set name')
        # notes
        check(self.model.setNotes(self.notes), 'set notes')
        # history
        model_history.set_model_history(self.model, self.creators)

        # lists of content
        self.createUnits()
        self.createAllParameters()
        self.createInitialAssignments()
        self.createAllCompartments()
        self.createAssignmentRules()

        self.createAllSpecies()
        self.createCellReactions()

        """
        # events
        self.createCellEvents()
        self.createSimulationEvents()
        """

    def write_sbml(self, filepath):
        write_sbml(self.doc, filepath, validate=True,
                   program_name=PROGRAM_NAME, program_version=PROGRAM_VERSION)

    def addName(self, d):
        """ Looks up name of the id and adds to dictionary.
            Checks ids and ids without compartment prefix.
            Changes dictionary in place.
        """
        for key, data in d.iteritems():
            name = self.names.get(key, None)
            # look for name without compartment prefix
            tokens = key.split(naming.SEPARATOR)
            if (not name) and (len(tokens) > 1):
                name = self.names.get(tokens[1], None)

            if type(data) is list:
                d[key] = [key, name] + list(data)
            elif type(data) is dict:
                data['name'] = name
                d[key] = data

    def addAttribute(self, d, attribute, value):
        """ Sets a generic attribute """
        warnings.warn("Not implemented")

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
    def createAllSpecies(self):
        self.addName(self.species)
        createSpecies(self.model, self.species)

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

    #########################################################################
    # Reactions
    #########################################################################
    def createCellReactions(self):
        """ Initializes the generic compartments with the actual
            list of compartments for the given geometry.
        """
        # set the model for the template
        ReactionTemplate.model = self.model
        for r in self.reactions:
            # create reactions without replacements
            r.createReactions(self.model, None)

        """
        rep_dicts = self.createCellReplacementDicts()
        for r in self.cellModel.reactions:
            # Get the right replacement dictionaries for the reactions
            if ('c__' in r.compartments) and not ('e__' in r.compartments):
                rep_dicts = self.createCellReplacementDicts()
            if ('c__' in r.compartments) and ('e__' in r.compartments):
                rep_dicts = self.createCellExtReplacementDicts()
            r.createReactions(self.model, rep_dicts)
        """

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

    #########################################################################
    # Events
    #########################################################################
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



    # def createCellAssignmentRules(self):
    #     rules = []
    #     rep_dicts = self.createCellExtReplacementDicts()
    #     for rule in self.cellModel.rules:
    #         for d in rep_dicts:
    #             r_new = [initString(rpart, d) for rpart in rule]
    #             rules.append(r_new)
    #     createAssignmentRules(self.model, rules, self.names)
    #
    #

    #
    # # TODO: how to handle boundaryConditions and Constant best.
    # # Boundary Conditions
    # def createBoundaryConditions(self):
    #     ''' Set constant in periportal. '''
    #     sdict = self.createExternalSpeciesDict()
    #     for key in sdict.keys():
    #         if isPPSpeciesId(key):
    #             s = self.model.getSpecies(key)
    #             s.setBoundaryCondition(True)
