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
    

from MetabolicModel import MetabolicModel, SBML_LEVEL, SBML_VERSION


class GalactoseModel(MetabolicModel):
    version = 22
    Nc = 4
    
    def __init__(self, Nc):
        self.id = 'GalactoseModel_v{}_Nc{}'.format(self.version, Nc)  
        self.doc = SBMLDocument(SBML_LEVEL, SBML_VERSION)
        self.model = self.doc.createModel(self.id)
        self.model.setName(self.id)
        self.Nc = Nc
    
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
            # diffusion [m^2/s]
            ('DrbcM',  0E-12, 'm2_per_s', 'True'),
            ('Dsuc',   720E-12, 'm2_per_s', 'True'),
            ('Dalb',    90E-12, 'm2_per_s', 'True'),
            ('Dgal',   910E-12, 'm2_per_s', 'True'),
            ('DgalM',  910E-12, 'm2_per_s', 'True'),
            ('Dh2oM', 2200E-12, 'm2_per_s', 'True'),
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
    
    names['DrbcM'] = 'diffusion constant rbc'
    names['Dsuc'] = 'diffusion constant sucrose'
    names['Dalb'] = 'diffusion constant albumin'
    names['Dgal'] = 'diffusion constant galactose'
    names['DgalM'] = 'diffusion constant galactose M*'
    names['Dh2oM'] = 'diffusion constant water M*'
    
    ##########################################################################
    # InitialAssignments
    ##########################################################################
    initialAssignments = [
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

    #########################################################################
    # External Compartments
    ##########################################################################
    # id, name, spatialDimension, unit, constant, assignment/value
    comps = dict()
    comps['PP'] = ('[PP] periportal', 3, 'm3', True, 'Vol_pp')
    # sinusoid
    for k in range(1, Nc+1):
        cid = 
        comps['S{:0>2d}'.format(k) ] = ('[S{:0>2d}] sinusoid'.format(k), 3, 'm3', True, 'Vol_sin')
    # disse
    for k in range(1, Nc+1):
        comps['D{:0>2d}'.format(k) ] = ('[D{:0>2d}] disse'.format(k), 3, 'm3', True, 'Vol_dis')
    comps['PV'] = ('[PV] perivenious', 3, 'm3', True, 'Vol_pv')
    
    
    def getPPCompartment(self, k):
        return 'PP'
    def getPVCompartment(self, k):
        return 'PV'
    
    
    def getSinusoidCompartment(self, k):
        return 'S{:0>2d}'.format(k)
    
    def getDisseCompartment(self, k):
        return 'D{:0>2d}'.format(k)
    
     
    ##########################################################################
    # External Species
    ##########################################################################
    sin = [
           ('rbcM', 0.0, '-'),
           ('suc',  0.0, 'mM'),
           ('alb',  0.0, 'mM'),
           ('gal',  0.00012, 'mM'),
           ('galM', 0.0, 'mM'),
           ('h2oM', 0.0, 'mM'),
           ]
    sdict = dict()
    # dis = sin, pp = sin, pv = sin
    # pp, pv, sin and disse are initialized identically
    for data in sin:
        sdict['PP'] = (names[data[0]]+' [PP]', data[1], data[2])
        sdict['PV'] = (names[data[0]]+' [PV]', data[1], data[2])
        for k in range(1, Nc+1):
             
            cid = 'S{:0>2d}'.format(k)
            sdict['{}__{}'.format(cid, data[0])] = ('{} [{}]'.format(names[data[0]], cid), data[1], data[2], cid)
            
            cid = 'D{:0>2d}'.format(k) 
            sdict['{}__{}'.format(cid, data[0])] = (names[data[0]]+' [D{:0>2d}]'.format(k), data[1], data[2], cid)
    
    ##########################################################################

    def createModel(self):
        self.createUnits()
        self.createParameters()
        self.createInitialAssignments()
        self.createExternalCompartments()
        self.createExternalSpecies()

    def createUnits(self):
        for key, value in self.units.iteritems():
            self._createUnitDefinition(key, value)
        self._setMainUnits()
    
        
    def createExternalCompartments(self):
        for cid in sorted(self.comps):
            # comps['PV'] = ('[PV] perivenious', 3, 'm3', True, 'value)
            data = self.comps[cid]
            name = data[0]
            dims = data[1]
            units = data[2]
            constant = data[3]
            value = data[4]
            self._createCompartment(cid, name, dims, units, constant, value)
    
    def createCellCompartments(self):
        pass
        
    def createExternalSpecies(self):
        for sid in sorted(self.sdict):
            # comps['PV'] = ('[PV] perivenious', 3, 'm3', True)
            data = self.sdict[sid]
            name = data[0]
            init = data[1]
            units = data[2]
            self._createSpecies(sid, name, init, units)
    
    def createParameters(self):
        for pdata in (self.pars):
            # id, value, unit, constant
            pid = pdata[0]
            name = self.names.get(pid, None)
            value = pdata[1]
            unit = self.getUnitString(pdata[2])
            p = self._createParameter(pid=pid, unit=unit, name=name, value=value, constant=pdata[3])

        
    def createInitialAssignments(self):
        for data in self.initialAssignments:
            # id, assignment, unit
            pid = data[0]
            unit = self.getUnitString(data[2])
            # Create parameter if not existing
            if not self.model.getParameter(pid):
                self._createParameter(pid, unit, name=None, value=None, constant=True)
            self._createInitialAssignment(sid=pid, formula=data[1])

         
    def createAssignmentRule(self):
        # AssignmentRule rule = model.createAssignmentRule();
        # rule.setMath(ASTNode.parseFormula(formula));
        # rule.setVariable(id);
        pass  
    
    def createFlowReactions(self):
        print 'Create Flow reactions'
    
    def createDiffusionReactions(self):
        print 'Create Diffusion reactions'
    
    
    def createCellReactions(self):
        print 'Create Cell reactions'
        
    def createEvents(self):
        print 'create Events'
    
    def createBoundaryConditions(self):
        print 'create boundary conditions'



if __name__ == "__main__":
    
    
    
    gal_model = GalactoseModel(Nc=20)
    gal_model.createModel()
    print gal_model.id
   
    
    writer = SBMLWriter()
    sbml = writer.writeSBMLToString(gal_model.doc)
    print '*' * 20
    print sbml
    print '*' * 20
    
    folder = '/home/mkoenig/multiscale-galactose-results/tmp_sbml/'
    file = folder + gal_model.id + '.xml'
    writer.writeSBMLToFile(gal_model.doc, file)
    
    # store in database
    import sys
    import os
    sys.path.append('/home/mkoenig/multiscale-galactose/python')
    os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
    
    from sim.models import SBMLModel
    # TODO: problems if the model already exists
    
    model = SBMLModel.create(gal_model.id, folder);
    model.save();
    
    

    
'''

##############################
# Parameters                 #
##############################

    
        cell = [
            ('gal',             0.00012, 'mM'),
            ('galM',            0.0,     'mM'),
            ('h2oM',            0.0,     'mM'),
            ('glc1p',           0.012,   'mM'),
            ('glc6p',           0.12,    'mM'),
            ('gal1p',           0.001,   'mM'),
            ('udpglc',          0.34,    'mM'),
            ('udpgal',          0.11,    'mM'),
            ('galtol',          0.001,   'mM'),
    
            ('atp',              2.7,    'mM'),
            ('adp',              1.2,    'mM'),
            ('utp',              0.27,   'mM'),
            ('udp',              0.09,   'mM'),
            ('phos',             5.0,    'mM'),
            ('ppi',              0.008,  'mM'),
            ('nadp',             0.1,    'mM'),
            ('nadph',            0.1,    'mM'),
    ]

    for data in cell:
        for k in range(1, Nc+1):
            sdict['H{:0>2d}__{}'.format(k, data[0])] = (names[data[0]]+' [H{:0>2d}]'.format(k), data[1], data[2])


###########
# Species #
###########





# Reactions

# general definition
%% [GLUT2_GAL] galactose transport (gal_dis <-> gal)
%% [GLUT2_GALM] galactoseM transport (galM_dis <-> galM)

%------------------------------------------------------------
class GLUT2_GAL():
    id = 'GLUT2_GAL'
    name = 'galactose transport (gal_dis <-> gal)'
    equation = 'gal_dis <-> gal'
    unit = 'mole/s'
    
    parameters = [
        (GLUT2_P, 1.0, 'mM')
        (GLUT2_f, 0.5E6, '-')
        (GLUT2_k_gal, 85.5, 'mM')
    ]

    # assignments / initial assignment
    GLUT2_Vmax = GLUT2_f * scale * GLUT2_P/REF_P;  % [mole/s]
    GLUT2_dm = (1 + (gal_dis+galM_dis)/GLUT2_k_gal + (gal+galM)/GLUT2_k_gal); % [-]

    GLUT2_GAL_dis  = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (gal_dis - gal*onevec)./GLUT2_dm;    % [mole/s]
    GLUT2_GALM_dis = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (galM_dis - galM*onevec)./GLUT2_dm;  % [mole/s]

    GLUT2_GAL  = sum(GLUT2_GAL_dis);    % [mole/s]
    GLUT2_GALM = sum(GLUT2_GALM_dis);   % [mole/s]


'''


