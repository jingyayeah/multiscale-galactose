'''
Django template filters related to the rendering of SBML.


Created on May 8, 2014
@author: mkoenig
'''

import libsbml
from sim.sbml.annotation.ModelAnnotation import annotationToHTML
from django import template
register = template.Library()

@register.filter
def SBML_astnodeToString(astnode):
    return libsbml.formulaToString(astnode)

@register.filter
def SBML_annotationToString(annotation):
    return annotationToHTML(annotation)

@register.filter
def SBML_unitDefinitionToString(ud):
    return libsbml.UnitDefinition_printUnits(ud)
