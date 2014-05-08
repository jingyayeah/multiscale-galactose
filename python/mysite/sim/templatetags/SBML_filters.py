'''
Created on May 8, 2014
@author: mkoenig
'''

import libsbml
from django import template
register = template.Library()

@register.filter
def SBML_formulaToString(astnode):
    return libsbml.formulaToString(astnode)