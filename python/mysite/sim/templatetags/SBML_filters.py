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
def SBML_unitDefinitionToString1(ud):
    return libsbml.UnitDefinition_printUnits(ud)

unit_dict = dict()
unit_dict['kilogram'] = 'kg'
unit_dict['meter'] = 'm'
unit_dict['metre'] = 'm'
unit_dict['second'] = 's'

@register.filter
def SBML_unitDefinitionToString(udef):
    ''' Proper formating of the units. '''
    libsbml.UnitDefinition_reorder(udef)
    items = []
    for u in udef.getListOfUnits():
        # multiplier
        m = u.getMultiplier()
        if (abs(m-1.0) < 1E-10):
            m = ''
        else:
            m = str(m) + '*'
        s = u.getScale()
        e = u.getExponent()
        k = libsbml.UnitKind_toString(u.getKind())
        k = unit_dict.get(k, k)
        
        # (multiplier * 10^scale *ukind)^exponent
        if (s == 0 and e == 1):
            string = '{}{}'.format(m, k)
        elif (s == 0) and (m == ''):
            string = '{}^{}'.format(k,e)
        else:
            string = '({}10^{}*{})^{}'.format(m, s, k, e)
        items.append(string)
    return ' * '.join(items)

@register.filter
def SBML_modelHistoryToString(mhistory):
    return modelHistoryToString(mhistory)

@register.filter
def SBML_reactionToString(reaction):
    return equationStringFromReaction(reaction)

def equationStringFromReaction(reaction):
    left = halfEquation(reaction.getListOfReactants())
    right = halfEquation(reaction.getListOfProducts())
    if reaction.getReversible():
        sep = '<=>'
    else:
        sep = '=>' 
    return " ".join([left, sep, right])

def halfEquation(speciesList):
    items = []
    for sr in speciesList:
        stoichiometry = sr.getStoichiometry()
        species = sr.getSpecies()
        if abs(stoichiometry-1.0)<1E-8:
            sd = '{}'.format(species)
        elif abs(stoichiometry+1.0)<1E-8:
            sd = '-{}'.format(species)
        elif (stoichiometry > 0):
            sd = '{} {}'.format(stoichiometry, species)
        elif (stoichiometry < 0):  
            sd = '-{} {}'.format(stoichiometry, species)
        items.append(sd)
    return ' + '.join(items)

def modelHistoryToString(mhistory):
    '''
    Renders HTML representation of the model history.
    '''
    items = []
    for kc in xrange(mhistory.getNumCreators()):
        c = mhistory.getCreator(kc)
        items.append('<b>Creator</b>')
        if c.isSetGivenName():
            items.append(c.getGivenName())
        if c.isSetFamilyName():
            items.append(c.getFamilyName())
        if c.isSetOrganisation():
            items.append(c.getOrganisation())
        if c.isSetEmail():
            items.append(c.getEmail())
    items.append('<br />')
    if mhistory.isSetCreatedDate():
        items.append('<b>Created:</b> ' + dateToString(mhistory.getCreatedDate()))
    for km in xrange(mhistory.getNumModifiedDates()):
        items.append('<b>Modified:</b> ' + dateToString(mhistory.getModifiedDate(km)))
    
    items.append('<br />')
    return "<br />".join(items)

def dateToString(d):
    return "{}-{:0>2d}-{:0>2d} {:0>2d}:{:0>2d}".format(d.getYear(), d.getMonth(), d.getDay(), 
                                       d.getHour(), d.getMinute())
