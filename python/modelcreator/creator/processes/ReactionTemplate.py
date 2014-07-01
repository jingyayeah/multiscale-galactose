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

class ReactionTemplate(object):
    '''
    initData is a list of dictionaries which defines the 
    values for initialization of the reaction
    '''
    
    def __init__(self, rid, comps, name, equation, pars, rules, formula):
        self.rid = rid
        self.comps = comps
        self.name = name
        self.equation = Equation(equation)
        self.pars = pars
        self.rules = rules
        self.formula = formula
    
    def createReactions(self, model, initData):
        ''' Create the reaction based on the given comps dictionary '''
        for initDict in initData:
            self._createReaction(model, initDict)
        
    def _createReaction(self, model, initDict):
        # TODO: check if everything is initialized
        # i.e. are all the comp keys in the init dict
        
        # Create the parameter for the reaction
        
        
        # Create the rules for the reaction
        
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
    