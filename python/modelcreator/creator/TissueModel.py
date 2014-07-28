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


class TissueModel(object):
    '''
    Here all the logic is performed to create the SBML model
    from the provided information.
    '''

    '''
        Generate the instance keys from the given 
        information fields
    '''
    # InstanceKeys are the available information.
    _keys = ['names']

    def __init__(self, mdict):
        for key, value in mdict.iteritems():
            setattr(self, key, value)
   
        self.id = self.createId()
        self.doc = SBMLDocument(SBML_LEVEL, SBML_VERSION)
        self.model = self.doc.createModel(self.id)
        self.model.setName(self.id)
        
        # The Nc has to be handed better
        self.pars.append(
            ('Nc', TissueModel.Nc, '-', True),
        )
        
        print '*'*40
        print self.id
        print '*'*40
        
        
    def createId(self):
        if self.simId:
            mid = '{}_v{}_Nc{}_{}'.format(self.cellModel.id, self.version, self.Nc, self.simId)
        else:
            mid = '{}_v{}_Nc{}'.format(self.cellModel.id, self.version, self.Nc)
        return mid
    
    def cell_range(self):
        return range(1, self.Nc+1)
    
    
    def info(self):
        for key in TissueModel._keys:
            print key, ' : ', getattr(self, key)
        
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
    external = []
    
    def createExternalSpeciesDict(self):
        ''' abstract method '''
        return
    
    def createCellSpeciesDict(self):
        ''' abstract method '''
        return
    
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
        for data in SinusoidalUnit.external:
            sid = data[0]
            # id, assignment, unit
            SinusoidalUnit.assignments.extend([
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
    
    
    def createExternalSpeciesDict(self):
        '''
        All species which are defined external are generated in all 
        external compartments, i.e. PP, PV, sinusoid and disse space.
        '''
        sdict = dict()
        for data in SinusoidalUnit.external:
            (sid, init, units, boundaryCondition) = self.getItemsFromSpeciesData(data)
            
            name = SinusoidalUnit.names[sid]
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
            name = SinusoidalUnit.names[sid]
            for k in self.cell_range():
                # TODO: only covers species in cytosol (has to work with arbitrary number of compartments)
                # necessary to have a mapping of the compartments to the functions which generate id and names
                if full_id.startswith('c__'):
                    sdict[getHepatocyteSpeciesId(sid, k)] = (getHepatocyteSpeciesName(name, k), init, units, 
                                                             getHepatocyteId(k), boundaryCondition)    
        return sdict
    

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
        for data in SinusoidalUnit.external:
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
        for data in SinusoidalUnit.external:
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
    
    def writeSBML(self, folder, validate=True):
        print 'libSBML {}'.format(libsbml.getLibSBMLDottedVersion())
        
        writer = SBMLWriter()
        fname = folder + '/' + self.id + '.xml'
        print 'Write : {}\n'.format(self.id, fname)
        writer.writeSBMLToFile(self.doc, fname)
    
        # validate the model with units (only for small models)
        if validate:
            validator = SBMLValidator(ucheck= (self.Nc<4) )
            validator.validate(fname)
    

    
    @staticmethod
    def createModel(module_name, cellModel, Nc, simId=None, events=None):
        '''
        A module which encodes a cell model is given and
        used to create the instance of the CellModel from
        the given global variables of the module.
        '''
        # dynamically import module
        tissue_module = __import__(module_name)
        
        # get attributes from the module
        print dir(tissue_module)
        mdict = dict()
        for key in TissueModel._keys:
            mdict[key] = getattr(tissue_module, key)
            
        # add the additional information
        mdict['cellModel'] = cellModel
        mdict['Nc'] = Nc
        mdict['simId'] = simId
        mdict['events'] = events
            
        
        return TissueModel(mdict)


def storeInDatabase(tissueModel, folder):
    ''' SBML must already be written. 
    TODO: this part belongs in the model creation part
    '''
    
    from sim.models import SBMLModel
    model = SBMLModel.create(tissueModel.id, folder);
    model.save();
        