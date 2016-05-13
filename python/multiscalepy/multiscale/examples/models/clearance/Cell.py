# -*- coding=utf-8 -*-
"""
Simple hepatic clearance model in SBML.

The model is used to test the coupling to PKPD and the sinusoidal models.
"""

from libsbml import XMLNode
from sbmlutils.modelcreator import templates

##############################################################
mid = 'Hepatic_clearance'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Hepatic clearance</h1>
    <h2>Description</h2>
    <p>
        This is a metabolism model of clearance metabolism in <a href="http://sbml.org">SBML</a> format.
    </p>
    """ + templates.terms_of_use + """
    </body>
    """)

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
# Species
##############################################################
species.update({
    # id : ('compartment', 'value', 'unit', 'boundaryCondition')
    'S_ext': ('e', 0.0021, 'mM', False),

    'S': ('c', 0, 'mM', False),
    'P': ('c', 0, 'mM', False),
})
names.update({
    'S_ext': 'substance S',
    'S': 'substance S',
    'P': 'product P',
})

##############################################################
# Compartments
##############################################################


##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')
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
    'f_cl': ('f_met * Vol_h', '-'),
})

##############################################################
# Reactions
##############################################################
import clearance_reactions as cr
reactions.extend([
    # TODO: cr.
])
