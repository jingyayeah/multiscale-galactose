'''
Created on Jun 17, 2014

What is the generall idea to best create the models:

What do you want?
Easy to write and fast changeable model definition: i.e. antimony strings


units:
unit substance = 1e-3 mole;


compartments:

compartment disse = 0.2 litre;
compartment hepatocyte = 1 litre;
compartment protein = 1 litre;

species:






1. define objects (units, species, reactions, transporters, compartments, ....)

3. translate to SBML


Core model generation class. 
 * Here the core models for DilutionIndicator studies and the galactose variations are
 * created.
 * 
 *    @author: Matthias Koenig
 *  @date: 2015-06-26  
 */


@author: mkoenig
'''
from libsbml import UNIT_KIND_SECOND, UNIT_KIND_MOLE, UNIT_KIND_METER,\
    UNIT_KIND_KILOGRAM, SBMLDocument, SBMLWriter, UnitKind_toString

import libsbml

SBML_LEVEL = 3
SBML_VERSION = 1
Nc = 20;    

class MetabolicModel(object):
    pass;
     


class GalactoseModel(MetabolicModel):
    version = 21
    
    def __init__(self, Nc):
        self.id = 'GalactoseModel_v{}_Nc{}'.format(self.version, Nc)  
        self.doc = SBMLDocument(SBML_LEVEL, SBML_VERSION)
        self.model = self.doc.createModel(self.id)
        self.model.setName(self.id)
    
    # Units
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
    units['m'] = [(UNIT_KIND_METER, 1.0, 0)]
    units['m2'] = [(UNIT_KIND_METER, 2.0, 0)]
    units['m3'] = [(UNIT_KIND_METER, 3.0, 0)]
    units['per_s'] = [(UNIT_KIND_SECOND, -1.0, 0)]
    units['mole_per_s'] = [(UNIT_KIND_MOLE, 1.0, 0), 
                       (UNIT_KIND_SECOND, -1.0, 0)]
    units['m_per_s'] = [(UNIT_KIND_METER, 1.0, 0), 
                    (UNIT_KIND_SECOND, -1.0, 0)]
    units['m2_per_s'] = [(UNIT_KIND_METER, 2.0, 0), 
                    (UNIT_KIND_SECOND, -1.0, 0)]
    units['m3_per_s'] = [(UNIT_KIND_METER, 3.0, 0), 
                    (UNIT_KIND_SECOND, -1.0, 0)]
    units['mM']       = [(UNIT_KIND_MOLE, 1.0, 0), 
                    (UNIT_KIND_METER, -3.0, 0)]
    units['per_mM']   = [(UNIT_KIND_METER, 3.0, 0), 
                    (UNIT_KIND_MOLE, -1.0, 0)]
    units['kg_per_m3']   = [(UNIT_KIND_KILOGRAM, 1.0, 0), 
                    (UNIT_KIND_METER, -3.0, 0)]
    units['m3_per_skg']   = [(UNIT_KIND_METER, 3.0, 0), 
                    (UNIT_KIND_KILOGRAM, -1.0, 0), (UNIT_KIND_SECOND, -1.0, 0)]

    def createUnits(self):
        for key, value in self.units.iteritems():
            self._createUnitDefinition(key, value)
        self._setMainUnits()
    
    def _createUnitDefinition(self, uid, units):
        ''' Creates the defined unit definitions. '''
        unitdef = self.model.createUnitDefinition()
        unitdef.setId(uid)
        for utuple in units:
            unit = unitdef.createUnit()
            unit.setKind(utuple[0])
            unit.setExponent(utuple[1])
            
    def _setMainUnits(self):
        ''' 
        Sets the main units for the model. 
        '''
        for key in ('time', 'extent', 'substance', 'length', 'area', 'volume'):
            unit = self.main_units[key]
            # get string if unit code
            if type(unit) is int:
                unit = UnitKind_toString(self.main_units[key])
            # set the values
            if key == 'time':
                self.model.setTimeUnits(unit)
            elif key == 'extent':
                self.model.setExtentUnits(unit)
            elif key == 'substance':
                self.model.setSubstanceUnits(unit)
            elif key == 'length':
                self.model.setLengthUnits(unit)
            elif key == 'area':
                self.model.setAreaUnits(unit)
            elif key == 'volume':
                self.model.setVolumeUnits(unit)
        
    def createCompartments(self):
        print 'Create compartments'
        
    def createSpecies(self):
        print 'Create species'
    
    def createInitialAssignments(self):
        print 'Create initial assignments'
    
    def createReactions(self):
        print 'Create reactions'
        
    def createEvents(self):
        print 'create events'
    

        

if __name__ == "__main__":
    
    test = UNIT_KIND_KILOGRAM
    print UnitKind_toString(test)
    print type(test)
    
    gal_model = GalactoseModel(Nc=20)
    print gal_model.id
    gal_model.createUnits()
    writer = SBMLWriter()
    sbml = writer.writeSBMLToString(gal_model.doc)
    print '*' * 20
    print sbml
    print '*' * 20

'''

##############################
# Parameters                 #
##############################
L =  500E-6;
y_sin = 4.4E-6;
y_dis = 1.2E-6;
y_cell = 7.58E-6;
flow_sin = 180E-6;
f_fen = 0.09;
Vol_liv = 1.5E-3;         
rho_liv = 1.1E3; 
Q_liv = 1.750E-3/60;
    


################
# Compartments #
################

comps_unit = 'm3'
comps = dict()
['PP', 'PV']
'D01', ... 'D20',
'H01', ... 'H20',

###########
# Species #
###########
sin = [
    'rbcM', 0.0, '-'
    'suc',  0.0, 'mM'
    'alb',  0.0, 'mM'
    'gal',  0.00012, 'mM'
    'galM', 0.0, 'mM'
    'h2oM', 0.0, 'mM'
]
dis = sin
pp = sin
pv = sin
cell = [
    'gal',             0.00012, 'mM'
    'galM',            0.0,     'mM'
    'h2oM',            0.0,     'mM'
    'glc1p',           0.012,   'mM'
    'glc6p',           0.12,    'mM'
    'gal1p',           0.001,   'mM'
    'udpglc',          0.34,    'mM'
    'udpgal',          0.11,    'mM'
    'galtol',          0.001,   'mM'
    
    'atp',              2.7,    'mM'
    'adp',              1.2,    'mM'
    'utp',              0.27,   'mM'
    'udp',              0.09,   'mM'
    'phos',             5.0,    'mM'
    'ppi',              0.008,  'mM'
    'nadp',             0.1,    'mM'
    'nadph',            0.1,    'mM'
]
# [m^2/s]
Ddata = [ 
    'rbcM',  0E-12
    'suc',   720E-12
    'alb',    90E-12
    'gal',   910E-12
    'galM',  910E-12
    'h2oM', 2200E-12
]

names = [
'glc', 'D-glucose'
'gal', 'D-galactose';
'galM', 'D-galactose M*'
'glc', 'D-glucose'
'glc1p', 'D-glucose 1-phophate'
'glc6p', 'D-glucose 6-phosphate'
'gal1p', 'D-galactose 1-phosphate'
'udpglc', 'UDP-D-glucose'
'udpgal', 'UDP-D-galactose'
'galtol', 'D-galactitol'
'atp', 'ATP'
'adp', 'ADP'
'utp', 'UTP'
'udp', 'UDP'
'phos', 'phosphate'
'ppi', 'pyrophosphate'
'nadp', 'NADP'
'nadph','NADPH'
]

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


