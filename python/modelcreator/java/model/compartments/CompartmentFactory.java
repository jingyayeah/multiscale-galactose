package model.compartments;

import model.ExternalModel;
import model.ModelCreator.ModelType;
import model.assignments.AssignmentFactory;
import model.utils.Naming;

import org.sbml.jsbml.Compartment;
import org.sbml.jsbml.Model;
import org.sbml.jsbml.text.parser.ParseException;

/** Handle the compartments generation.
 * For constant compartment sizes these should be assigned via initialAssignments instead
 * of rule constructs.
 * @author Matthias Koenig
 * @date 2014-03-22
 *
 */
public class CompartmentFactory {
	/** Create the compartments for the geometry.
	 * @throws ParseException */
	public static void createExternalCompartments(Model model, ExternalModel em, int Nc, int Nf) throws ParseException{
		if (em.getModelType() != ModelType.GalactoseCell){
			// periportal
			CompartmentFactory.createCompartment(model, Naming.getPeriportalId(), Naming.getPeriportalName(), 3, "m3");
			CompartmentFactory.createInitialAssignmentsForCompartment(model, Naming.getPeriportalId(), "m3", "Vol_pp");
			
			for (int i=1; i<=Nc*Nf; i++){
				// sinusoid
				CompartmentFactory.createCompartment(model, Naming.getSinusoidId(i), Naming.getSinusoidName(i), 3, "m3");
				CompartmentFactory.createInitialAssignmentsForCompartment(model, Naming.getSinusoidId(i), "m3", "Vol_sin");
				// disse
				CompartmentFactory.createCompartment(model, Naming.getDisseId(i), Naming.getDisseName(i), 3, "m3");
				CompartmentFactory.createInitialAssignmentsForCompartment(model, Naming.getDisseId(i), "m3", "Vol_dis");
			}
			// perivenious
			CompartmentFactory.createCompartment(model, Naming.getPerivenousId(), Naming.getPerivenousName(), 3, "m3");
			CompartmentFactory.createInitialAssignmentsForCompartment(model, Naming.getPerivenousId(), "m3", "Vol_pv");
		} else {
			// GalactoseModel -> only create Disse external
			for (int i=1; i<=Nc*Nf; i++){
				// disse
				CompartmentFactory.createCompartment(model, Naming.getDisseId(i), Naming.getDisseName(i), 3, "m3");
				CompartmentFactory.createInitialAssignmentsForCompartment(model, Naming.getDisseId(i), "m3", "Vol_dis");
			}
		}
	}
	
	/** Creates the cell compartments. */
	public static void createCellCompartments(Model model, int Nc) throws ParseException{
		// Create cell compartment 1, ..., Nc
		for (int c=1; c<=Nc; c++){
			// Create the species
			CompartmentFactory.createCompartment(model, Naming.getCellId(c), Naming.getCellName(c), 3, "m3");
			CompartmentFactory.createInitialAssignmentsForCompartment(model, Naming.getCellId(c), "m3", "Vol_cell");
		}
	}
	
	
	/** Create compartment with known initial size. */
	public static Compartment createCompartment(Model model, String id, String name, double size, int spatialDimensions, String units){
		Compartment c = model.createCompartment(id);
		c.setName(name);
		c.setSize(size);
		c.setSpatialDimensions(spatialDimensions);
		c.setUnits(units);
		c.setConstant(true);
		return c;
	}
	
	/** Create constant compartment with size calculated from
	 * initial assignment. 
	 */
	public static Compartment createCompartment(Model model, String id, String name, int spatialDimensions, String units){
		Compartment c = model.createCompartment(id);
		c.setName(name);
		c.setSpatialDimensions(spatialDimensions);
		c.setUnits(units);
		c.setConstant(true);
		return c;
	}

	/** Creates the initial assignment for the compartment. */
	public static void createInitialAssignmentsForCompartment(Model model, String compId, 
										String units, String assignment) throws ParseException{
		AssignmentFactory.createInitialAssignment(model, compId, units, assignment);
	}
}
