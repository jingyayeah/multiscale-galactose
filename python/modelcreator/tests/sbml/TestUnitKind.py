'''
Created on Jun 18, 2014

@author: mkoenig
'''
from libsbml import SBMLDocument, SBMLWriter, UNIT_KIND_METER, UNIT_KIND_METRE

def createUnit(unitdef, kind, exponent, scale=0, multiplier=1.0):
    unit = unitdef.createUnit()
    unit.setKind(kind)
    unit.setExponent(exponent)
    unit.setScale(scale)
    unit.setMultiplier(multiplier)

if __name__ == "__main__": 
    doc = SBMLDocument(3,1)
    model = doc.createModel('test_UnitKind')
    
    # Does not work
    ud_1 = model.createUnitDefinition()
    ud_1.setId('m_1')
    createUnit(ud_1, UNIT_KIND_METER, 1)
    
    # works
    ud_2 = model.createUnitDefinition()
    ud_2.setId('m_2')
    createUnit(ud_2, UNIT_KIND_METRE, 1)
    
    writer = SBMLWriter()
    sbml = writer.writeSBMLToString(doc)    
    print sbml         
    
    

