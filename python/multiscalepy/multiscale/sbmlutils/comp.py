"""
Utils for the creation and work with comp models.
"""

##########################################################################
# ModelDefinitions
##########################################################################

def create_ExternalModelDefinition(mdoc, cid, sbml_file):
    extdef = mdoc.createExternalModelDefinition()
    extdef.setId(cid)
    extdef.setName(cid)
    extdef.setModelRef(cid)
    extdef.setSource(sbml_file)
    return extdef
