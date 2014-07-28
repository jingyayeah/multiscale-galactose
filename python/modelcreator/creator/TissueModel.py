'''
Created on Jul 23, 2014
@author: mkoenig
'''

import sim.PathSettings

from libsbml import UNIT_KIND_SECOND, UNIT_KIND_MOLE,\
    UNIT_KIND_METRE,UNIT_KIND_KILOGRAM, SBMLDocument, SBMLWriter

from creator.tools.Naming import *
from creator.processes.ReactionFactory import *
from creator.sbml.SBMLValidator import SBMLValidator

from creator.MetabolicModel import *
from creator.processes.ReactionTemplate import ReactionTemplate
from sim.PathSettings import SBML_DIR


class TissueModel(object):
    '''
    The SBML model is created from the tissue informaton
    and the single cell models.
    '''
    _keys = ['main_units', 'units', 'names',
            'pars', 'external', 'assignments', 'rules']

    def __init__(self, Nc, version,
                 tissue_dict, cell_model, simId='core', events=None):
        '''
        Initialize with the tissue information dictionary and 
        the respective cell model used for creation.
        '''
        self.Nc = Nc
        self.version = version
        self.simId = simId
        self.cellModel = cell_model
        print self.cellModel.info()
        
        # tissue information fields
        for key, value in tissue_dict.iteritems():
            setattr(self, key, value)
        self.events = events
   
        # sbml 
        self.id = self.createId()
        self.doc = SBMLDocument(SBML_LEVEL, SBML_VERSION)
        self.model = self.doc.createModel(self.id)
        self.model.setName(self.id)
        
        # add dynamical parameters
        self.pars.append(
            ('Nc', self.Nc, '-', True),
        )
    
        print '*'*40, '\n', self.id, '\n', '*'*40
    
    @staticmethod
    def createTissueDict(module_names):
        '''
        Creates one information dictionary from various modules
        by combining the information.
        Information in earlier modules if overwritten by information
        in later modules.
        
        Necessary to make copies of the information.
        What is shared?
        '''
        cdict = dict()
        for name in module_names:
            mdict = TissueModel._createDict(name)
            for key, value in mdict.iteritems():
                if not cdict.has_key(key):
                    cdict[key] = value
                else:
                    old_value = cdict.get(key)
                    # the information has to be list or dict (and consistent)
                    if type(old_value) is list:
                        old_value.extend(value)
                    if type(old_value) is dict:
                        for k, v in value.iteritems():
                            old_value[k] = v
        return cdict


    @staticmethod
    def _createDict(module_name):
        '''
        A module which encodes a cell model is given and
        used to create the instance of the CellModel from
        the given global variables of the module.
        
        TODO: some quality control of the model structure.
        '''
        # dynamically import module
        tissue_module = __import__(module_name)
        
        # get attributes from the class
        print '***', module_name, '***'
        # print dir(tissue_module)

        mdict = dict()
        for key in TissueModel._keys:
            if hasattr(tissue_module, key):
                print 'set:', key
                mdict[key] = getattr(tissue_module, key)
            else:
                print 'missing:', key

        return mdict

        
    def createId(self):
        if self.simId:
            mid = '{}_v{}_Nc{}_{}'.format(self.cellModel.mid, self.version, self.Nc, self.simId)
        else:
            mid = '{}_v{}_Nc{}'.format(self.cellModel.mid, self.version, self.Nc)
        return mid
    
    def cell_range(self):
        return range(1, self.Nc+1)
    
    
    def info(self):
        for key in TissueModel._keys:
            print key, ' : ', getattr(self, key)
            
            
    def createModel(self):    
        # sinusoidal unit model
        self.createUnits()
        self.createExternalParameters()
        self.createInitialAssignments()
        self.createExternalCompartments()
        self.createExternalSpecies()
        self.createTransportReactions()
        self.createBoundaryConditions()
        
        # cell model
        self.createCellCompartments()
        self.createCellSpecies()
        self.createCellParameters()
        self.createCellInitialAssignments()
        self.createCellAssignmentRules()
        self.createCellReactions()
        
        self.createCellEvents()
        self.createSimulationEvents()
        
    #########################################################################
    # External Compartments
    ##########################################################################
    # id, name, spatialDimension, unit, constant, assignment/value
    def createExternalCompartmentsDict(self):
        comps = dict()
        # periportal
        comps[getPPId()] = (getPPName(), 3, 'm3', True, 'Vol_pp')
        # sinusoid
        for k in self.cell_range():
            comps[getSinusoidId(k)] = (getSinusoidName(k), 3, 'm3', True, 'Vol_sin')
        # disse
        for k in self.cell_range():
            comps[getDisseId(k)] = (getDisseName(k), 3, 'm3', True, 'Vol_dis')
        # perivenious
        comps[getPVId()] = (getPVName(), 3, 'm3', True, 'Vol_pv')
        return comps

    ##########################################################################
    # Cell compartments 
    ##########################################################################
    def createCellCompartmentsDict(self):
        comps = dict()
        # hepatocyte compartments
        for k in self.cell_range():
            comps[getHepatocyteId(k)] = (getHepatocyteName(k), 3, 'm3', True, 'Vol_cell')
        return comps

    ##########################################################################
    # Species
    ##########################################################################    
    def createExternalSpeciesDict(self):
        '''
        All species which are defined external are generated in all 
        external compartments, i.e. PP, PV, sinusoid and disse space.
        '''
        sdict = dict()
        for data in self.external:
            (sid, init, units, boundaryCondition) = self.getItemsFromSpeciesData(data)
            
            name = self.names[sid]
            sdict[getPPSpeciesId(sid)] = (getPPSpeciesName(name), init, units, getPPId(), boundaryCondition)
            for k in self.cell_range():
                sdict[getSinusoidSpeciesId(sid, k)] = (getSinusoidSpeciesName(name, k), init, units, getSinusoidId(k), boundaryCondition)
                sdict[getDisseSpeciesId(sid, k)] = (getDisseSpeciesName(name, k), init, units, getDisseId(k), boundaryCondition)
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
                if full_id.startswith('c__'):
                    sdict[getHepatocyteSpeciesId(sid, k)] = (getHepatocyteSpeciesName(name, k), init, units, 
                                                             getHepatocyteId(k), boundaryCondition)    
        return sdict
    
    def getItemsFromSpeciesData(self, data):
        sid, init, units = data[0], data[1], data[2]
        # handle the constant species
        if len(data) == 4:
            boundaryCondition = data[3]
        else:
            boundaryCondition = False
        return (sid, init, units, boundaryCondition)
    

    ##########################################################################
    # Diffusion
    ##########################################################################
    def createDiffusionAssignments(self):
        ''' Create the geometrical diffusion constants 
            based on the external substances.
        '''
        for data in self.external:
            sid = data[0]
            # id, assignment, unit
            self.assignments.extend([
              ('Dx_sin_{}'.format(sid), 'D{}/x_sin * A_sin'.format(sid), "m3_per_s"),
              ('Dx_dis_{}'.format(sid), 'D{}/x_sin * A_dis'.format(sid), "m3_per_s"),
              ('Dy_sindis_{}'.format(sid), 'D{}/y_dis * f_fen * A_sindis'.format(sid), "m3_per_s")
            ])

    
    def createParametersDict(self, pars):
        pdict = dict()
        for pdata in pars:
            pid = pdata[0]
            # id, name, value, unit, constant
            pdict[pid] = [pid, self.names.get(pid, None), 
                          pdata[1], pdata[2], pdata[3]]
        return pdict
    

    def createUnits(self):
        for key, value in self.units.iteritems():
            createUnitDefinition(self.model, key, value)
        setMainUnits(self.model, self.main_units)
    
    def createExternalCompartments(self):
        comps = self.createExternalCompartmentsDict()
        createCompartments(self.model, comps)
        
    def createCellCompartments(self):
        comps = self.createCellCompartmentsDict()
        createCompartments(self.model, comps)
    
    def createExternalSpecies(self):
        sdict = self.createExternalSpeciesDict()
        createSpecies(self.model, sdict)
            
    def createCellSpecies(self):
        sdict = self.createCellSpeciesDict()
        createSpecies(self.model, sdict)
   
    def createExternalParameters(self):
        pdict = self.createParametersDict(self.pars)
        createParameters(self.model, pdict)
 
    def createCellParameters(self):
        pdict = self.createParametersDict(self.cellModel.pars)
        createParameters(self.model, pdict)
 
    def createInitialAssignments(self):
        self.createDiffusionAssignments()
        createInitialAssignments(self.model, self.assignments)
    
    def createCellInitialAssignments(self):
        createInitialAssignments(self.model, self.cellModel.assignments)
    
         
    def createAssignmentRules(self):
        createAssignmentRules(self.model, self.rules)

    def createCellInitData(self):
        initData = []
        for k in self.cell_range():
            d = dict()
            d['c__'] = getHepatocyteId(k) + '__'
            d['e__'] = getDisseId(k) + '__'
            initData.append(d)
        return initData
    
    def createCellAssignmentRules(self):
        rules = []
        initData = self.createCellInitData()
        for rule in self.cellModel.rules:
            for initDict in initData:
                r_new = [initString(rpart, initDict) for rpart in rule]
                rules.append(r_new)
        createAssignmentRules(self.model, rules)

    def createBoundaryConditions(self):
        ''' Set constant in periportal. '''
        sdict = self.createExternalSpeciesDict()
        for key in sdict.keys():
            if isPPSpeciesId(key):
                s = self.model.getSpecies(key)
                s.setBoundaryCondition(True)

    def createCellReactions(self):
        # set the model for the template
        ReactionTemplate.model = self.model
        
        initData = self.createCellInitData()
        for r in self.cellModel.reactions:
            r.createReactions(self.model, initData)
                
    def createTransportReactions(self):
        self.createFlowReactions()
        self.createDiffusionReactions()

    def createFlowReactions(self):
        flow = 'flow_sin * A_sin'     # [m3/s] volume flow
        for data in self.external:
            sid = data[0]    
            # flow PP -> S01 
            createFlowReaction(self.model, sid, c_from=getPPId(), c_to=getSinusoidId(1), flow=flow)
            # flow S[k] -> S[k+1] 
            for k in range(1, self.Nc):
                createFlowReaction(self.model, sid, c_from=getSinusoidId(k), c_to=getSinusoidId(k+1), flow=flow)
            # flow S[Nc] -> PV
            createFlowReaction(self.model, sid, c_from=getSinusoidId(self.Nc), c_to=getPVId(), flow=flow)
            # flow PV ->
            createFlowReaction(self.model, sid, c_from=getPVId(), c_to=NONE_ID, flow=flow);
    
    def createDiffusionReactions(self):        
        for data in self.external:
            sid = data[0]    
            # [1] sinusoid diffusion
            Dx_sin = 'Dx_sin_{}'.format(sid)
            
            createDiffusionReaction(self.model, sid, c_from=getPPId(), c_to=getSinusoidId(1), D=Dx_sin)
            for k in range(1, self.Nc):
                createDiffusionReaction(self.model, sid, c_from=getSinusoidId(k), c_to=getSinusoidId(k+1), D=Dx_sin)
            createDiffusionReaction(self.model, sid, c_from=getSinusoidId(self.Nc), c_to=getPVId(), D=Dx_sin)
            
            # [2] disse diffusion
            Dx_dis = 'Dx_dis_{}'.format(sid)
            for k in range(1, self.Nc):
                createDiffusionReaction(self.model, sid, c_from=getDisseId(k), c_to=getDisseId(k+1), D=Dx_dis)
            
            # [3] sinusoid - disse diffusion
            Dy_sindis = 'Dy_sindis_{}'.format(sid)
            for k in range(1, self.Nc+1):
                createDiffusionReaction(self.model, sid, c_from=getSinusoidId(k), c_to=getDisseId(k), D=Dy_sindis)
    
    def createCellEvents(self):
        ''' Creates the additional events defined in the cell model.
            These can be metabolic deficiencies, or other defined
            parameter changes.
            TODO: make this cleaner and more general.
        '''
        
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
        ''' Create the simulation timecourse events based on the 
            event data.
        '''
        if self.events:
            createSimulationEvents(self.model, self.events)
    
    
    def writeSBML(self, fname=None, validate=True):
        print 'libSBML {}'.format(libsbml.getLibSBMLDottedVersion())
        if not fname:
            fname = SBML_DIR + '/' + self.id + '.xml'
        
        print 'Write : {}\n'.format(self.id, fname)
        writer = SBMLWriter()
        writer.writeSBMLToFile(self.doc, fname)
    
        # validate the model with units (only for small models)
        if validate:
            validator = SBMLValidator(ucheck= (self.Nc<4) )
            validator.validate(fname)
    

    def storeInDatabase(self):
        ''' 
        SBML must already has be written in standard locaction
        before.
        '''
        from sim.models import SBMLModel
        model = SBMLModel.create(self.id, SBML_DIR);
        model.save();
        