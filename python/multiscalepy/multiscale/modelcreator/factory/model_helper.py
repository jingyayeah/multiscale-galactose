"""
Definition of general helper functions to create the various
objects in the SBML. 
These functions are called with the information dictionaries 
during the generation of cell and tissue model.
"""
from __future__ import print_function
import libsbml
from libsbml import UNIT_KIND_DIMENSIONLESS, UnitKind_toString

SBML_LEVEL = 3
SBML_VERSION = 1

##########################################################################
# Units
##########################################################################
def createUnitDefinition(model, uid, units):
    """ Creates the defined unit definitions. """
    unitdef = model.createUnitDefinition()
    unitdef.setId(uid)
    for data in units:
        kind = data[0]
        exponent = data[1]
        scale = 0
        multiplier = 1.0
        if len(data) > 2:
            scale = data[2]
        if len(data) > 3:
            multiplier = data[3]

        _createUnit(unitdef, kind, exponent, scale, multiplier)


def _createUnit(unitdef, kind, exponent, scale=0, multiplier=1.0):
    unit = unitdef.createUnit()
    unit.setKind(kind)
    unit.setExponent(exponent)
    unit.setScale(scale)
    unit.setMultiplier(multiplier)


def setMainUnits(model, main_units):
    """ Sets the main units for the model. """
    for key in ('time', 'extent', 'substance', 'length', 'area', 'volume'):
        unit = main_units[key]
        unit = getUnitString(unit)
        # set the values
        if key == 'time':
            model.setTimeUnits(unit)
        elif key == 'extent':
            model.setExtentUnits(unit)
        elif key == 'substance':
            model.setSubstanceUnits(unit)
        elif key == 'length':
            model.setLengthUnits(unit)
        elif key == 'area':
            model.setAreaUnits(unit)
        elif key == 'volume':
            model.setVolumeUnits(unit)


def getUnitString(unit):
    if type(unit) is int:
        unit = UnitKind_toString(unit)
    if unit == '-':
        unit = UnitKind_toString(UNIT_KIND_DIMENSIONLESS)
    return unit


##########################################################################
# Parameters
##########################################################################
def createParameters(model, parameters):
    for data in parameters.values():
        _createParameter(model,
                        pid=data[0],
                        unit=getUnitString(data[3]),
                        name=data[1],
                        value=data[2],
                        constant=data[4])


def _createParameter(model, pid, unit, name=None, value=None, constant=True):
    p = model.createParameter()
    p.setId(pid)
    p.setUnits(unit)
    if name is not None:
        p.setName(name)
    if value is not None:
        p.setValue(value)
    p.setConstant(constant)
    return p

##########################################################################
# Compartments
##########################################################################
def createCompartments(model, compartments):
    for data in compartments.values():
        _createCompartment(model,
                           cid=data[0],
                           name=data[1],
                           dims=data[2],
                           units=data[3],
                           constant=data[4],
                           value=data[5])


def _createCompartment(model, cid, name, dims, units, constant, value):
    c = model.createCompartment()
    c.setId(cid)
    if name:
        c.setName(name)
    c.setSpatialDimensions(dims)
    c.setUnits(units)
    c.setConstant(constant)
    if type(value) is str:
        # _createInitialAssignment(model, sid=cid, formula=value)
        _createAssignmentRule(model, sid=cid, formula=value)
    else:
        c.setValue(value)


##########################################################################
# Species
##########################################################################
def createSpecies(model, sdict):
    for sid in sorted(sdict):
        data = sdict[sid]
        _createSpecie(model, sid, name=data[0], init=data[1], units=data[2],
                      compartment=data[3], boundaryCondition=data[4])


def _createSpecie(model, sid, name, init, units, compartment, boundaryCondition):
    s = model.createSpecies()
    s.setId(sid)
    if name:
        s.setName(name)
    s.setInitialConcentration(init)
    s.setUnits(units)
    s.setCompartment(compartment)

    s.setSubstanceUnits(model.getSubstanceUnits())
    s.setHasOnlySubstanceUnits(False)
    s.setConstant(False)
    s.setBoundaryCondition(boundaryCondition)


##########################################################################
# InitialAssignments
##########################################################################
def createInitialAssignments(model, assignments, names):
    for data in assignments:
        # id, assignment, unit
        pid = data[0]
        unit = getUnitString(data[2])
        # Create parameter if not existing
        if (not model.getParameter(pid)) and (not model.getSpecies(pid)):
            createParameter(model, pid, unit, name=names.get(pid, None), value=None, constant=True)
        _createInitialAssignment(model, sid=pid, formula=data[1])


def _createInitialAssignment(model, sid, formula):
    assignment = model.createInitialAssignment()
    assignment.setSymbol(sid)
    astnode = libsbml.parseL3FormulaWithModel(formula, model)
    if not astnode:
        print('Formula could not be parsed:', formula)
        print(libsbml.getLastParseL3Error())
    assignment.setMath(astnode)


##########################################################################
# Rules
##########################################################################
def createAssignmentRules(model, rules, names):
    for data in rules:
        # id, rule, unit
        pid = data[0]
        unit = getUnitString(data[2])
        # Create parameter if not existing
        if (not model.getParameter(pid)) and (not model.getSpecies(pid)):
            createParameter(model, pid, unit, name=names.get(pid, None), value=None, constant=False)
        if not model.getRule(pid):
            _createAssignmentRule(model, sid=pid, formula=data[1])


def _createAssignmentRule(model, sid, formula):
    rule = model.createAssignmentRule()
    rule.setVariable(sid)
    ast_node = libsbml.parseL3FormulaWithModel(formula, model)
    if not ast_node:
        print('Formula could not be parsed:', formula)
        print(libsbml.getLastParseL3Error())
    rule.setMath(ast_node)

##########################################################################
# Events
##########################################################################
# Deficiency Events (Galactosemias)

def getDeficiencyEventId(deficiency):
    return 'EDEF_{:0>2d}'.format(deficiency)

def createDeficiencyEvent(model, deficiency):
    eid = getDeficiencyEventId(deficiency)
    e = model.createEvent();
    e.setId(eid);
    e.setUseValuesFromTriggerTime(True);
    t = e.createTrigger()
    t.setInitialValue(False)  # ! not supported by Copasi -> lame fix via time
    t.setPersistent(True)  # ! not supported by Copasi -> careful with usage
    formula = '(time>0) && (deficiency=={:d})'.format(deficiency);
    astnode = libsbml.parseL3FormulaWithModel(formula, model)
    t.setMath(astnode);
    return e;

# Simulation Events (Peaks & Challenges)
def createSimulationEvents(model, elist):
    for edata in elist:
        createEventFromEventData(model, edata)

def createEventFromEventData(model, edata):
    e = model.createEvent()
    e.setId(edata.eid)
    e.setName(edata.key)
    e.setUseValuesFromTriggerTime(True)
    t = e.createTrigger()
    t.setInitialValue(False)
    t.setPersistent(True)
    astnode = libsbml.parseL3FormulaWithModel(edata.trigger, model)
    t.setMath(astnode)
    # assignments
    for key, value in edata.assignments.iteritems():
        astnode = libsbml.parseL3FormulaWithModel(value, model)
        ea = e.createEventAssignment()
        ea.setVariable(key)
        ea.setMath(astnode)
