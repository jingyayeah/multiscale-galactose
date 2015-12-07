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


def get_submodel_frameworks(doc):
    frameworks = {}
    # get list of submodels
    model = doc.getModel()
mplugin = model.getPlugin("comp")
    model.setSBOTerm(comp.SBO_CONTINOUS_FRAMEWORK)

    # add listOfSubmodels which reference the External models
    submodel_bounds = mplugin.createSubmodel()
    submodel_bounds.setId("bounds")
    submodel_bounds.setModelRef(emd_bounds.getModelRef())



    # find out the model type of the submodel via the model annotation

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
