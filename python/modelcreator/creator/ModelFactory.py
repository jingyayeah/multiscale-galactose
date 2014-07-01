'''
Core model factory to create the SBML model.
Based on basic information the SBML model is generated which than can be simulated.

What do you want?
- important to have fast turnover cycle in modeling, i.e.
  fast definition of the model structure and kinetics.

Easy to write and fast changeable model definition.
1. define objects (units, species, reactions, transporters, compartments, ....)
3. translate to SBML

@author: Matthias Koenig
@date: 2014-06-17  
'''

from libsbml import UNIT_KIND_SECOND, UNIT_KIND_MOLE,\
    UNIT_KIND_METRE,UNIT_KIND_KILOGRAM, SBMLDocument, SBMLWriter
        
from creator.tools.Naming import *
from creator.processes.ReactionFactory import *
from creator.sbml.SBMLValidator import SBMLValidator

from MetabolicModel import *
from creator.processes.ReactionTemplate import ReactionTemplate

class TissueModel(object):
    Nc = None
    version = None
        
    def __init__(self, cellModel):
        print '*'*40
        print '* Create TissueModel'
        print '*'*40
        self.id = 'GalactoseModel_v{}_Nc{}'.format(self.version, TissueModel.Nc)  
        self.doc = SBMLDocument(SBML_LEVEL, SBML_VERSION)
        self.model = self.doc.createModel(self.id)
        self.model.setName(self.id)
        self.cellModel = cellModel
    
    def cell_range(self):
        return range(1, TissueModel.Nc+1)
    
    #########################################################################
    names = dict()
    names['rbcM'] = 'red blood cells M*'
    names['suc'] = 'sucrose'
    names['alb'] = 'albumin'
    names['h2oM'] = 'water M*'
    names['glc'] = 'D-glucose'
    names['gal'] = 'D-galactose'
    names['galM'] = 'D-galactose M*'
    names['glc'] = 'D-glucose'
    names['glc1p'] = 'D-glucose 1-phophate'
    names['glc6p'] = 'D-glucose 6-phosphate'
    names['gal1p'] = 'D-galactose 1-phosphate'
    names['udpglc'] = 'UDP-D-glucose'
    names['udpgal'] = 'UDP-D-galactose'
    names['galtol'] = 'D-galactitol'
    names['atp'] = 'ATP'
    names['adp'] = 'ADP'
    names['utp'] = 'UTP'
    names['udp'] = 'UDP'
    names['phos'] = 'phosphate'
    names['ppi'] = 'pyrophosphate'
    names['nadp'] = 'NADP'
    names['nadph'] = 'NADPH'
    
    #########################################################################
    # Units
    ##########################################################################
    main_units = dict()
    main_units['time'] = 's'
    main_units['extent'] = UNIT_KIND_MOLE
    main_units['substance'] = UNIT_KIND_MOLE
    main_units['length'] = 'm'
    main_units['area'] = 'm2'
    main_units['volume'] = 'm3'

    units = dict()
    units['s'] = [(UNIT_KIND_SECOND, 1.0, 0)]
    units['kg'] = [(UNIT_KIND_KILOGRAM, 1.0, 0)]
    units['m'] = [(UNIT_KIND_METRE, 1.0, 0)]
    units['m2'] = [(UNIT_KIND_METRE, 2.0, 0)]
    units['m3'] = [(UNIT_KIND_METRE, 3.0, 0)]
    units['per_s'] = [(UNIT_KIND_SECOND, -1.0, 0)]
    units['mole_per_s'] = [(UNIT_KIND_MOLE, 1.0, 0), 
                       (UNIT_KIND_SECOND, -1.0, 0)]
    units['m_per_s'] = [(UNIT_KIND_METRE, 1.0, 0), 
                    (UNIT_KIND_SECOND, -1.0, 0)]
    units['m2_per_s'] = [(UNIT_KIND_METRE, 2.0, 0), 
                    (UNIT_KIND_SECOND, -1.0, 0)]
    units['m3_per_s'] = [(UNIT_KIND_METRE, 3.0, 0), 
                    (UNIT_KIND_SECOND, -1.0, 0)]
    units['mM']       = [(UNIT_KIND_MOLE, 1.0, 0), 
                    (UNIT_KIND_METRE, -3.0, 0)]
    units['per_mM']   = [(UNIT_KIND_METRE, 3.0, 0), 
                    (UNIT_KIND_MOLE, -1.0, 0)]
    units['kg_per_m3']   = [(UNIT_KIND_KILOGRAM, 1.0, 0), 
                    (UNIT_KIND_METRE, -3.0, 0)]
    units['m3_per_skg']   = [(UNIT_KIND_METRE, 3.0, 0), 
                    (UNIT_KIND_KILOGRAM, -1.0, 0), (UNIT_KIND_SECOND, -1.0, 0)]

    ##########################################################################
    # Parameters
    ##########################################################################
    pars = [
            # id, value, unit, constant
            ('L',           500E-6,   'm',      True),
            ('y_sin',       4.4E-6,   'm',      True),
            ('y_dis',       1.2E-6,   'm',      True),
            ('y_cell',      7.58E-6,  'm',      True),
            ('flow_sin',    180E-6,   'm_per_s',True),
            ('f_fen',       0.09,     '-',      True),
            ('Vol_liv',     1.5E-3,   'm3',     True),
            ('rho_liv',     1.1E3,    'kg_per_m3', True), 
            ('Q_liv',     1.750E-3/60.0, 'm3_per_s', True),
            ('Nc',             Nc,     '-',     True),       
            ('Nf',              1,     '-',     True),
    ]    
    names['L'] = 'sinusoidal length'
    names['y_sin'] = 'sinusoidal radius'
    names['y_dis'] = 'width space of disse'
    names['y_cell'] = 'width hepatocyte'
    names['flow_sin'] = 'sinusoidal flow velocity'
    names['f_fen'] = 'fenestraetion fraction'
    names['Vol_liv'] = 'liver reference volume'
    names['rho_liv'] = 'liver density'
    names['Q_liv'] = 'liver reference blood flow'
    names['Nc'] = 'hepatocytes in sinusoid'
    names['Nf'] = 'sinusoid volumes per cell'
        
    ##########################################################################
    # InitialAssignments
    ##########################################################################
    assignments = [
            # id, assignment, unit
            ('x_cell', 'L/Nc', 'm'),
            ('x_sin',  "x_cell/Nf", "m"),
            ("A_sin", "pi*y_sin^2",  "m2"),
            ("A_dis", "pi*(y_sin+y_dis)^2 - A_sin",  "m2"),
            ("A_sindis", "2*pi*y_sin*x_sin",  "m2"),
            ("Vol_sin", "A_sin*x_sin",  "m3"),
            ("Vol_dis", "A_dis*x_sin",  "m3"),
            ("Vol_cell", "pi*(y_sin+y_dis+y_cell)^2 *x_cell- pi*(y_sin+y_dis)^2*x_cell", "m3"),
            ("Vol_pp", "Vol_sin", "m3"),
            ("Vol_pv", "Vol_sin", "m3"),
            ("f_sin",  "Vol_sin/(Vol_sin + Vol_dis + Vol_cell)", '-'),
            ("f_dis", "Vol_dis/(Vol_sin + Vol_dis + Vol_cell)", '-'),
            ("f_cell", "Vol_cell/(Vol_sin + Vol_dis + Vol_cell)", '-'),
            ("Vol_sinunit", "L*pi*(y_sin + y_dis + y_cell)^2", "m3"),
            ("Q_sinunit", "pi*y_sin^2*flow_sin", "m3_per_s"),
            ("m_liv", "rho_liv * Vol_liv", "kg"),
            ("q_liv" , "Q_liv/m_liv", "m3_per_skg"),
    ]
    ##########################################################################
    # AssignmentRules
    ##########################################################################
    rules = []

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
    # External Species
    ##########################################################################
    external = [
           ('rbcM', 0.0, '-'),
           ('suc',  0.0, 'mM'),
           ('alb',  0.0, 'mM'),
           ('gal',  0.00012, 'mM'),
           ('galM', 0.0, 'mM'),
           ('h2oM', 0.0, 'mM'),
           ]
    
    def createExternalSpeciesDict(self):
        sdict = dict()
        # dis = sin, pp = sin, pv = sin
        # pp, pv, sin and disse are initialized identically
        for data in TissueModel.external:
            sid, init, units = data[0], data[1], data[2]
            name = TissueModel.names[sid]
            sdict[getPPSpeciesId(sid)] = (getPPSpeciesName(name), init, units, getPPId())
            for k in self.cell_range():
                sdict[getSinusoidSpeciesId(sid, k)] = (getSinusoidSpeciesName(name, k), init, units, getSinusoidId(k))
                sdict[getDisseSpeciesId(sid, k)] = (getDisseSpeciesName(name, k), init, units, getDisseId(k))
            sdict[getPVSpeciesId(sid)] = (getPVSpeciesName(name), init, units, getPVId())    
        return sdict
    
    def createCellSpeciesDict(self):
        sdict = dict()
        for data in self.cellModel.species:     
            full_id, init, units = data[0], data[1], data[2]
            tokens = full_id.split('__')
            sid = tokens[1]
            name = TissueModel.names[sid]
            for k in self.cell_range():
                if full_id.startswith('e__'):
                    # should already be created 
                    pass
                elif full_id.startswith('c__'):
                    sdict[getHepatocyteSpeciesId(sid, k)] = (getHepatocyteSpeciesName(name, k), init, units, getHepatocyteId(k))    
        return sdict
    
    ##########################################################################
    # External Transport
    ##########################################################################
    # Diffusion
    pars.extend(
            # diffusion constants [m^2/s]
            [
            ('DrbcM',  0.0E-12, 'm2_per_s', 'True'),
            ('Dsuc',   720E-12, 'm2_per_s', 'True'),
            ('Dalb',    90E-12, 'm2_per_s', 'True'),
            ('Dgal',   910E-12, 'm2_per_s', 'True'),
            ('DgalM',  910E-12, 'm2_per_s', 'True'),
            ('Dh2oM', 2200E-12, 'm2_per_s', 'True'),
            ])
    names['DrbcM'] = 'diffusion constant rbc M*'
    names['Dsuc'] = 'diffusion constant sucrose'
    names['Dalb'] = 'diffusion constant albumin'
    names['Dgal'] = 'diffusion constant galactose'
    names['DgalM'] = 'diffusion constant galactose M*'
    names['Dh2oM'] = 'diffusion constant water M*'
    
    # geometrical diffusion constants
    for data in external:
        sid = data[0]
        # id, assignment, unit
        assignments.extend([
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
    

    def createModel(self):
        # sinusoidal unit model
        self.createUnits()
        self.createExternalParameters()
        self.createInitialAssignments()
        self.createExternalCompartments()
        self.createExternalSpecies()
        self.createFlowReactions()
        self.createDiffusionReactions()
        
        # cell model
        self.createCellCompartments()
        self.createCellSpecies()
        self.createCellParameters()
        self.createCellInitialAssignments()
        self.createCellAssignmentRules()
        self.createCellReactions()
        # self.createCellEvents()
        # self.createBoundaryConditions()

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


    def createCellReactions(self):
        # set the model for the template
        ReactionTemplate.model = self.model
        
        initData = self.createCellInitData()
        for r in self.cellModel.reactions:
            r.createReactions(self.model, initData)
                
    
    def createFlowReactions(self):
        flow = 'flow_sin * A_sin'     # [m3/s] volume flow
        for data in TissueModel.external:
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
        for data in TissueModel.external:
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
    
    
        
    def createEvents(self):
        print 'create Events'
    
    def createBoundaryConditions(self):
        print 'create boundary conditions'
    
##########################################################################
if __name__ == "__main__":
    ###################
    from CellModel import GalactoseModel
    
    cm = GalactoseModel()
    TissueModel.Nc = 2
    TissueModel.version = 2
    gm = TissueModel(cm)
    gm.createModel()
    ###################
    
    print gm.id
    
    print '*' * 20
    writer = SBMLWriter()
    # sbml = writer.writeSBMLToString(gm.doc)
    # print sbml
    # print '*' * 20
    
    folder = '/home/mkoenig/multiscale-galactose-results/tmp_sbml/'
    file = folder + gm.id + '.xml'
    writer.writeSBMLToFile(gm.doc, file)
    
    # validate the model
    validator = SBMLValidator(ucheck=False)
    val_string = validator.validate(file)
   
    # make some example simulations
    
    
    # store in database
    import sys
    import os
    sys.path.append('/home/mkoenig/multiscale-galactose/python')
    os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
    
    from sim.models import SBMLModel
    # TODO: problems if the model already exists
    
    model = SBMLModel.create(gm.id, folder);
    model.save();
