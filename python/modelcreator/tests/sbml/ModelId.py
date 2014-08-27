'''
Created on Aug 27, 2014

@author: mkoenig
'''


from libsbml import *

if __name__ == "__main__": 
    doc = SBMLDocument(3,1)
    model = doc.createModel('test_pi')
    
    
    writer = SBMLWriter()
    sbml = writer.writeSBMLToString(doc)    
    print sbml
    
    writer = SBMLWriter()
    writer.writeSBMLToFile(doc, 'test.xml')
    
    
    