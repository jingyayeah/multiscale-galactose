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

TODO: where are the Nc and Nf parameters created?
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
            ('y_dis',       1.2E-6,   'm',      True),
            ('y_cell',      7.58E-6,  'm',      True),
            ('flow_sin',    180E-6,   'm_per_s',True),
            ('f_fen',       0.09,     '-',      True),
            ('Vol_liv',     1.5E-3,   'm3',     True),
            ('rho_liv',     1.1E3,    'kg_per_m3', True), 
            ('Q_liv',     1.750E-3/60.0, 'm3_per_s', True),
])
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
assignments.extend([
            # id, assignment, unit
            ('x_cell', 'L/Nc', 'm'),
            ('x_sin',  "x_cell", "m"),
            ("A_sin", "pi*y_sin^2",  "m2"),
            ("A_dis", "pi*(y_sin+y_dis)^2 - A_sin",  "m2"),
            ("A_sindis", "2 dimensionless *pi*y_sin*x_sin",  "m2"),
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
])

    
##########################################################################
# AssignmentRules
##########################################################################
rules.extend([])
