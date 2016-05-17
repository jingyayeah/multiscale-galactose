# -*- coding=utf-8 -*-
"""
Simple hepatic clearance model in SBML.

The model is used to test the coupling to PKPD and the sinusoidal models.
"""

from libsbml import XMLNode
from sbmlutils.modelcreator import templates
import sbmlutils.modelcreator.modelcreator as mc

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


##############################################################
# Species
##############################################################
species = [
    # id : ('compartment', 'value', 'unit', 'boundaryCondition')
    mc.Species(sid='S_ext', value=0.0021, unit='mM', compartment='e', name='substance S'),
    mc.Species(sid='S', value=0.0, unit='mM', compartment='c', name='substance S'),
    mc.Species(sid='P', value=0.0, unit='mM', compartment='c', name='product P'),
    mc.Species(sid='P_ext', value=0.0, unit='mM', compartment='e', name='product P'),
]

##############################################################
# Rules
##############################################################
rules = [
    mc.Rule(sid='f_cl', value='f_met * 0.2 dimensionless* Vol_h', unit='-')
]

##############################################################
# Reactions
##############################################################
import clearance_reactions as cr
reactions = [cr.ST,
             cr.S2P,
             cr.PT]
