package model.processes;

import model.assignments.AssignmentFactory;
import model.parameters.ParameterFactory;
import model.utils.Naming;

import org.sbml.jsbml.Model;
import org.sbml.jsbml.Reaction;
import org.sbml.jsbml.Unit.Kind;
import org.sbml.jsbml.text.parser.ParseException;

public class GalactoseTransporterFactory {
	
	/** [H20T] H2O transport (h2oM_dis <-> h2oM)
		------------------------------------------------------------
		H2OT_f = 10.0;                % [mole/s]
		H2OT_k = 1.0;                 % [mM]
		H2OT_Vmax = H2OT_f * scale;   % [mole/s]
		H2OTM_dis = H2OT_Vmax/H2OT_k/Nf * (h2oM_dis - h2oM*onevec);  % [mole/s]
		
		H2OTM  = sum(H2OTM_dis);      % [mole/s]
	 */
		public static void createLocalizedH2OT(Model model, String cFrom, String cTo, boolean createGlobal) throws ParseException{
			String reaction = "[e__H2OTM] H2O M transport (e__h2oM <-> c__h2oM)";
			reaction = reaction.replaceAll("c__", cTo + Naming.PREFIX_SEP);
			reaction = reaction.replaceAll("e__", cFrom + Naming.PREFIX_SEP);
			Reaction r = ReactionFactory.createLocalizedReaction(model, reaction, null);
			
			String[] pars = { // Global parameters
					"H2OT_f = 10.0;                % [mole/s]",
					"H2OT_k = 1.0;                 % [mM]"
			};
			if (createGlobal){
				ParameterFactory.createParameters(model, pars);
			}
			
			// Vmax assignment
			String formula = null;
			String VmaxId = Naming.createLocalizedId(cTo , "H2OT_Vmax");
			// only create once per cell
			if (model.getParameter(VmaxId)==null){
				AssignmentFactory.createAssignmentRule(model, VmaxId, "mole_per_s", "H2OT_f * scale");
			}
			
			// Reaction
			formula = "c__H2OT_Vmax/H2OT_k/Nf * (e__h2oM - c__h2oM)";
			formula = formula.replaceAll("c__", cTo + Naming.PREFIX_SEP);
			formula = formula.replaceAll("e__", cFrom + Naming.PREFIX_SEP);
			ReactionFactory.createKineticLaw(r, formula);
			
			System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
		}
		
		/** [GLUT2_GAL] galactose transport (gal_dis <-> gal)
			[GLUT2_GALM] galactoseM transport (galM_dis <-> galM)
			------------------------------------------------------------
			GLUT2_P = 1;              % [mM]
			GLUT2_f = 0.5E6;            % [-]
			GLUT2_k_gal = 85.5;       % [mM] [Colville1993, Arbuckle1996]
			GLUT2_Vmax = GLUT2_f * scale * GLUT2_P/REF_P;  % [mole/s]
			GLUT2_dm = (1 + (gal_dis+galM_dis)/GLUT2_k_gal + (gal+galM)/GLUT2_k_gal); % [-]
			GLUT2_GAL_dis  = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (gal_dis - gal*onevec)./GLUT2_dm;  % [mole/s]
			GLUT2_GALM_dis = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (galM_dis - galM*onevec)./GLUT2_dm;  % [mole/s]
	 */
		public static void createLocalizedGLUT2(Model model, String cFrom, String cTo, boolean createGlobal) throws ParseException{
			String reaction = "[e__GLUT2_GAL] galactose transport (e__gal <-> c__gal)";
			reaction = reaction.replaceAll("c__", cTo + Naming.PREFIX_SEP);
			reaction = reaction.replaceAll("e__", cFrom + Naming.PREFIX_SEP);
			Reaction r = ReactionFactory.createLocalizedReaction(model, reaction, null);
			
			reaction = "[e__GLUT2_GALM] galactose transport (e__galM <-> c__galM)";
			reaction = reaction.replaceAll("c__", cTo + Naming.PREFIX_SEP);
			reaction = reaction.replaceAll("e__", cFrom + Naming.PREFIX_SEP);
			Reaction r1 = ReactionFactory.createLocalizedReaction(model, reaction, null);
			
			String[] pars = { // Global parameters
					"GLUT2_f = 1E6;            % [-]",
					"GLUT2_k_gal = 85.5;       % [mM] [Colville1993, Arbuckle1996]"
			};
			String [] parsLoc = { // Local parameters
					"GLUT2_P = 1;              % [mM]"
			};
			if (createGlobal){
				ParameterFactory.createParameters(model, pars);
			}
			
			// Assignments
			String formula = null;
			String VmaxId = Naming.createLocalizedId(cTo , "GLUT2_Vmax");
			// only create once per cell
			if (model.getParameter(VmaxId)==null){
				ParameterFactory.createLocalizedParameters(model, parsLoc, cTo);
				formula =  "GLUT2_f * scale * c__GLUT2_P/REF_P";
				AssignmentFactory.createAssignmentRule(model, VmaxId, "mole_per_s", formula.replaceAll("c__", cTo + Naming.PREFIX_SEP));
				
				formula = "(1 + (e__gal+e__galM)/GLUT2_k_gal + (c__gal+c__galM)/GLUT2_k_gal)";
				formula = formula.replaceAll("c__", cTo + Naming.PREFIX_SEP);
				formula = formula.replaceAll("e__", cFrom + Naming.PREFIX_SEP);
				AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(cTo , "GLUT2_dm"), Kind.DIMENSIONLESS.name(), formula);
			}
			
			// Reaction
			formula = "c__GLUT2_Vmax/(GLUT2_k_gal*Nf) * (e__gal - c__gal)/c__GLUT2_dm";
			formula = formula.replaceAll("c__", cTo + Naming.PREFIX_SEP);
			formula = formula.replaceAll("e__", cFrom + Naming.PREFIX_SEP);
			ReactionFactory.createKineticLaw(r, formula);
			
			formula = "c__GLUT2_Vmax/(GLUT2_k_gal*Nf) * (e__galM - c__galM)/c__GLUT2_dm";
			formula = formula.replaceAll("c__", cTo + Naming.PREFIX_SEP);
			formula = formula.replaceAll("e__", cFrom + Naming.PREFIX_SEP);
			ReactionFactory.createKineticLaw(r1, formula);
			
			System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
			System.out.println(String.format("%s -> [%s]\n", r1.getId(), r1.getDerivedUnits()));	
		}
		
		
}
