"""
Utils for the creation and work with comp models.
"""

# Modeling frameworks
SBO_CONTINOUS_FRAMEWORK = 'SBO:0000062'
SBO_DISCRETE_FRAMEWORK = 'SBO:0000063'
SBO_FLUX_BALANCE_FRAMEWORK = 'SBO:0000624'


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


def add_submodel_from_emd(mplugin, submodel_sid, emd):
    model_ref = emd.getModelRef()
    submodel = mplugin.createSubmodel()
    submodel.setId(submodel_sid)
    submodel.setModelRef(model_ref)
    # copy the SBO term to the submodel

    # ! gets the model belonging the SBASe !
    # model = emd.getModel()
    import libsbml
    model = emd.getReferencedModel()
    if model.isSetSBOTerm():
        submodel.setSBOTerm(model.getSBOTerm())
    return submodel


def get_submodel_frameworks(doc):
    frameworks = {}
    # get list of submodels
    model = doc.getModel()
    mplugin = model.getPlugin("comp")

    # model.setSBOTerm(comp.SBO_CONTINOUS_FRAMEWORK)
    for submodel in mplugin.getListOfSubmodels():
        sid = submodel.getId()
        sbo = None
        if submodel.isSetSBOTerm():
            # This is the sbo which is set on the submodel element
            # not the SBO which is set on the model in listOfModels or
            # listOfExternalModels
            sbo = submodel.getSBOTerm()
        frameworks[sid] = {"sid": sid, "modelRef": submodel.getModelRef(), "sbo": sbo}

    return frameworks

##########################################################################
# Replacement helpers
##########################################################################
# TODO: more generic

def replace_compartment(model, cid, replaced_elements):
    c = model.getCompartment(cid)
    cplugin = c.getPlugin("comp")
    for element in replaced_elements:
        replaced_element = cplugin.createReplacedElement()
        replaced_element.setSubmodelRef(element)
        replaced_element.setIdRef(cid)


def replace_species(model, sid, replaced_elements):
    c = model.getSpecies(sid)
    cplugin = c.getPlugin("comp")
    for element in replaced_elements:
        replaced_element = cplugin.createReplacedElement()
        replaced_element.setSubmodelRef(element)
        replaced_element.setIdRef(sid)


def replace_parameters(model, sid, replaced_elements):
    c = model.getParameter(sid)
    cplugin = c.getPlugin("comp")
    for element in replaced_elements:
        replaced_element = cplugin.createReplacedElement()
        replaced_element.setSubmodelRef(element)
        replaced_element.setIdRef(sid)
