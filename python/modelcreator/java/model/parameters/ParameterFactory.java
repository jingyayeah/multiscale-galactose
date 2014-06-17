package model.parameters;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import model.utils.Naming;

import org.sbml.jsbml.Model;
import org.sbml.jsbml.Parameter;
import org.sbml.jsbml.Unit.Kind;

/** Handles the creation of all the parameters for the model.
 * Of special importance are the non constant global parameters for
 * AssignmentRules and the constant parameters for InitialAssignments.
 * Important difference between parameters which change over time in 
 * the model and the parameters which are constant throughout the 
 * course of the simulation.
 * 
 * All parameters are handled as global parameters.
 * TODO: be clear about the normal and localized parameters and the constant and
 * 			nonconstant parameters
 * 
 * @author Matthias Koenig
 * @date 2014-04-28
 *
 */
public class ParameterFactory {
	
	/** Create global parameter in model with assigned value. */
	public static Parameter createParameter(Model model, String id, Double value, String units, Boolean constant){
		Parameter p = createParameter(model, id, units, constant);
		p.setValue(value);
		return p;
	}
	
	/** Create global parameter in model without assigned value. */
	public static Parameter createParameter(Model model, String id, String units, Boolean constant){
		Parameter p = model.createParameter(id);
		p.setUnits(units);
		p.setConstant(constant);
		return p;
	}
	
	/** Creates a localized id and creates parameter for it */
	public static Parameter createLocalizedParameter(Model model, String id, double value, String units, 
				String compartment, Boolean constant){
		
		// Gets the localized compartment id
		if (compartment != null){
			id = Naming.createLocalizedId(compartment, id);
		}
		return createParameter(model, id, value, units, constant);	
	}
	

	// DEAL WITH THE DATA STRUCTURE
	
	public static Parameter[] createLocalizedParameters(Model model, String[] data, String compartment){
		Parameter[] pars = new Parameter[data.length];
		for (int k=0; k<data.length; ++k){
			pars[k] = createLocalizedParameter(model, data[k], compartment);
		}
		return pars;
	}
	
	/** Create parameter from given data structure */
	public static Parameter[] createParameters(Model model, String[] data){
		Parameter[] pars = new Parameter[data.length];
		for (int k=0; k<data.length; ++k){
			pars[k] = createParameter(model, data[k]);
		}
		return pars;
	}
	
	public static Parameter createParameter(Model model, String data){
		 return createLocalizedParameter(model, data, null);
	}
	
	
	/** Parse the parameter data of the equations. 
	 * TODO: which parameters are constant and which not.
	 *	TODO: testing, fix bugs 
	 * GALK_k_gal1p = 1.5;   % [mM] ?
	 * FIXME: units parsing not working properly
	 * 
	 * 		String[] pars = {
						"GALK_PA    = 0.4;     % [mole]",
						"GALK_keq = 50;        % [-] DeltaG ~ 10kJ/mol",
						"GALK_k_gal1p = 1.5;   % [mM] ? ",
						"GALK_k_adp   = 0.8;   % [mM] ? ",
						"GALK_ki_gal1p = 5.3;  % [mM] [Cuatrecasas1965]",
						"GALK_kcat = 8.7;      % [1/s] [Timson2003]",
						"GALK_k_gal = 0.97;    % [mM]  [Timson2003]",
						"GALK_k_atp = 0.034;   % [mM]  [Timson2003]"
		};
		ModelCreatorUtils.createParameters(model, pars);
	 */
	public static Parameter createLocalizedParameter(Model model, String data, String compartment){
		String[] tokens = data.split("; ");
		if (tokens.length != 2){
			System.out.println("Problems with parameters: " +  data);
		}
		String equation = tokens[0];
		String[] equationTokens = equation.split("=");
		String id = equationTokens[0].trim();
		// Localize id if compartment is given
		if (compartment != null){
			id = Naming.createLocalizedId(compartment, id);
		}
		Double value = new Double(equationTokens[1].trim());
		
		String units = Kind.DIMENSIONLESS.getName();
		Pattern myPattern = Pattern.compile("\\[.*?\\]");
		Matcher myMatcher = myPattern.matcher(tokens[1]);
		if (myMatcher.find()){
			units = myMatcher.group(0).substring(1, myMatcher.group(0).length()-1);
			units = units.replace("1/", "per_");
			units = units.replace("/", "_per_");
			
			if (units.equals("-")){
				units = Kind.DIMENSIONLESS.getName();
			}
		} else {
			System.out.println("Units not found in parameter!");
		}
		System.out.println(String.format("%s -> [%s|%s|%s]", data, id, value.toString(), units));
		Boolean constant = false;
		return createParameter(model, id, value, units, constant);
	}
	
}
