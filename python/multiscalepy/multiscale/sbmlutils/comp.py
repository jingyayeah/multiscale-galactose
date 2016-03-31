"""
Utils for the creation and work with comp models.
"""
from __future__ import print_function, division

from mpmath.functions.factorials import fac2

import factory

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

PORT_TYPE_PORT = "port"
PORT_TYPE_INPUT = "input port"
PORT_TYPE_OUTPUT = "output port"


def _create_port(model, pid, name=None, portRef=None, idRef=None, unitRef=None, metaIdRef=None, portType=PORT_TYPE_PORT):
    cmodel = model.getPlugin("comp")
    p = cmodel.createPort()
    p.setId(pid)
    if name is not None:
        p.setName(name)
    if portRef is not None:
        p.setPortRef(portRef)
    if idRef is not None:
        p.setIdRef(idRef)
    if unitRef is not None:
        unit_str = factory.get_unit_string(unitRef)
        print("set unitRef")
        print(unit_str)
        res = p.setUnitRef(unit_str)
        print(res)
    if metaIdRef is not None:
        p.setMetaIdRef(metaIdRef)
    if portType == PORT_TYPE_PORT:
        # SBO:0000599 - port
        p.setSBOTerm(599)
    elif portType == PORT_TYPE_INPUT:
        # SBO:0000600 - input port
        p.setSBOTerm(600)
    elif portType == PORT_TYPE_OUTPUT:
        # SBO:0000601 - output port
        p.setSBOTerm(601)

    return p


##########################################################################
# Replacement helpers
##########################################################################
def replace_elements(model, sid, replaced_elements):
    """
    Replace elements in comp.
    """
    e = model.getElementBySId(sid)
    eplugin = e.getPlugin("comp")

    for mid, rep_ids in replaced_elements.iteritems():
        for rep_id in rep_ids:
            print(sid, '--rep-->', mid, ':', rep_id)
            replaced_element = eplugin.createReplacedElement()
            replaced_element.setSubmodelRef(mid)
            replaced_element.setIdRef(rep_id)


def replaced_by(model, sid, submodel_id, idRef):
    """
    The element with sid in the model is replaced by the
    replacing_id in the submodel with submodel_id.
    """
    e = model.getElementBySId(sid)
    eplugin = e.getPlugin("comp")
    rby = eplugin.createReplacedBy()
    rby.setIdRef(idRef)
    rby.setSubmodelRef(submodel_id)

