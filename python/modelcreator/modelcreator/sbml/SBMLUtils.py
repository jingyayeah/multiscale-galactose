'''
Created on Jun 17, 2014

@author: mkoenig
'''

from libsbml import *
import sys

def createSBMLFileNameFromModelId(modelId, folder):
    return folder + '/' + modelId + '.xml'
    
def writeModelToSBML(model, filename):
    writer = SBMLWriter()
    doc = SBMLDocument()
    doc.setModel(model)
    writer.writeSBMLToFile(doc, filename)
    
def check(value, message):
    """If 'value' is None, prints an error message constructed using
      'message' and then exits with status code 1. If 'value' is an integer,
      it assumes it is a libSBML return status code. If the code value is
      LIBSBML_OPERATION_SUCCESS, returns without further action; if it is not,
      prints an error message constructed using 'message' along with text from
      libSBML explaining the meaning of the code, and exits with status code 1.
    """
    if value == None:
        print('LibSBML returned a null value trying to ' + message + '.')
        print('Exiting.')
        sys.exit(1)
    elif type(value) is int:
        if value == LIBSBML_OPERATION_SUCCESS:
            return
        else:
            print('Error encountered trying to ' + message + '.')
            print('LibSBML returned error code ' + str(value) + ': "' \
                  + OperationReturnValue_toString(value).strip() + '"')
            print('Exiting.')
            sys.exit(1)
    else:
        return


