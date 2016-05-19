"""
Sinusoidal species in clearance model.
"""

from libsbml import XMLNode
from sbmlutils.modelcreator import templates
import sbmlutils.modelcreator.modelcreator as mc


##############################################################
mid = 'Hepatic_clearance'
version = 1
notes = XMLNode.convertStringToXMLNode("""
    <body xmlns='http://www.w3.org/1999/xhtml'>
    <h1>Clearance sinusoid</h1>
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
