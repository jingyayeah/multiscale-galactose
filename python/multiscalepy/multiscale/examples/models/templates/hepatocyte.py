"""
Hepatocyte template model.
"""
from libsbml import UNIT_KIND_MOLE, UNIT_KIND_SECOND, UNIT_KIND_METRE, UNIT_KIND_KILOGRAM, UNIT_KIND_PASCAL
from sbmlutils.modelcreator import templates
import sbmlutils.modelcreator.modelcreator as mc

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

#########################################################################
# Units
##########################################################################
# units (kind, exponent, scale=0, multiplier=1.0)
units = [
    mc.Unit('s', [(UNIT_KIND_SECOND, 1.0)]),
    mc.Unit('kg', [(UNIT_KIND_KILOGRAM, 1.0)]),
    mc.Unit('m', [(UNIT_KIND_METRE, 1.0)]),
    mc.Unit('m2', [(UNIT_KIND_METRE, 2.0)]),
    mc.Unit('m3', [(UNIT_KIND_METRE, 3.0)]),
    mc.Unit('per_s', [(UNIT_KIND_SECOND, -1.0)]),
    mc.Unit('mole_per_s', [(UNIT_KIND_MOLE, 1.0),
                           (UNIT_KIND_SECOND, -1.0)]),
    mc.Unit('mole_per_s_per_mM', [(UNIT_KIND_METRE, 3.0),
                                  (UNIT_KIND_SECOND, -1.0) ]),
    mc.Unit('mole_per_s_per_mM2', [(UNIT_KIND_MOLE, -1.0), (UNIT_KIND_METRE, 6.0),
                                   (UNIT_KIND_SECOND, -1.0) ]),
    mc.Unit('m_per_s', [(UNIT_KIND_METRE, 1.0),
                        (UNIT_KIND_SECOND, -1.0)]),
    mc.Unit('m2_per_s', [(UNIT_KIND_METRE, 2.0),
                         (UNIT_KIND_SECOND, -1.0)]),
    mc.Unit('m3_per_s', [(UNIT_KIND_METRE, 3.0),
                    (UNIT_KIND_SECOND, -1.0)]),
    mc.Unit('mM', [(UNIT_KIND_MOLE, 1.0, 0),
                    (UNIT_KIND_METRE, -3.0)]),
    mc.Unit('mM_s', [(UNIT_KIND_MOLE, 1.0), (UNIT_KIND_SECOND, 1.0),
                    (UNIT_KIND_METRE, -3.0)]),
    mc.Unit('per_mM', [(UNIT_KIND_METRE, 3.0),
                    (UNIT_KIND_MOLE, -1.0)]),
    mc.Unit('per_m2', [(UNIT_KIND_METRE, -2.0)]),
    mc.Unit('per_m3', [(UNIT_KIND_METRE, -3.0)]),
    mc.Unit('kg_per_m3', [(UNIT_KIND_KILOGRAM, 1.0),
                    (UNIT_KIND_METRE, -3.0)]),
    mc.Unit('m3_per_skg', [(UNIT_KIND_METRE, 3.0),
                    (UNIT_KIND_KILOGRAM, -1.0), (UNIT_KIND_SECOND, -1.0)]),
    mc.Unit('Pa', [(UNIT_KIND_PASCAL, 1.0)]),
    mc.Unit('Pa_s', [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0)]),
    mc.Unit('Pa_s_per_m4', [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0),
                     (UNIT_KIND_METRE, -4.0)]),
    mc.Unit('Pa_s_per_m3', [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0),
                     (UNIT_KIND_METRE, -3.0)]),
    mc.Unit('Pa_s_per_m2', [(UNIT_KIND_PASCAL, 1.0), (UNIT_KIND_SECOND, 1.0),
                     (UNIT_KIND_METRE, -2.0)]),
    mc.Unit('m6_per_Pa2_s2', [(UNIT_KIND_PASCAL, -2.0), (UNIT_KIND_SECOND, -2.0),
                     (UNIT_KIND_METRE, 6.0)]),
]

##############################################################
# Compartments
##############################################################
compartments = [
    mc.Compartment('e', 'Vol_e', 'm3', constant=False, name='external'),
    mc.Compartment('h', 'Vol_h', 'm3', constant=False, name='hepatocyte'),
    mc.Compartment('c', 'Vol_c', 'm3', constant=False, name='cytosol'),
    mc.Compartment('pm', 'A_m', 'm2', constant=False, spatialDimension=2, name='plasma membrane')
]

##############################################################
# Parameters
##############################################################
parameters = [
    mc.Parameter('f_met', 0.31, 'per_m3', constant=True, name='metabolic scaling factor'),
    mc.Parameter('y_cell', 9.40E-6, 'm', constant=True, name='width hepatocyte'),
    mc.Parameter('x_cell', 25E-6, 'm', constant=True, name='length hepatocyte'),
    mc.Parameter('f_tissue', 0.8, '-', constant=True, name='parenchymal fraction of liver'),
    mc.Parameter('f_cyto', 0.4, '-', constant=True, name='cytosolic fraction of hepatocyte'),
]

##############################################################
# Assignments
##############################################################
assignments = [
    mc.Assignment('Vol_h', 'x_cell*x_cell*y_cell', 'm3', name='volume hepatocyte'),
    mc.Assignment('Vol_e', 'Vol_h', 'm3', name='volume cytosol'),
    mc.Assignment('Vol_c', 'f_cyto*Vol_h', 'm3', name='volume external compartment'),
    mc.Assignment('A_m', 'x_cell*x_cell', 'm2', name='area plasma membrane'),
]
