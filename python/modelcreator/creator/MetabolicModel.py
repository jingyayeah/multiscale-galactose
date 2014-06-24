'''
Created on Jun 18, 2014

@author: mkoenig
'''
import libsbml
from libsbml import UNIT_KIND_DIMENSIONLESS, UnitKind_toString



class MetabolicModel(object):
    '''
    Main functionality to create objects in the SBML.
    '''
    SBML_LEVEL = 3
    SBML_VERSION = 1
  
    def _createUnitDefinition(self, uid, units):
        ''' Creates the defined unit definitions. '''
        unitdef = self.model.createUnitDefinition()
        unitdef.setId(uid)
        print 'uid:', uid
        for data in units:
            kind = data[0]
            print 'kind', kind
            exponent = data[1]
            self._createUnit(unitdef, kind, exponent)
             
    def _createUnit(self, unitdef, kind, exponent, scale=0, multiplier=1.0):
        unit = unitdef.createUnit()
        unit.setKind(kind)
        unit.setExponent(exponent)
        unit.setScale(scale)
        unit.setMultiplier(multiplier)
            
    def _setMainUnits(self):
        ''' 
        Sets the main units for the model. 
        '''
        for key in ('time', 'extent', 'substance', 'length', 'area', 'volume'):
            unit = self.main_units[key]
            unit = self.getUnitString(unit)
            # set the values
            if key == 'time':
                self.model.setTimeUnits(unit)
            elif key == 'extent':
                self.model.setExtentUnits(unit)
            elif key == 'substance':
                self.model.setSubstanceUnits(unit)
            elif key == 'length':
                self.model.setLengthUnits(unit)
            elif key == 'area':
                self.model.setAreaUnits(unit)
            elif key == 'volume':
                self.model.setVolumeUnits(unit)
    
    def getUnitString(self, unit):
        # get string if unit code
        if type(unit) is int:
            unit = UnitKind_toString(unit)
        if unit == '-':
            unit = UnitKind_toString(UNIT_KIND_DIMENSIONLESS)
        return unit
    
    def _createParameter(self, pid, unit, name=None, value=None, constant=True):
        p = self.model.createParameter()
        p.setId(pid)
        p.setUnits(unit)
        if name != None:
            p.setName(name)
        if value != None:
            p.setValue(value)
        p.setConstant(constant)
        return p
    
    def _createInitialAssignment(self, sid, formula):
        assignment = self.model.createInitialAssignment();
        assignment.setSymbol(sid);
        astnode = libsbml.parseL3FormulaWithModel(formula, self.model)
        assignment.setMath(astnode);   
    
    
    def _createCompartments(self, comps):
        for cid in sorted(comps):
            # comps['PV'] = ('[PV] perivenious', 3, 'm3', True, 'value)
            data = comps[cid]
            name = data[0]
            dims = data[1]
            units = data[2]
            constant = data[3]
            value = data[4]
            self._createCompartment(cid, name, dims, units, constant, value)
           
    def _createCompartment(self, cid, name, dims, units, constant, value):
        c = self.model.createCompartment()
        c.setId(cid)
        if name:
            c.setName(name)
        c.setSpatialDimensions(dims)            
        c.setUnits(units)
        c.setConstant(constant)
        if type(value) is str:
            self._createInitialAssignment(sid=cid, formula=value)
        else:
            c.setValue(value)
    
    def _createSpecies(self, sid, name, init, units, compartment):
        s = self.model.createSpecies()
        s.setId(sid)
        if name:
            s.setName(name)
        s.setInitialConcentration(init)
        s.setUnits(units)
        s.setCompartment(compartment)
        
        s.setSubstanceUnits(self.model.getSubstanceUnits());
        s.setHasOnlySubstanceUnits(False);
        s.setConstant(False)
        s.setBoundaryCondition(False)
