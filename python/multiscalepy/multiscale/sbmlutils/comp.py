"""
Utils for the creation and work with comp models.
"""
# TODO: allow generic arguments the factory function and use them to set
#   metaId, sbo, name, id,

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
# Ports
##########################################################################
# Ports are stored in an optional child ListOfPorts object, which,  if
# present, must contain one or more Port objects.  All of the Ports
# present in the ListOfPorts collectively define the 'port interface' of
# the Model.
def _create_port(model, pid, idRef, name=None):
    print("create port")
    cmodel = model.getPlugin("comp")
    p = cmodel.createPort()
    p.setId(pid)
    p.setIdRef(idRef)
    if name is not None:
        p.setName(name)
    return p


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
