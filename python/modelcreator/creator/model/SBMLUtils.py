'''
Created on Jun 17, 2014

@author: mkoenig
'''

from libsbml import SBMLDocument, SBMLWriter



def createSBMLFileNameFromModelId(modelId, folder):
    return folder + '/' + modelId + '.xml'
    
def writeModelToSBML(model, filename):
    writer = SBMLWriter()
    doc = SBMLDocument()
    doc.setModel(model)
    writer.writeSBMLToFile(doc, filename)


