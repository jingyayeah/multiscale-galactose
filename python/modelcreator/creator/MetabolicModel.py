'''
Created on Jun 18, 2014
@author: mkoenig
'''

import libsbml
from libsbml import UNIT_KIND_DIMENSIONLESS, UnitKind_toString

SBML_LEVEL = 3
SBML_VERSION = 1
  
def createUnitDefinition(model, uid, units):
    ''' Creates the defined unit definitions. '''
    unitdef = model.createUnitDefinition()
    unitdef.setId(uid)
    for data in units:
        kind = data[0]
        exponent = data[1]
        _createUnit(unitdef, kind, exponent)
             
def _createUnit(unitdef, kind, exponent, scale=0, multiplier=1.0):
    unit = unitdef.createUnit()
    unit.setKind(kind)
    unit.setExponent(exponent)
    unit.setScale(scale)
    unit.setMultiplier(multiplier)
            
def setMainUnits(model, main_units):
    ''' Sets the main units for the model. '''
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
    
def createParameter(model, pid, unit, name=None, value=None, constant=True):
    p = model.createParameter()
    p.setId(pid)
    p.setUnits(unit)
    if name != None:
        p.setName(name)
    if value != None:
        p.setValue(value)
    p.setConstant(constant)
    return p
    
def createCompartments(model, comps):
    for cid in sorted(comps):
        # comps['PV'] = ('[PV] perivenious', 3, 'm3', True, 'value)
        data = comps[cid]
        name = data[0]
        dims = data[1]
        units = data[2]
        constant = data[3]
        value = data[4]
        _createCompartment(model, cid=cid, name=name, dims=dims, 
                                  units=units, constant=constant, value=value)
           
def _createCompartment(model, cid, name, dims, units, constant, value):
    c = model.createCompartment()
    c.setId(cid)
    if name:
        c.setName(name)
    c.setSpatialDimensions(dims)            
    c.setUnits(units)
    c.setConstant(constant)
    if type(value) is str:
        _createInitialAssignment(model, sid=cid, formula=value)
    else:
        c.setValue(value)
    
def createSpecies(model, sdict):
    for sid in sorted(sdict):
        # comps['PV'] = ('[PV] perivenious', 3, 'm3', True)
        data = sdict[sid]
        name = data[0]
        init = data[1]
        units = data[2]
        compartment = data[3]
        _createSpecie(model, sid, name, init, units, compartment)
    
def _createSpecie(model, sid, name, init, units, compartment):
    s = model.createSpecies()
    s.setId(sid)
    if name:
        s.setName(name)
    s.setInitialConcentration(init)
    s.setUnits(units)
    s.setCompartment(compartment)
        
    s.setSubstanceUnits(model.getSubstanceUnits());
    s.setHasOnlySubstanceUnits(False);
    s.setConstant(False)
    s.setBoundaryCondition(False)
        
def createInitialAssignments(model, assignments):
    for data in assignments:
        # id, assignment, unit
        pid = data[0]
        unit = getUnitString(data[2])
        # Create parameter if not existing
        if not model.getParameter(pid):
            createParameter(model, pid, unit, name=None, value=None, constant=True)
        _createInitialAssignment(model, sid=pid, formula=data[1])
    
def _createInitialAssignment(model, sid, formula):
    assignment = model.createInitialAssignment();
    assignment.setSymbol(sid);
    astnode = libsbml.parseL3FormulaWithModel(formula, model)
    assignment.setMath(astnode);   
         
def createAssignmentRules(model, rules):
    for data in rules:
        # id, rule, unit
        pid = data[0]
        unit = getUnitString(data[2])
        # Create parameter if not existing
        if not model.getParameter(pid):
            createParameter(model, pid, unit, name=None, value=None, constant=False)
        _createAssignmentRule(model, sid=pid, formula=data[1])
            
def _createAssignmentRule(model, sid, formula):
    rule = model.createAssignmentRule();
    rule.setVariable(sid);
    astnode = libsbml.parseL3FormulaWithModel(formula, model)
    rule.setMath(astnode);   
    