# -*- coding=utf-8 -*-
"""
Human hepatic caffeine metabolism
"""

from libsbml import XMLNode
from sbmlutils.modelcreator import templates
import sbmlutils.modelcreator.modelcreator as mc

##############################################################
creators = templates.creators
mid = 'Hepatic_caffeine'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Koenig Human Caffeine Metabolism</h1>
    <h2>Description</h2>
    <p>
        This is a metabolism model of Human caffeine metabolism in <a href="http://sbml.org">SBML</a> format.
    </p>
    """ + templates.terms_of_use + """
    </body>
    """)

##############################################################
# Species
##############################################################
species = [
    mc.Species('caf_ext', value=0.0021, unit='mM', compartment='e', name='caffeine'),
    mc.Species('px_ext', value=0.010, unit='mM', compartment='e', name='paraxanthine'),
    mc.Species('tb_ext', value=0.0011, unit='mM', compartment='e', name='theobromine'),
    mc.Species('tp_ext', value=0.029, unit='mM', compartment='e', name='theophylline'),

    mc.Species('caf', value=0, unit='mM', compartment='c', name='caffeine'),
    mc.Species('px', value=0, unit='mM', compartment='c', name='paraxanthine'),
    mc.Species('tb', value=0, unit='mM', compartment='c', name='theobromine'),
    mc.Species('tp', value=0, unit='mM', compartment='c', name='theophylline'),
]

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


##############################################################
# Rules
##############################################################
rules = [
    mc.Rule('f_caf', value='f_met * Vol_h', unit='-', name='scaling factor')
]

##############################################################
# Reactions
##############################################################
'''
import caffeine_reactions as cr
reactions = [
    cr.CAFT,
    cr.PXT,
    cr.TBT,
    cr.TPT,
    cr.CAF2PX,
    cr.CAF2TB,
    cr.CAF2TP,
]
'''