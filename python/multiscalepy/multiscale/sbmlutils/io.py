"""
Utility objects and methods for the work with SBML.
"""
from libsbml import *
from ..sbmlutils import validation

### QUALIFIER ##########################################################################################################

# from libsbmlconstants
QualifierType = {
  0: "MODEL_QUALIFIER",
  1: "BIOLOGICAL_QUALIFIER",
  2: "UNKNOWN_QUALIFIER"
}

ModelQualifierType = {
    0: "BQM_IS",
    1: "BQM_IS_DESCRIBED_BY",
    2: "BQM_IS_DERIVED_FROM",
    3: "BQM_IS_INSTANCE_OF",
    4: "BQM_HAS_INSTANCE",
    5: "BQM_UNKNOWN",
}

BiologcialQualifierType = {
   0: "BQB_IS",
   1: "BQB_HAS_PART",
   2: "BQB_IS_PART_OF",
   3: "BQB_IS_VERSION_OF",
   4: "BQB_HAS_VERSION",
   5: "BQB_IS_HOMOLOG_TO",
   6: "BQB_IS_DESCRIBED_BY",
   7: "BQB_IS_ENCODED_BY",
   8: "BQB_ENCODES",
   9: "BQB_OCCURS_IN",
  10: "BQB_HAS_PROPERTY",
  11: "BQB_IS_PROPERTY_OF",
  12: "BQB_HAS_TAXON",
  13: "BQB_UNKNOWN",
}

### MODEL CHECKING #####################################################################################################

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


### MODEL IO ###########################################################################################################

def write_and_check(doc, sbml_file):
    # write and check the SBML file
    writer = SBMLWriter()
    writer.writeSBML(doc, sbml_file)
    from validation import check_sbml
    check_sbml(sbml_file)


def write_sbml(doc, sbml_file, validate=True, program_name=None, program_version=None):
    """ Write SBML to file. """
    writer = SBMLWriter()
    if program_name:
        writer.setProgramName(program_name)
    if program_version:
        writer.setProgramVersion(program_version)
    writer.writeSBMLToFile(doc, sbml_file)

    # validate the model with units (only for small models)
    if validate:
        validation.validate_sbml(sbml_file)


def writeModelToSBML(model, filename):
    writer = SBMLWriter()
    doc = SBMLDocument()
    doc.setModel(model)
    writer.writeSBMLToFile(doc, filename)


def createSBMLFileNameFromModelId(modelId, folder):
    return folder + '/' + modelId + '.xml'

########################################################################################################################



