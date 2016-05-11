# -*- coding=utf-8 -*-
"""
Demo kinetic network.
"""
from libsbml import *
from sbmlutils.modelcreator.templates import terms_of_use, mkoenig
from Reactions import *


##############################################################
mid = 'Stahel_gastric_emptying'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Stahel gastric emptying</h1>
    <h2>Description</h2>
    <p>This is a simple model of glucose dynamics with gastric emptying
    <a href="http://sbmlutils.org" target="_blank" title="Access the definition of the SBML file format.">
    SBML</a>&#160;format.
    </p>
    """ + terms_of_use + """
    </body>
    """)
creators = mkoenig
main_units = {
    'time': 's',
    'extent': UNIT_KIND_MOLE,
    'substance': UNIT_KIND_MOLE,
    'length': 'm',
    'area': 'm2',
    'volume': 'm3',
}
units = dict()
compartments = dict()
species = dict()
parameters = dict()
names = dict()
assignments = dict()
rules = dict()
reactions = []
events = None


# parameters
# k_SP  # acetaminophen first order rate constant for gastric emptying
# k_AcUAc  # acetaminophen first order elimination
# PGl_end
# P_In
# U_In
# U_Gl
# BW  # bodyweight
# f_BW = 0.9  # [1/kg] correction for volume of distribution


# species
# AC_S  # acetaminophen (stomach)
# AC_P  # acetaminophen (plasma)
# Gl_S  # glucose (stomach)
# Gl_P  # glucose (plasma)
# In_P  # insulin (plasma)

# rate rules
# dAcS/dt = -kSP * AcS * Z




##############################################################
# Units
##############################################################
# units (kind, exponent, scale=0, multiplier=1.0)
units.update({
    's': [(UNIT_KIND_SECOND, 1.0)],
    'kg': [(UNIT_KIND_KILOGRAM, 1.0)],
    'm': [(UNIT_KIND_METRE, 1.0)],
    'm2': [(UNIT_KIND_METRE, 2.0)],
    'm3': [(UNIT_KIND_METRE, 3.0)],
    'mM': [(UNIT_KIND_MOLE, 1.0, 0),
           (UNIT_KIND_METRE, -3.0)],
    'mole_per_s': [(UNIT_KIND_MOLE, 1.0),
                   (UNIT_KIND_SECOND, -1.0)],
})
##############################################################
# Compartments
##############################################################
compartments.update({
    # id : ('spatialDimension', 'unit', 'constant', 'assignment')
    'e': (3, 'm3', False, 1e-06),
    'c': (3, 'm3', False, 1e-06),
    'm': (2, 'm2', False, 1),
})
names.update({
    'e': 'external compartment',
    'c': 'cell compartment',
    'm': 'plasma membrane'
})

##############################################################
# Species
##############################################################
species.update({
    # id : ('compartment', 'value', 'unit', 'boundaryCondition')
    'c__A': ('c', 0, 'mM', False),
    'c__B': ('c', 0.0, 'mM', False),
    'c__C': ('c', 0.0, 'mM', False),
    'e__A': ('e', 10.0, 'mM', False),
    'e__B': ('e', 0.0, 'mM', False),
    'e__C': ('e', 0.0, 'mM', False),
})
names.update({
    'A': 'A',
    'B': 'B',
    'C': 'C',
})

##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')
    'scale_f':      (1E-6, '-', True),
    'Vmax_bA':      (5.0, 'mole_per_s', True),
    'Km_A':         (1.0, 'mM', True),
    'Vmax_bB':      (2.0, 'mole_per_s', True),
    'Km_B':         (0.5, 'mM', True),
    'Vmax_bC':      (2.0, 'mole_per_s', True),
    'Km_C':         (3.0, 'mM', True),
    'Vmax_v1':      (1.0, 'mole_per_s', True),
    'Keq_v1':       (10.0, '-', True),
    'Vmax_v2':      (0.5, 'mole_per_s', True),
    'Vmax_v3':      (0.5, 'mole_per_s', True),
    'Vmax_v4':      (0.5, 'mole_per_s', True),
    'Keq_v4':       (2.0, '-', True),
})
names.update({
    'scale_f': 'metabolic scaling factor',
    'REF_P': 'reference protein amount',
    'deficiency': 'type of galactosemia',
    'y_cell': 'width hepatocyte',
    'x_cell': 'length hepatocyte',
    'f_tissue': 'parenchymal fraction of liver',
    'f_cyto': 'cytosolic fraction of hepatocyte'
})

##############################################################
# Assignments
##############################################################
assignments.update({
    # id: ('assignment', 'unit')
})

##############################################################
# Rules
##############################################################
rules.update({
    # id: ('rule', 'unit')
})

##############################################################
# Reactions
##############################################################
reactions.extend([
    bA, bB, bC, v1, v2, v3, v4
])
