"""
Template for the creation of sinusoidal unit models.

Cellular models are integrated into the sinusoidal template with the
SBML comp extension.

The core idea is to have a modular model structure which allows the easy integration
of various single hepatocyte models.

Important features:
- important is a fast turnover between changes and simulations. 
  Currently this is quit cumbersome and necessary to write down the full network.
- single cell models as well as the full sinusoidal architecture have to be generated 
  at once.
"""
import units
import sbmlutils.modelcreator.modelcreator as mc

#########################################################################
mid = 'sinusoidal_unit'
version = 1
main_units = units.main_units
creators = units.creators


##########################################################################
# Parameters
##########################################################################
parameters = [
            # id, value, unit, constant
            mc.Parameter('L', 500E-6, 'm', constant=True, name='sinusoidal length'),
    mc.Parameter('y_sin',       4.4E-6,   'm',      True),
    mc.Parameter('y_end',     0.165E-6,   'm',      True),
    mc.Parameter('y_dis',       2.3E-6,   'm',      True),
    mc.Parameter('y_cell',     9.40E-6,   'm',      True),

    mc.Parameter('N_fen',        10E12,   'per_m2', True),
    mc.Parameter('r_fen',      53.5E-9,   'm',      True),

    mc.Parameter('rho_liv',     1.25E3,    'kg_per_m3', True),
    mc.Parameter('f_tissue',     0.8, '-', True),
    mc.Parameter('f_cyto',       0.4, '-', True),

    mc.Parameter('Pa',       1333.22, 'Pa', True), # 1mmHg = 133.322
            ('Pb',       266.64,  'Pa', True), 
            ('nu_f',     10.0, '-', True),
            ('nu_plasma', 0.0018, 'Pa_s', True),
]

names['Nc'] = 'number of cells in sinusoidal unit'

names['y_sin'] = 'sinusoidal radius'
names['y_end'] = 'endothelial cell thickness'
names['y_dis'] = 'width space of Disse'
names['y_cell'] = 'width hepatocyte'
names['flow_sin'] = 'sinusoidal flow velocity'
names['N_fen'] = 'fenestrations per area'
names['r_fen'] = 'fenestration radius'

names['rho_liv'] = 'liver density'
names['f_tissue'] = 'parenchymal fraction of liver'
names['f_cyto'] = 'cytosolic fraction of hepatocyte'

names['Pa'] = 'pressure periportal'
names['Pb'] = 'pressure perivenious'
names['Pa_per_mmHg'] = 'conversion factor between Pa and mmHg'
names['nu_f'] = 'viscosity factor for sinusoidal resistance'
names['nu_plasma'] = 'plasma viscosity'

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
            ('x_sin',  "x_cell/Nf", "m"),
            ("A_sin", "pi*y_sin^2",  "m2"),
            ("A_dis", "pi*(y_sin+y_end+y_dis)^2 - pi*(y_sin+y_end)^2",  "m2"),
            ("A_sindis", "2 dimensionless *pi*y_sin*x_sin",  "m2"),
            ("A_sinunit", "pi*(y_sin+y_end+y_dis+y_cell)^2",  "m2"),
            ("Vol_sin", "A_sin*x_sin",  "m3"),
            ("Vol_dis", "A_dis*x_sin",  "m3"),
            ("Vol_cell", "pi*x_cell*( (y_sin+y_end+y_dis+y_cell)^2-(y_sin+y_end+y_dis)^2 )", "m3"),
            ("Vol_cyto", "f_cyto*Vol_cell",  "m3"),
            ("Vol_pp", "Vol_sin", "m3"),
            ("Vol_pv", "Vol_sin", "m3"),
            ("Vol_sinunit", "L*pi*(y_sin+y_end+y_dis+y_cell)^2", "m3"),
            ("f_sin",  "Vol_sin/(A_sinunit*x_sin)", '-'),
            ("f_dis", "Vol_dis/(A_sinunit*x_sin)", '-'),
            ("f_cell", "Vol_cell/(A_sinunit*x_sin)", '-'),
            ('flow_sin',    'PP_Q/A_sin',   'm_per_s'),
            ("Q_sinunit", "PP_Q", "m3_per_s"),
            ("f_fen", "N_fen*pi*(r_fen)^2", '-'),
            # ("m_liv", "rho_liv * Vol_liv", "kg"),
            # ("q_liv" , "Q_liv/m_liv", "m3_per_skg"),
            ("P0", "0.5 dimensionless * (Pa+Pb)", 'Pa'),
            ("nu", "nu_f * nu_plasma", 'Pa_s'),
            ("W", "8 dimensionless * nu/(pi*y_sin^4)", 'Pa_s_per_m4'),
            ("w", "4 dimensionless *nu*y_end/(pi^2* r_fen^4*y_sin*N_fen)", 'Pa_s_per_m2'),
            ("lambda", "sqrt(w/W)", 'm'),
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
names['f_cyto'] = 'cytosolic fraction of cell volume'
names['f_fen'] = 'fenestration porosity'
names['P0'] = 'resulting oncotic pressure P0 = Poc-Pot'
names['nu'] = 'hepatic viscosity'
names['W'] = 'specific hydraulic resistance capillary'
names['w'] = 'specific hydraulic resistance of all pores'
    

##########################################################################
# InitialAssignments
##########################################################################
assignments.extend([])
