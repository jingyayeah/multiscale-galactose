package model.processes;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import model.SBMLUtils;
import model.utils.Naming;

import org.sbml.jsbml.ASTNode;
import org.sbml.jsbml.KineticLaw;
import org.sbml.jsbml.Model;
import org.sbml.jsbml.Reaction;
import org.sbml.jsbml.SpeciesReference;
import org.sbml.jsbml.text.parser.ParseException;

import equation.Equation;
import equation.EquationComponent;

public class ReactionFactory {
	/** Parses the equation and generates the respective SBML equation. */
	public static Reaction createReaction(Model model, String id, String name, String equation){
		return createLocalizedReaction(model, id, name, equation, null);
	}
	
	/** Split the important information from the equation definition. 
	 	[ATPS] ATP synthase (adp + phos <-> atp)
	 */
	public static Reaction createLocalizedReaction(Model model, String data, String compartment){
		String id = null;
		String name = null;
		String equation = null;
		
		String[] patterns = {
				"\\[.*?\\]", 
				"\\].*?\\(", 
				"\\(.*?\\)"
		};
		for (int k=0; k<patterns.length; ++k){
			String tmp = null;
			Pattern p = Pattern.compile(patterns[k]);
			Matcher m = p.matcher(data);
			if (m.find()){
				tmp = m.group(0).substring(1, m.group(0).length()-1);
				tmp = tmp.trim();
			}
			switch (k){
			case 0:
				id = tmp;
				break;
			case 1:
				name = tmp;
				break;
			case 2:
				equation = tmp;
				break;
			}
		}	
		return createLocalizedReaction(model, id, name, equation, compartment);
	}
	
	/** All reactants, products and modifiers have to be localized. */
	public static Reaction createLocalizedReaction(Model model, String id, String name, String equation, String compartment){
		if (compartment != null){
			id = Naming.createLocalizedId(compartment, id);
			name = Naming.createLocalizedName(compartment, name);
		}
		Reaction r = model.createReaction(id);
		r.setName(name);
		
		// parse the equation
		Equation eq = new Equation(equation);
		r.setReversible(eq.isReversible());
		SpeciesReference sref = null;
		for (EquationComponent eqc : eq.getReactants()){
			String srefid = eqc.getId();
			if (compartment != null){
				srefid = Naming.createLocalizedId(compartment, srefid);
			}
			sref = r.createReactant(model.getSpecies(srefid));
			sref.setStoichiometry(eqc.getStoichiometry());
			if (SBMLUtils.SBML_LEVEL > 2){
				sref.setConstant(true);
			}
		}
		for (EquationComponent eqc : eq.getProducts()){
			String srefid = eqc.getId();
			if (compartment != null){
				srefid = Naming.createLocalizedId(compartment, srefid);
			}
			sref = r.createProduct(model.getSpecies(srefid));
			sref.setStoichiometry(eqc.getStoichiometry());
			if (SBMLUtils.SBML_LEVEL > 2){
				sref.setConstant(true);
			}
		}
		System.out.println(eq);
		
		if (SBMLUtils.SBML_LEVEL > 2){
			r.setFast(false);
		}
		return r;
	}
	
	
	
	/** Create kinetic law for reaction based on given formula. */
	public static KineticLaw createKineticLaw(Reaction r, String formula) throws ParseException{
		KineticLaw law = r.createKineticLaw();
		law.setMath(ASTNode.parseFormula(formula));
		return law;
	}
	
	
}
