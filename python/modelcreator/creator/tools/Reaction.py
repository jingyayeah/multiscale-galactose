'''
Created on Jun 30, 2014

@author: mkoenig
'''

        
        
        
     
        
    



class Reaction(object):
    
    
    def isReversible(self):
        if IRREVERSIBLE in self.equation:
        
    
    def createReactions(self, model, comps):
        ''' Create the reaction based on the given comps dictionary '''
        for c in comps:
            self._createReaction(model, c)
        
    def _createReaction(self, model, c):
        
        # reaction
        r = model.createReaction()
        r.setId(initComp(self.rid, c))
        r.setName(initComp(self.name, c))
        if self.isReversible()
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
    
def initComp(string, comp):
    return string.replace('c__', comp + '__')
    
