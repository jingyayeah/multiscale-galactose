'''
Created on Jul 1, 2014
@author: mkoenig
'''
from libsbml import *

if __name__ == "__main__": 
    doc = SBMLDocument(3,1)
    model = doc.createModel('test_and')
    
    p = model.createParameter()
    p.setId('p1')
    p.setConstant(False)
    
    f1 = '(time>0)'
    print parseL3FormulaWithModel(f1, model)
    
    print '-' * 30
    
    f2 = '(time>0) and (p1>5)'
    print parseL3FormulaWithModel(f2, model)
    print parseFormula(f2)
    print parseL3Formula(f2)

    print '-' * 30
    
    f3 = '(time>0) && (p1>5)'
    print parseL3FormulaWithModel(f3, model)
    print parseL3Formula(f3)

    