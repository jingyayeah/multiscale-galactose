# -*- coding=utf-8 -*-
"""
Hepatic glucose model (Koenig 2012).

Definition of units is done by defining the main_units of the model in
addition with the definition of the individual units of the model.

"""

# TODO: include microsome compartment

from libsbml import UNIT_KIND_KILOGRAM, UNIT_KIND_MOLE, UNIT_KIND_METRE, UNIT_KIND_SECOND, UNIT_KIND_LITRE
from libsbml import XMLNode
from ..templates import terms_of_use, mkoenig

##############################################################
mid = 'Hepatic_caffeine'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Koenig Human Caffeine Metabolism</h1>
    <h2>Description</h2>
    <p>
        This is a metabolism model of Human caffeine metabolism in <a href="http://sbml.org">SBML</a> format.
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
functions = dict()
compartments = dict()
species = dict()
parameters = dict()
names = dict()
assignments = dict()
rules = dict()
reactions = []

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
# Species
##############################################################
species.update({
    # id : ('compartment', 'value', 'unit', 'boundaryCondition')
    'caf_ext': ('e', 0.0021, 'mM', False),
    'px_ext': ('e', 0.010, 'mM', False),
    'tb_ext': ('e', 0.0011, 'mM', False),
    'tp_ext': ('e', 0.029, 'mM', False),

    'caf': ('c', 0, 'mM', False),
    'px': ('c', 0, 'mM', False),
    'tb': ('c', 0, 'mM', False),
    'tp': ('c', 0, 'mM', False),

    # 'atp': ('c', 2.8000, 'mM', False),
    # 'adp': ('c', 0.8000, 'mM', False),
    # 'amp': ('c', 0.1600, 'mM', False),
    # 'utp': ('c', 0.2700, 'mM', False),
    # 'udp': ('c', 0.0900, 'mM', False),
    # 'gtp': ('c', 0.2900, 'mM', False),
    # 'gdp': ('c', 0.1000, 'mM', False),
    # 'nad': ('c', 1.2200, 'mM', False),
    # 'nadh': ('c', 0.56E-3, 'mM', False),
    # 'phos': ('c', 5.0000, 'mM', False),
    # 'pp': ('c', 0.0080, 'mM', False),
    # 'co2': ('c', 5.0000, 'mM', False),
    # 'h2o': ('c', 0.0, 'mM', False),
    # 'hydron': ('c', 0.0, 'mM', False),

})
names.update({
    'caf_ext': 'caffeine',
    'px_ext': 'paraxanthine',
    'tb_ext': 'theobromine',
    'tp_ext': 'theophylline',

    'caf': 'caffeine',
    'px': 'paraxanthine',
    'tb': 'theobromine',
    'tp': 'theophylline',

    'atp': 'ATP',
    'adp': 'ADP',
    'amp': 'AMP',
    'utp': 'UTP',
    'udp': 'UDP',
    'gtp': 'GTP',
    'gdp': 'GDP',
    'nad': 'NAD+',
    'nadh': 'NADH',
    'phos': 'phosphate',
    'pp': 'pyrophosphate',
    'co2': 'CO2',
    'h2o': 'H2O',
    'hydron': 'H+',
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

##############################################################
# Rules
##############################################################
rules.update({
    # id: ('value', 'unit')
    # 'c__nad_bal': ('nad + nadh', 'mM'),
    # 'c__adp_bal': ('atp + adp', 'mM'),
    # 'c__udp_bal': ('utp + udp', 'mM'),
    'f_caf': ('f_met * Vol_h', '-'),

})
names.update({
    'nad_bal': 'NAD balance',
    'adp_bal': 'ADP balance',
    'udp_bal': 'UDP balance',
})


##############################################################
# Reactions
##############################################################
import Reactions
reactions.extend([
    Reactions.CAFT,
    Reactions.PXT,
    Reactions.TBT,
    Reactions.TPT,
    Reactions.CAF2PX,
    Reactions.CAF2TB,
    Reactions.CAF2TP,
])
