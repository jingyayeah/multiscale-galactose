'''
Model factory for the creation of the sinusoidal metabolic models.
Cellular models are integrated into the sinusoidal structure.
A modular structure of processes for the single hepatocyte processes and transporters
exists which allows to reuse the created sinusoidal model for various simulations, like
clearance of a variety of substances.

Important features:
- important is a fast turnover between changes and simulations. 
  Currently this is quit cumbersome and necessary to write down the full network.
- single cell models as well as the full sinusoidal architecture have to be generated 
  at once.
   
@author: Matthias Koenig
@date: 2014-06-17  
'''
from libsbml import UNIT_KIND_SECOND, UNIT_KIND_MOLE,\
    UNIT_KIND_METRE,UNIT_KIND_KILOGRAM

#########################################################################
main_units = dict()
units = dict()
names = dict()
pars = []
external = []
assignments = []
rules = []

#########################################################################
# Main Units
##########################################################################
main_units['time'] = 's'
main_units['extent'] = UNIT_KIND_MOLE
main_units['substance'] = UNIT_KIND_MOLE
main_units['length'] = 'm'
main_units['area'] = 'm2'
main_units['volume'] = 'm3'
    
#########################################################################
# Units
##########################################################################  
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
units['per_m2']   = [(UNIT_KIND_METRE, -2.0, 0)]
units['kg_per_m3']   = [(UNIT_KIND_KILOGRAM, 1.0, 0), 
                    (UNIT_KIND_METRE, -3.0, 0)]
units['m3_per_skg']   = [(UNIT_KIND_METRE, 3.0, 0), 
                    (UNIT_KIND_KILOGRAM, -1.0, 0), (UNIT_KIND_SECOND, -1.0, 0)]

##########################################################################
# Parameters
##########################################################################
pars.extend([
            # id, value, unit, constant
            ('L',           500E-6,   'm',      True),
            ('y_sin',       4.4E-6,   'm',      True),
            ('y_end',     0.165E-6, 'm',      True),
            ('y_dis',       1.2E-6,   'm',      True),
            ('y_cell',     7.58E-6,  'm',      True),
            ('flow_sin',    180E-6,   'm_per_s',True),
            ('N_fen',        10E12,   'per_m2', True),
            ('r_fen',      53.5E-9,   'm',      True),
            
            ('rho_liv',     1.08E3,    'kg_per_m3', True), 
            ('f_tissue',     0.8, '-', True),
])
names['L'] = 'sinusoidal length'
names['y_sin'] = 'sinusoidal radius'
names['y_end'] = 'endothelial cell thickness'
names['y_dis'] = 'width space of Disse'
names['y_cell'] = 'width hepatocyte'
names['flow_sin'] = 'sinusoidal flow velocity'
names['N_fen'] = 'fenestrations per area'
names['r_fen'] = 'fenestration radius'

names['rho_liv'] = 'liver density'
names['f_tissue'] = 'parenchymal fraction of liver'
names['Nc'] = 'hepatocytes in sinusoid'
names['scale_f'] = 'metabolic scaling factor'
names['REF_P'] = 'reference protein amount'
names['deficiency'] = 'type of galactosemia'
names['gal_challenge'] = 'galactose challenge periportal'

##########################################################################
# AssignmentRules
##########################################################################
rules.extend([
            # id, assignment, unit
            ('x_cell', 'L/Nc', 'm'),
            ('x_sin',  "x_cell", "m"),
            ("A_sin", "pi*y_sin^2",  "m2"),
            ("A_dis", "pi*(y_sin+y_end+y_dis)^2 - pi*(y_sin+y_end)^2",  "m2"),
            ("A_sindis", "2 dimensionless *pi*y_sin*x_sin",  "m2"),
            ("A_sinunit", "pi*(y_sin+y_end+y_dis+y_cell)^2",  "m2"),
            ("Vol_sin", "A_sin*x_sin",  "m3"),
            ("Vol_dis", "A_dis*x_sin",  "m3"),
            ("Vol_cell", "pi*x_cell*( (y_sin+y_end+y_dis+y_cell)^2-(y_sin+y_end+y_dis)^2 )", "m3"),
            ("Vol_pp", "Vol_sin", "m3"),
            ("Vol_pv", "Vol_sin", "m3"),
            ("Vol_sinunit", "L*pi*(y_sin+y_end+y_dis+y_cell)^2", "m3"),
            ("f_sin",  "Vol_sin/(A_sinunit*x_sin)", '-'),
            ("f_dis", "Vol_dis/(A_sinunit*x_sin)", '-'),
            ("f_cell", "Vol_cell/(A_sinunit*x_sin)", '-'),
            ("Q_sinunit", "pi*y_sin^2*flow_sin", "m3_per_s"),
            ("f_fen", "N_fen*pi*(r_fen)^2", '-'),
            # ("m_liv", "rho_liv * Vol_liv", "kg"),
            # ("q_liv" , "Q_liv/m_liv", "m3_per_skg"),
])

names['x_cell'] = 'length cell compartment'
names['x_sin'] = 'length sinusoidal compartment'
names['A_sin'] = 'cross section sinusoid'
names['A_dis'] = 'cross section space of Disse'
names['A_sindis'] = 'exchange area between sinusoid and Disse'
names['A_sinunit'] = 'cross section sinusoidal unit'
names['Vol_sin'] = 'volume sinusoidal compartment'
names['Vol_dis'] = 'volume Disse compartment'
names['Vol_cell'] = 'volume cell compartment'
names['Vol_pp'] = 'volume periportal'
names['Vol_pv'] = 'volume perivenious'
names['Vol_sinunit'] = 'total volume sinusoidal unit'
names['f_sin'] = 'sinusoidal fraction of volume'
names['f_dis'] = 'Disse fraction of volume'
names['f_cell'] = 'cell fraction of volume'
names['Q_sinunit'] = 'volume flow sinusoid'
names['f_fen'] = 'fenestration porosity'
    

##########################################################################
# InitialAssignments
##########################################################################
assignments.extend([])
