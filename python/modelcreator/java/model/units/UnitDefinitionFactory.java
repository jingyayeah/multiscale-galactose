package model.units;


import org.sbml.jsbml.Model;
import org.sbml.jsbml.Unit;
import org.sbml.jsbml.UnitDefinition;
import org.sbml.jsbml.Unit.Kind;

/** Create the UnitDefinitions for the model.
 * Currently one basic set of units defined which are 
 * used in the model.
 */
public class UnitDefinitionFactory {
		
	/** Unit definitions for the model. */
	public static void createUnitDefinitions(Model model){
		// Create units in detail for all your variables.
		//UnitDefinition unitDef = model.createUnitDefinition("time"); 
		//createUnit(unitDef, Kind.SECOND, 1.0, 0);
		
		// unitDef = model.createUnitDefinition("substance"); // [mole]
		//createUnit(unitDef, Kind.MOLE, 1.0, 0);
		// unitDef = model.createUnitDefinition("extent"); // [mole]
		// createUnit(unitDef, Kind.MOLE, 1.0, 0);
		
		UnitDefinition unitDef = model.createUnitDefinition("s"); 
		createUnit(unitDef, Kind.SECOND, 1.0, 0);
		
		model.setTimeUnits("s");
		model.setSubstanceUnits(Kind.MOLE.getName());
		model.setExtentUnits(Kind.MOLE.getName());
		
		unitDef = model.createUnitDefinition("m");
		createUnit(unitDef, Kind.METRE, 1.0, 0);
		unitDef = model.createUnitDefinition("m2");
		createUnit(unitDef, Kind.METRE, 2.0, 0);
		unitDef = model.createUnitDefinition("m3");
		createUnit(unitDef, Kind.METRE, 3.0, 0);
		model.setLengthUnits("m");
		model.setAreaUnits("m2");
		model.setVolumeUnits("m3");
		
		unitDef = model.createUnitDefinition("mole_per_s");
		createUnit(unitDef, Kind.MOLE, 1.0, 0);
		createUnit(unitDef, Kind.SECOND, -1.0, 0);
	
		unitDef = model.createUnitDefinition("m_per_s");
		createUnit(unitDef, Kind.METRE, 1.0, 0);
		createUnit(unitDef, Kind.SECOND, -1.0, 0);
		
		unitDef = model.createUnitDefinition("m2_per_s");
		createUnit(unitDef, Kind.METRE, 2.0, 0);
		createUnit(unitDef, Kind.SECOND, -1.0, 0);
		
		unitDef = model.createUnitDefinition("m3_per_s");
		createUnit(unitDef, Kind.METRE, 3.0, 0);
		createUnit(unitDef, Kind.SECOND, -1.0, 0);
		
		unitDef = model.createUnitDefinition("mole_per_m3"); // [=mM]
		createUnit(unitDef, Kind.MOLE, 1.0, 0);
		createUnit(unitDef, Kind.METRE, -3.0, 0);
		
		unitDef = model.createUnitDefinition("mM"); // [=mM]
		createUnit(unitDef, Kind.MOLE, 1.0, 0);
		createUnit(unitDef, Kind.METRE, -3.0, 0);
		
		unitDef = model.createUnitDefinition("per_mM"); 
		createUnit(unitDef, Kind.MOLE, -1.0, 0);
		createUnit(unitDef, Kind.METRE, 3.0, 0);
		
		unitDef = model.createUnitDefinition("per_s");
		createUnit(unitDef, Kind.SECOND, -1.0, 0);
		
		unitDef = model.createUnitDefinition("kg");
		createUnit(unitDef, Kind.KILOGRAM, 1.0, 0);
		
		unitDef = model.createUnitDefinition("kg_per_m3"); 
		createUnit(unitDef, Kind.KILOGRAM, 1.0, 0);
		createUnit(unitDef, Kind.METRE, -3.0, 0);
		
		unitDef = model.createUnitDefinition("m3_per_skg"); 
		createUnit(unitDef, Kind.METRE, 3.0, 0);
		createUnit(unitDef, Kind.SECOND, -1.0, 0);
		createUnit(unitDef, Kind.KILOGRAM, -1.0, 0);
	}
	
	public static Unit createUnit(UnitDefinition unitDef, Unit.Kind kind, double exponent, int scale, double multiplier){
		Unit u = new Unit();
		u.setKind(kind);
		u.setExponent(exponent);
		u.setScale(scale);
		u.setMultiplier(multiplier);
		unitDef.addUnit(u);
		return u;
	}
	public static Unit createUnit(UnitDefinition unitDef, Unit.Kind kind, double exponent, int scale){
		return createUnit(unitDef, kind, exponent, scale, 1.0);
	}
	
}
