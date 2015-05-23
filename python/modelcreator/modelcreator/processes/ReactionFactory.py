'''
Created on Jun 19, 2014

@author: mkoenig
'''
import libsbml
from modelcreator.tools.naming import *

def setKineticLaw(model, reaction, formula):
    ''' Sets the kinetic law in reaction based on given formula. '''
    law = reaction.createKineticLaw();
    astnode = libsbml.parseL3FormulaWithModel(formula, model)
    law.setMath(astnode);
    return law;

def createFlowReaction(model, sid, c_from, c_to, flow):
    ''' Creates the convection reaction of sid between c_from -> c_to.'''
    sid_from = createLocalizedId(c_from, sid)
    sid_to = createLocalizedId(c_to, sid)
    rid = createFlowId(c_from, c_to, sid)
    rname = createFlowName(c_from, c_to, sid)
    
    # reaction
    r = model.createReaction()
    r.setId(rid)
    r.setName(rname)
    r.setReversible(False)
    r.setFast(False);
    
    # equation
    sref = r.createReactant();
    sref.setSpecies(sid_from)
    sref.setStoichiometry(1.0);
    sref.setConstant(True);
    if c_to != NONE_ID:
        sref = r.createProduct();
        sref.setSpecies(sid_to)
        sref.setStoichiometry(1.0);
        sref.setConstant(True);
    
    # kinetics
    formula = '{} * {}'.format(flow, sid_from) # in [mole/s]
    setKineticLaw(model, r, formula) 

    return r;

def createDiffusionReaction(model, sid, c_from, c_to, D):
    ''' Creates the diffusion reaction of sid between c_from <-> c_to. '''
    sid_from = createLocalizedId(c_from, sid)
    sid_to = createLocalizedId(c_to, sid)
    rid = createDiffusionId(c_from, c_to, sid)
    rname = createDiffusionName(c_from, c_to, sid)
    
    # reaction
    r = model.createReaction()
    r.setId(rid)
    r.setName(rname)
    r.setReversible(True)
    r.setFast(False);
    
    # equation
    sref = r.createReactant();
    sref.setSpecies(sid_from)
    sref.setStoichiometry(1.0);
    sref.setConstant(True);
    if c_to != NONE_ID:
        sref = r.createProduct();
        sref.setSpecies(sid_to)
        sref.setStoichiometry(1.0);
        sref.setConstant(True);

    # kinetics
    if c_to:
        formula = "{} * ({} - {})".format(D, sid_from, sid_to) # in [mole/s]
    else:
        formula = "{} * ({})".format(D, sid_from)
    setKineticLaw(model, r, formula) 

    return r;
