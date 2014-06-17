package model.assignments;

import model.parameters.ParameterFactory;

import org.sbml.jsbml.ASTNode;
import org.sbml.jsbml.AssignmentRule;
import org.sbml.jsbml.InitialAssignment;
import org.sbml.jsbml.Model;
import org.sbml.jsbml.text.parser.ParseException;

/** Handles the AssignmentRules and the InitialAssignments for the model. */
public class AssignmentFactory {
	
	/** Create the AssignmentRule. */
	public static AssignmentRule createAssignmentRule(Model model, String id, String units, String formula) throws ParseException{
		// If parameter not available, create it
		if (model.getParameter(id) == null){
			ParameterFactory.createParameter(model, id, units, false);
		}
		return createAssignmentRule(model, id, formula);
	}
	
	/** Create assignment rule based on id [units] = formula in the model. */
	private static AssignmentRule createAssignmentRule(Model model, String id, String formula) throws ParseException{
		AssignmentRule rule = model.createAssignmentRule();
		rule.setMath(ASTNode.parseFormula(formula));
		rule.setVariable(id);
		return rule;
	}
	
	/** Create a new InitialAssignment of the given formula to the id in the model. 
	 * @throws ParseException */
	public static InitialAssignment createInitialAssignment(Model model, String id, String units, String formula) throws ParseException{
		System.out.println("createInitialAssignment\n");
		// If parameter not available, create it
		// Check if no compartment is available with the id (TODO: fix this hack,
		// check if any SBase is available with the name already)
		if (model.getCompartment(id) == null &&  model.getParameter(id) == null){
			System.out.println(id + " : " + units);
			ParameterFactory.createParameter(model, id, units, true);
		}
		return createInitialAssignment(model, id, formula);
	}
	
	
	/** Create a new InitialAssignment of the given formula to the id in the model. 
	 * @throws ParseException */
	private static InitialAssignment createInitialAssignment(Model model, String id, String formula) throws ParseException{
		InitialAssignment assignment = model.createInitialAssignment();
		assignment.setMath(ASTNode.parseFormula(formula));
		assignment.setVariable(id);
		return assignment;
	}
	
}
