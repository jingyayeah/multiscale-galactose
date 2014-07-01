'''
Reaction Master which handels all the reaction related
creation of SBML content.

Created on Jun 30, 2014
@author: mkoenig
'''
import libsbml
from creator.tools.Naming import initString
from ReactionFactory import setKineticLaw
from creator.tools.Equation import Equation

from creator.MetabolicModel import createParameter, createAssignmentRules

class ReactionTemplate(object):
    '''
    initData is a list of dictionaries which defines the 
    values for initialization of the reaction
    '''
    model = None
    
    def __init__(self, rid, name, equation, pars, rules, formula):
        self.rid = rid
        self.name = name
        self.equation = Equation(equation)
        self.pars = pars
        self.rules = rules
        self.formula = formula
    
    def createReactions(self, model, initData):
        ''' Create the reaction based on the given comps dictionary '''
        for initDict in initData:
            self._createReaction(model, initDict)
    
    def _createParameters(self, initDict):
        ''' Parameters have to be initialized. '''
        for pdata in self.pars:
            p_new = [initString(part, initDict) for part in pdata]
            pid, value, unit = p_new[0], p_new[1], p_new[2]
            
            if not self.model.getParameter(pid):
                createParameter(self.model, pid, unit, name=None, value=value, constant=True)
    
    def _createRules(self, initDict):
        rules = []
        for rule in self.rules:
            r_new = [initString(part, initDict) for part in rule]
            rules.append(r_new)
        createAssignmentRules(self.model, rules)
    
    def _createReaction(self, model, initDict):
        # TODO: check if everything is initialized
        # i.e. are all the comp keys in the init dict
        
        # parameters and rules
        self._createParameters(initDict)
        self._createRules(initDict)
        
        # reaction
        r = model.createReaction()
        r.setId(initString(self.rid, initDict))
        r.setName(initString(self.name, initDict))
        r.setReversible(self.equation.reversible)
        r.setFast(False);
    
        #  equation
        for reactant in self.equation.reactants:
            sref = r.createReactant();
            sref.setSpecies(initString(reactant[1], initDict))
            sref.setStoichiometry(reactant[0]);
            sref.setConstant(True);
        for product in self.equation.products:
            sref = r.createProduct();
            sref.setSpecies(initString(product[1], initDict))
            sref.setStoichiometry(product[0]);
            sref.setConstant(True);
    
        # kinetics
        formula = initString(self.formula[0], initDict)
        setKineticLaw(model, r, formula) 

        return r;
    