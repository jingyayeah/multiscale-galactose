'''
Created on Jun 24, 2014

@author: mkoenig
'''

from libsbml import *

if __name__ == "__main__": 
    doc = SBMLDocument(3,1)
    model = doc.createModel('test_pi')

    sid = 'pi_test'
    p = model.createParameter()
    p.setId(sid)
    p.setConstant(True)
    
    ia = model.createInitialAssignment()
    ia.setSymbol(sid);
    astnode = parseL3FormulaWithModel('pi', model)
    ia.setMath(astnode);   
    
    writer = SBMLWriter()
    sbml = writer.writeSBMLToString(doc)    
    
    print sbml
    print '*' * 80
    udefs = ia.getDerivedUnitDefinition()
    print UnitDefinition_printUnits(udefs)
    # InitialAssignment.getDerivedUnitDefinition(self)
    
    