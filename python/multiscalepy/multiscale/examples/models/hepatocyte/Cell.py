import libsbml
from libsbml import UNIT_KIND_MOLE, UNIT_KIND_SECOND, UNIT_KIND_METRE, UNIT_KIND_KILOGRAM, UNIT_KIND_PASCAL
from sbmlutils.modelcreator import templates

##############################################################
creators = templates.creators
mid = 'hepatocyte'
version = 2
main_units = {
    'time': 's',
    'extent': UNIT_KIND_MOLE,
    'substance': UNIT_KIND_MOLE,
    'length': 'm',
    'area': 'm2',
    'volume': 'm3',
}
units = dict()
functions = dict()
compartments = dict()
species = dict()
parameters = dict()
names = dict()
assignments = dict()
rules = dict()
reactions = []

#########################################################################
# Units
##########################################################################
# units (kind, exponent, scale=0, multiplier=1.0)
units.update({
    's': [(UNIT_KIND_SECOND, 1.0)],
    'kg': [(UNIT_KIND_KILOGRAM, 1.0)],
    'm': [(UNIT_KIND_METRE, 1.0)],
    'm2': [(UNIT_KIND_METRE, 2.0)],
    'm3': [(UNIT_KIND_METRE, 3.0)],
    'per_s': [(UNIT_KIND_SECOND, -1.0)],
    'mole_per_s': [(UNIT_KIND_MOLE, 1.0),
                       (UNIT_KIND_SECOND, -1.0)],
    'mole_per_s_per_mM': [(UNIT_KIND_METRE, 3.0),
                       (UNIT_KIND_SECOND, -1.0) ],
    'mole_per_s_per_mM2': [(UNIT_KIND_MOLE, -1.0), (UNIT_KIND_METRE, 6.0),
                       (UNIT_KIND_SECOND, -1.0) ],
    'm_per_s': [(UNIT_KIND_METRE, 1.0),
                    (UNIT_KIND_SECOND, -1.0)],
    'm2_per_s': [(UNIT_KIND_METRE, 2.0),
                    (UNIT_KIND_SECOND, -1.0)],
    'm3_per_s': [(UNIT_KIND_METRE, 3.0),
                    (UNIT_KIND_SECOND, -1.0)],
    'mM': [(UNIT_KIND_MOLE, 1.0, 0),
                    (UNIT_KIND_METRE, -3.0)],
    'mM_s': [(UNIT_KIND_MOLE, 1.0), (UNIT_KIND_SECOND, 1.0),
                    (UNIT_KIND_METRE, -3.0)],
    'per_mM': [(UNIT_KIND_METRE, 3.0),
                    (UNIT_KIND_MOLE, -1.0)],
    'per_m2': [(UNIT_KIND_METRE, -2.0)],
    'per_m3': [(UNIT_KIND_METRE, -3.0)],
    'kg_per_m3': [(UNIT_KIND_KILOGRAM, 1.0),
                    (UNIT_KIND_METRE, -3.0)],
    'm3_per_skg': [(UNIT_KIND_METRE, 3.0),
                    (UNIT_KIND_KILOGRAM, -1.0), (UNIT_KIND_SECOND, -1.0)],
    'Pa': [(UNIT_KIND_PASCAL, 1.0)],
    'Pa_s': [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0)],
    'Pa_s_per_m4': [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0),
                     (UNIT_KIND_METRE, -4.0)],
    'Pa_s_per_m3': [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0),
                     (UNIT_KIND_METRE, -3.0)],
    'Pa_s_per_m2': [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0),
                     (UNIT_KIND_METRE, -2.0)],
    'm6_per_Pa2_s2': [(UNIT_KIND_PASCAL, -2.0), (UNIT_KIND_SECOND, -2.0),
                     (UNIT_KIND_METRE, 6.0)],
})

##############################################################
# Compartments
##############################################################
compartments.update({
    # id : ('spatialDimension', 'unit', 'constant', 'assignment')
    'e': (3, 'm3', False, 'Vol_e'),
    'h': (3, 'm3', False, 'Vol_h'),
    'c': (3, 'm3', False, 'Vol_c'),
    'pm': (2, 'm2', False, 'A_m'),
})
names.update({
    'e': 'external',
    'h': 'hepatocyte',
    'c': 'cytosol',
    'pm': 'plasma membrane',
})

##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')
    'f_met':      (0.31, 'per_m3', True),
    'y_cell':       (9.40E-6, 'm', True),
    'x_cell':       (25E-6, 'm', True),
    'f_tissue':     (0.8, '-', True),
    'f_cyto':       (0.4, '-', True),
})
names.update({
    'f_met': 'metabolic scaling factor',
    'y_cell': 'width hepatocyte',
    'x_cell': 'length hepatocyte',
    'f_tissue': 'parenchymal fraction of liver',
    'f_cyto': 'cytosolic fraction of hepatocyte'
})

##############################################################
# Assignments
##############################################################
assignments.update({
    # id: ('value', 'unit')
    'Vol_h': ('x_cell*x_cell*y_cell', 'm3'),
    'Vol_e': ('Vol_h', 'm3'),
    'Vol_c': ('f_cyto*Vol_h', 'm3'),
    'A_m': ('x_cell*x_cell', 'm2'),
})
names.update({
    'Vol_h': 'volume hepatocyte',
    'Vol_c': 'volume cytosol',
    'Vol_e': 'volume external compartment',
    'A_m': 'area plasma membrane',
})
