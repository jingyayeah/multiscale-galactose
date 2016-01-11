# -*- coding=utf-8 -*-
"""
Test model to check the update of global depending parameters in Roadrunner.
Mainly volumes which are calculated based on other parameters.
"""
from libsbml import XMLNode
from Reactions import *

##############################################################
mid = 'test'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Koenig Test Model</h1>
    <h2>Description</h2>
    <h2>Terms of use</h2>
    <div class="dc:rightsHolder">Copyright © 2015 Matthias Koenig.</div>
    <div class="dc:license">
        <p>Redistribution and use of any part of this model, with or without modification, are permitted provided that the following conditions are met:
        <ol>
          <li>Redistributions of this SBML file must retain the above copyright notice, this list of conditions and the following disclaimer.</li>
          <li>Redistributions in a different form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided
          with the distribution.</li>
        </ol>
        This model is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
        </p>
    </div>
    </body>
""")
creators = {
    # id : ('FamilyName', 'GivenName', 'Email', 'Organization')
    'mk': ('Koenig', 'Matthias', 'konigmatt@googlemail.com', 'Charite Berlin'),
}
units = dict()
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
    'e': (3, 'm3', True, 'Vol_e'),
    'c': (3, 'm3', False, 'Vol_c'),
    'm': (2, 'm2', True, 'A_m'),
})
names.update({
    'e': 'external',
    'c': 'cytosol',
    'm': 'membrane',
})

##############################################################
# Species
##############################################################
species.update({
    # id : ('compartment', 'value', 'unit', 'boundaryCondition')
    'e__gal':       ('e', 3.0, 'mM', True),
    'c__gal':       ('c', 0.00012, 'mM', False),
})
names.update({
    'gal': 'D-galactose',
})

##############################################################
# Parameters
##############################################################
parameters.update({
    # id: ('value', 'unit', 'constant')
    'x_cell':       (25E-6, 'm', True),
    'Vol_e':        (100E-6, 'm3', True),
    'A_m':          (1.0, 'm2', True),
})
names.update({
    'x_cell': 'cell diameter',
    'Vol_e': 'external volume',
    'Vol_c': 'cell volume',
    'A_m': 'membrane area',
})

##############################################################
# Assignments
##############################################################
assignments.update({
    # id: ('value', 'unit')
    'Vol_c': ('x_cell*x_cell*x_cell', 'm3'),
})

##############################################################
# Rules
##############################################################
rules.update({
    # id: ('value', 'unit')
})
names.update({
})


##############################################################
# Reactions
##############################################################
reactions.extend([
    GLUT2_GAL
])
