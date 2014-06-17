package model.processes;

import model.assignments.AssignmentFactory;
import model.parameters.ParameterFactory;
import model.utils.Naming;

import org.sbml.jsbml.ASTNode;
import org.sbml.jsbml.Event;
import org.sbml.jsbml.Model;
import org.sbml.jsbml.Reaction;
import org.sbml.jsbml.Trigger;
import org.sbml.jsbml.Unit.Kind;
import org.sbml.jsbml.text.parser.ParseException;

/**
 * TODO: FIXME: add the modifiers to the network.
 * 
 * FIXME: create via a class reaction which can handle many of the
 * 		  recurring tasks
 * 
 * // r.createModifier(model.getSpecies(Naming.createLocalizedId(c, "GALT_P") ));
 * The proteins have to become own species in the network and can than be used as modfiers.	
 * 
 * @author mkoenig
 *
 */
public class GalactoseReactionFactory {
	
	/** [GALK] Galactokinase  (gal + atp <-> gal1p + adp)
		[GALKM] Galactokinase (galM + atp -> gal1p + adp)
		------------------------------------------------------------
		GALK_P = 1;           % [mM]
		GALK_PA = 4;        % [mole]
		GALK_keq = 50;        % [-] DeltaG ~ 10kJ/mol
		GALK_k_gal1p = 1.5;   % [mM] ? 
		GALK_k_adp   = 0.8;   % [mM] ? 
		GALK_ki_gal1p = 5.3;  % [mM] [Cuatrecasas1965]
		GALK_kcat = 8.7;      % [1/s] [Timson2003]
		GALK_k_gal = 0.97;    % [mM]  [Timson2003]
		GALK_k_atp = 0.034;   % [mM]  [Timson2003]
		GALK_Vmax = scale * GALK_PA*GALK_kcat *GALK_P/REF_P;  % [mole/s]
		GALK_dm = ((1 +(gal+galM)/GALK_k_gal)*(1+atp/GALK_k_atp) +(1+gal1p/GALK_k_gal1p)*(1+adp/GALK_k_adp) -1);  % [-]
		GALK  = GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+gal1p/GALK_ki_gal1p) * (gal*atp -gal1p*adp/GALK_keq)/ GALK_dm;  % [mole/s] 
		GALKM = GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+gal1p/GALK_ki_gal1p) * galM*atp/GALK_dm;  % [mole/s]
	 *  
	 * FIXME: implement the deficiencies as events 
	 * @throws ParseException 
	 */
	public static void createLocalizedGALK(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "GALK", "Galactokinase", "gal + atp <-> gal1p + adp", c);
		r.setCompartment(c);
		Reaction r1 = ReactionFactory.createLocalizedReaction(model, "GALKM", "Galactokinase", "galM + atp -> gal1p + adp", c);
		r1.setCompartment(c);
		String[] pars = { // Global parameters
						"GALK_PA    = 0.02;     % [mole]",
						"GALK_keq = 50;        % [-] DeltaG ~ 10kJ/mol",
						"GALK_k_gal1p = 1.5;   % [mM] ? ",
						"GALK_k_adp   = 0.8;   % [mM] ? ",
						"GALK_ki_gal1p = 5.3;  % [mM] [Cuatrecasas1965]",
						"GALK_kcat = 8.7;      % [1/s] [Timson2003]",
						"GALK_k_gal = 0.97;    % [mM]  [Timson2003]",
						"GALK_k_atp = 0.034;   % [mM]  [Timson2003]"
		};
		String [] parsLoc = { // Local parameters
				"GALK_P = 1;               % [mM]",
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// Create assignment rules
		String formula = "scale * GALK_PA * GALK_kcat * c__GALK_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "GALK_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		formula = "((1 +(c__gal+c__galM)/GALK_k_gal)*(1+c__atp/GALK_k_atp) +(1+c__gal1p/GALK_k_gal1p)*(1+c__adp/GALK_k_adp) -1)";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "GALK_dm"), 
				Kind.DIMENSIONLESS.name(), formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		// GALK
		formula = "c__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+c__gal1p/GALK_ki_gal1p) * (c__gal*c__atp -c__gal1p*c__adp/GALK_keq)/c__GALK_dm";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// GALKM
		formula = "c__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+c__gal1p/GALK_ki_gal1p) * c__galM * c__atp/c__GALK_dm";
		ReactionFactory.createKineticLaw(r1, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		
		if (c.equals(Naming.getCellId(1))){
		model.getParameter("deficiency").setConstant(false);
		model.getParameter("GALK_kcat").setConstant(false);
		model.getParameter("GALK_k_gal").setConstant(false);
		model.getParameter("GALK_k_atp").setConstant(false);
		/* Events for the deficiencies
		    case 1;  GALK_kcat=2.0;    GALK_k_gal=7.7;   GALK_k_atp=0.130;
       		case 2;  GALK_kcat=3.9;    GALK_k_gal=0.43;  GALK_k_atp=0.110;
       		case 3;  GALK_kcat=5.9;    GALK_k_gal=0.66;  GALK_k_atp=0.026;
       		case 4;  GALK_kcat=0.4;    GALK_k_gal=1.1;   GALK_k_atp=0.005;
       		case 5;  GALK_kcat=1.1;    GALK_k_gal=13.0;  GALK_k_atp=0.089;
       		case 6;  GALK_kcat=1.8;    GALK_k_gal=1.70;  GALK_k_atp=0.039;
       		case 7;  GALK_kcat=6.7;    GALK_k_gal=1.90;  GALK_k_atp=0.035;
       		case 8;  GALK_kcat=0.9;    GALK_k_gal=0.14;  GALK_k_atp=0.0039;
       */
		createGALKEvent(model, 0, "8.7", "0.97", "0.034");
		createGALKEvent(model, 1, "2.0", "7.7", "0.130");
		createGALKEvent(model, 2, "3.9", "0.43", "0.110");
		createGALKEvent(model, 3, "5.9", "0.66", "0.026");
		createGALKEvent(model, 4, "0.4", "1.1", "0.005");
		createGALKEvent(model, 5, "1.1", "13.0", "0.089");
		createGALKEvent(model, 6, "1.8", "1.70", "0.039");
		createGALKEvent(model, 7, "6.7", "1.90", "0.035");
		createGALKEvent(model, 8, "0.9", "0.14", "0.0039");
		}
		
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));
		System.out.println(String.format("%s -> [%s]\n", r1.getId(), r1.getDerivedUnits()));
	}
	
	public static Event createGALKEvent(Model model, int deficiency, String GALK_kcat, String GALK_k_gal, String GALK_k_atp) throws ParseException{
		Event e = createDeficiencyEvent(model, deficiency);
		e.createEventAssignment("GALK_kcat", ASTNode.parseFormula(GALK_kcat));
		e.createEventAssignment("GALK_k_gal", ASTNode.parseFormula(GALK_k_gal));
		e.createEventAssignment("GALK_k_atp", ASTNode.parseFormula(GALK_k_atp));
		return e;
	}
	
	private static Event createDeficiencyEvent(Model model, int deficiency) throws ParseException{
		String eId = getDeficiencyEventId(deficiency);
		
		if (eId.equals(getDeficiencyEventId(0)) && model.getEvent(eId) != null){
			return model.getEvent(eId);
		}
		
		Event e = model.createEvent(eId);
		e.setUseValuesFromTriggerTime(true);
		Boolean initialValue = false; // ! not supported by Copasi -> lame fix via time
		Boolean persistent = true;    // ! not supported by Copasi -> careful with usage
		
		Trigger t = e.createTrigger(initialValue, persistent);
		String formula = String.format("(time>0) and (deficiency==%d)", deficiency);
		t.setMath(ASTNode.parseFormula(formula));
		return e;
	}
	
	public static String getDeficiencyEventId(int deficiency){
		return String.format("EDEF_%02d", deficiency);
	}
	

	
	/** [IMP] Inositol monophosphatase (gal1p -> gal + phos)
		------------------------------------------------------------
		IMP_P = 1;                            % [mM]
		IMP_f = 0.05;                         % [-]
		IMP_k_gal1p = 0.35;                   % [mM]  [Slepak2007, Parthasarathy1997]
		IMP_Vmax = IMP_f * GALK_Vmax * IMP_P/REF_P;    % [mole/s]
		IMP = IMP_Vmax/IMP_k_gal1p * gal1p/(1 + gal1p/IMP_k_gal1p);     % [mole/s]
	*/
	public static void createLocalizedIMP(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[IMP] Inositol monophosphatase (gal1p -> gal + phos)", c);
		r.setCompartment(c);
		String[] pars = { // Global parameters
				"IMP_f = 0.05;                         % [-]",
				"IMP_k_gal1p = 0.35;                   % [mM]  [Slepak2007, Parthasarathy1997]"
		};	
		String [] parsLoc = { // Local parameters
				"IMP_P = 1;                            % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// Vmax assignment
		String formula = "IMP_f * c__GALK_Vmax * c__IMP_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "IMP_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// Reaction
		formula = "c__IMP_Vmax/IMP_k_gal1p * c__gal1p/(1 + c__gal1p/IMP_k_gal1p)";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
	}
	
	
	/** [ATPS] ATP synthase (adp + phos <-> atp)
		------------------------------------------------------------
	 	ATPS_P = 1;             % [mM]
		ATPS_f = 20.0;          % [-]
		ATPS_keq = 0.58;        % [1/mM] 2.8/(0.8*6)
		ATPS_k_adp = 0.1;       % [mM] [?]
		ATPS_k_atp = 0.5;       % [mM] [?]
		ATPS_k_phos = 0.1;      % [mM] [?]
		ATPS_Vmax = ATPS_f*GALK_Vmax * ATPS_P/REF_P;      % [mole/s]
		ATPS = ATPS_Vmax/(ATPS_k_adp*ATPS_k_phos) *(adp*phos-atp/ATPS_keq)/((1+adp/ATPS_k_adp)*(1+phos/ATPS_k_phos) + atp/ATPS_k_atp); % [mole/s]
	 */
	public static void createLocalizedATPS(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[ATPS] ATP synthase (adp + phos <-> atp)", c);
		r.setCompartment(c);
		String[] pars = { // Global parameters
				"ATPS_f = 100.0;          % [-]",
				"ATPS_keq = 0.58;        % [1/mM] 2.8/(0.8*6)",
				"ATPS_k_adp = 0.1;       % [mM] [?]",
				"ATPS_k_atp = 0.5;       % [mM] [?]",
				"ATPS_k_phos = 0.1;      % [mM] [?]"
		};	
		String [] parsLoc = { // Local parameters
				"ATPS_P = 1;             % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// Vmax assignment
		String formula = "ATPS_f* c__GALK_Vmax * c__ATPS_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "ATPS_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// Reaction
		formula = "c__ATPS_Vmax/(ATPS_k_adp*ATPS_k_phos) *(c__adp*c__phos-c__atp/ATPS_keq)/((1+c__adp/ATPS_k_adp)*(1+c__phos/ATPS_k_phos) + c__atp/ATPS_k_atp)";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));
	}
	
	
	/** [ALDR] Aldose reductase (gal + nadph <-> galtol + nadp)
		------------------------------------------------------------
		ALDR_P = 1;            % [mM]
		ALDR_f = 1E11;         % [-]
		ALDR_keq = 4.0;        % [-] [?]
		ALDR_k_gal = 40.0;     % [mM]  [Wemuth1982, SABIORK: 22893]
		ALDR_k_galtol = 40.0;  % [mM]  [?]
		ALDR_k_nadp = 0.1;     % [mM]  [?]
		ALDR_k_nadph = 0.1;    % [mM]  [?]
		ALDR_Vmax = ALDR_f*GALK_Vmax * ALDR_P/REF_P;  % [mole/s]
		ALDR = ALDR_Vmax/(ALDR_k_gal*ALDR_k_nadp) *(gal*nadph - galtol*nadp/ALDR_keq) /...
    		( (1+gal/ALDR_k_gal)*(1+nadph/ALDR_k_nadph) +(1+galtol/ALDR_k_galtol)*(1+nadp/ALDR_k_nadp) -1);  % [mole/s]
	 */
	public static void createLocalizedALDR(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[ALDR] Aldose reductase (gal + nadph <-> galtol + nadp)", c );
		r.setCompartment(c);
		String[] pars = {
				"ALDR_f = 1E6;         % [-]",
				"ALDR_keq = 4.0;        % [-] [?]",
				"ALDR_k_gal = 40.0;     % [mM]  [Wemuth1982, SABIORK: 22893]",
				"ALDR_k_galtol = 40.0;  % [mM]  [?]",
				"ALDR_k_nadp = 0.1;     % [mM]  [?]",
				"ALDR_k_nadph = 0.1;    % [mM]  [?]"
		};	
		String [] parsLoc = {
				"ALDR_P = 1;            % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// AssignmentRules
		String formula = "ALDR_f * c__GALK_Vmax * c__ALDR_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "ALDR_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// Reaction
		formula = "c__ALDR_Vmax/(ALDR_k_gal*ALDR_k_nadp) *(c__gal*c__nadph - c__galtol*c__nadp/ALDR_keq)/((1+c__gal/ALDR_k_gal)*(1+c__nadph/ALDR_k_nadph) +(1+c__galtol/ALDR_k_galtol)*(1+c__nadp/ALDR_k_nadp) -1)";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
	}
	
	/** [NADPR] NADP Reductase (nadp -> nadph)
		------------------------------------------------------------
		NADPR_P = 1;                     % [mM]
		NADPR_f = 1E-5;                 % [-];
		NADPR_keq = 1;                   % [-] % nadph/nadp
		NADPR_k_nadp  = 0.015;           % [mM] [Ozer2001, Corpas1995, Bautista1992]
		NADPR_ki_nadph = 0.010;          % [mM] [Ozer2001, Corpas1995, Bautista1992]
		NADPR_Vmax = NADPR_f * ALDR_Vmax * NADPR_P/REF_P;  % [mole/s]
		NADPR = NADPR_Vmax/NADPR_k_nadp *(nadp - nadph/NADPR_keq)/(1 +nadp/NADPR_k_nadp +nadph/NADPR_ki_nadph);  % [mole/s]                   
	 */
		public static void createLocalizedNADPR(Model model, String c, boolean createGlobal) throws ParseException{
			Reaction r = ReactionFactory.createLocalizedReaction(model, "[NADPR] NADP Reductase (nadp -> nadph)", c);
			r.setCompartment(c);
			String[] pars = {
					"NADPR_f = 1E-10;                 % [-];",
					"NADPR_keq = 1;                   % [-] % nadph/nadp",
					"NADPR_k_nadp  = 0.015;           % [mM] [Ozer2001, Corpas1995, Bautista1992]",
					"NADPR_ki_nadph = 0.010;          % [mM] [Ozer2001, Corpas1995, Bautista1992]"
			};	
			String [] parsLoc = {
					"NADPR_P = 1;                     % [mM]"
			};
			if (createGlobal){
				ParameterFactory.createParameters(model, pars);
			}
			ParameterFactory.createLocalizedParameters(model, parsLoc, c);
			
			// AssignmentRules
			String formula = "NADPR_f * c__ALDR_Vmax * c__NADPR_P/REF_P";
			AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "NADPR_Vmax"), 
					"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			// Reaction
			formula = "c__NADPR_Vmax/NADPR_k_nadp *(c__nadp - c__nadph/NADPR_keq)/(1 +c__nadp/NADPR_k_nadp +c__nadph/NADPR_ki_nadph)";
			ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			
			System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
		}
	
		
		/** [GALT] Galactose-1-phosphate uridyl transferase (gal1p + udpglc <-> glc1p + udpgal)
			------------------------------------------------------------
			GALT_P = 1;               % [mM]
			GALT_f = 0.0533;          % [-] 300/804*1/7
			GALT_keq = 1.0;           % [-] [?] 
			GALT_k_glc1p  = 0.37;     % [mM] [Geeganage1998]
			GALT_k_udpgal = 0.5;      % [mM] [?]
			GALT_ki_utp = 0.13;       % [mM] [Segal1971]
			GALT_ki_udp = 0.35;       % [mM] [Segal1971]
			GALT_vm = 804;            % [-] [Tang2011]
			GALT_k_gal1p  = 1.25;     % [mM] [Tang2011] (too high ?, 0.061 [Geeganage1998])
			GALT_k_udpglc = 0.43;     % [mM] [Tang2011] 
			GALT_Vmax = GALT_f*GALK_Vmax*GALT_vm * GALT_P/REF_P;  % [mole/s]
			GALT = GALT_Vmax/(GALT_k_gal1p*GALT_k_udpglc) *(gal1p*udpglc - glc1p*udpgal/GALT_keq) / ...
    				((1+gal1p/GALT_k_gal1p)*(1+udpglc/GALT_k_udpglc + udp/GALT_ki_udp + utp/GALT_ki_utp) + (1+glc1p/GALT_k_glc1p)*(1+udpgal/GALT_k_udpgal) - 1);  % [mole/s]  
	   */
		public static void createLocalizedGALT(Model model, String c, boolean createGlobal) throws ParseException{
			Reaction r = ReactionFactory.createLocalizedReaction(model, "[GALT] Galactose-1-phosphate uridyl transferase (gal1p + udpglc <-> glc1p + udpgal)", c);
			r.setCompartment(c);
			// Global and local parameters
			String[] pars = {
					"GALT_f = 0.01;          % [-] 300/804*1/7",
					"GALT_keq = 1.0;           % [-] [?] ",
					"GALT_k_glc1p  = 0.37;     % [mM] [Geeganage1998]",
					"GALT_k_udpgal = 0.5;      % [mM] [?]",
					"GALT_ki_utp = 0.13;       % [mM] [Segal1971]",
					"GALT_ki_udp = 0.35;       % [mM] [Segal1971]",
					"GALT_vm = 804;            % [-] [Tang2011]",
					"GALT_k_gal1p  = 1.25;     % [mM] [Tang2011] (too high ?, 0.061 [Geeganage1998])",
					"GALT_k_udpglc = 0.43;     % [mM] [Tang2011]" 
			};	
			String [] parsLoc = {
					"GALT_P = 1;               % [mM]"
			};
			if (createGlobal){
				ParameterFactory.createParameters(model, pars);
			}
			ParameterFactory.createLocalizedParameters(model, parsLoc, c);
			
			// AssignmentRules
			String formula = "c__GALT_P/REF_P * GALT_f*c__GALK_Vmax*GALT_vm";
			AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "GALT_Vmax"), 
					"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			// Reaction
			formula = "c__GALT_Vmax/(GALT_k_gal1p*GALT_k_udpglc) *(c__gal1p*c__udpglc - c__glc1p*c__udpgal/GALT_keq) / " +
					"((1+c__gal1p/GALT_k_gal1p)*(1+c__udpglc/GALT_k_udpglc + c__udp/GALT_ki_udp + c__utp/GALT_ki_utp) + (1+c__glc1p/GALT_k_glc1p)*(1+c__udpgal/GALT_k_udpgal) - 1)";
			ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			// Modifier
			r.createModifier(model.getSpecies(Naming.createLocalizedId(c, "udp") ));
			r.createModifier(model.getSpecies(Naming.createLocalizedId(c, "utp") ));
			
			if (c.equals(Naming.getCellId(1))){
			String[] defPars = {"GALT_vm", "GALT_k_gal1p", "GALT_k_udpglc"};
			for (String p : defPars){
				model.getParameter(p).setConstant(false);
			}
			/* Events for the deficiencies
       			case 9;  GALT_vm=396;  GALT_k_gal1p=1.89; GALT_k_udpglc=0.58;
       			case 10; GALT_vm=253;  GALT_k_gal1p=2.34; GALT_k_udpglc=0.69;
       			case 11; GALT_vm=297;  GALT_k_gal1p=1.12; GALT_k_udpglc=0.76;
       			case 12; GALT_vm=45;   GALT_k_gal1p=1.98; GALT_k_udpglc=1.23;
       			case 13; GALT_vm=306;  GALT_k_gal1p=2.14; GALT_k_udpglc=0.48;
       			case 14; GALT_vm=385;  GALT_k_gal1p=2.68; GALT_k_udpglc=0.95;  
	       */
			createDeficiencyEvent(model, 0, defPars, new String[]{"804", "1.25", "0.95"});
			createDeficiencyEvent(model, 9, defPars, new String[]{"396", "1.89", "0.58"});
			createDeficiencyEvent(model, 10, defPars, new String[]{"253", "2.34", "0.69"});
			createDeficiencyEvent(model, 11, defPars, new String[]{"297", "1.12", "0.76"});
			createDeficiencyEvent(model, 12, defPars, new String[]{"45", "1.98", "1.23"});
			createDeficiencyEvent(model, 13, defPars, new String[]{"306", "2.14", "0.48"});
			createDeficiencyEvent(model, 14, defPars, new String[]{"385", "2.68", "0.95"});
			}
			System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
		}	
		
		public static Event createDeficiencyEvent(Model model, int deficiency, String[] defPars, String[] values) throws ParseException{
			Event e = createDeficiencyEvent(model, deficiency);
			for (int k=0; k<defPars.length; ++k){
				e.createEventAssignment(defPars[k], ASTNode.parseFormula(values[k]));	
			}
			return e;
		}
				
		
		/** [GALE] UDP-glucose 4-epimerase (udpglc <-> udpgal)
			------------------------------------------------------------
			GALE_P = 1;               % [mM]
			GALE_f = 0.5;             % [-]
			GALE_PA = 0.0278;         % [s] (1/36)
			GALE_kcat = 36;           % [1/s] [Timson2005]
			GALE_keq = 0.33;          % [-]  [?] (udpgal/udpglc ~ 1/3) 
			GALE_k_udpglc  = 0.069;   % [mM] [Timson2005]
			GALE_k_udpgal  = 0.3;     % [mM] [?]
			GALE_Vmax = GALE_f*GALK_Vmax*GALE_PA*GALE_kcat*GALE_P/REF_P;  % [mole/s]
			GALE = GALE_Vmax/GALE_k_udpglc *(udpglc -udpgal/GALE_keq) /(1 +udpglc/GALE_k_udpglc +udpgal/GALE_k_udpgal);  % [mole/s]
   */
	public static void createLocalizedGALE(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[GALE] UDP-glucose 4-epimerase (udpglc <-> udpgal)", c);
		r.setCompartment(c);
		// Global and local parameters
		String[] pars = {
				"GALE_f = 0.3;             % [-]",
				"GALE_PA = 0.0278;         % [s] (1/36)",
				"GALE_kcat = 36;           % [1/s] [Timson2005]",
				"GALE_keq = 0.33;          % [-]  [?] (udpgal/udpglc ~ 1/3)", 
				"GALE_k_udpglc  = 0.069;   % [mM] [Timson2005]",
				"GALE_k_udpgal  = 0.3;     % [mM] [?]"
		};	
		String [] parsLoc = {
				"GALE_P = 1;               % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// AssignmentRules
		String formula = "GALE_f*c__GALK_Vmax*GALE_PA*GALE_kcat*c__GALE_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "GALE_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// Reaction
		formula = "c__GALE_Vmax/GALE_k_udpglc *(c__udpglc -c__udpgal/GALE_keq) /(1 +c__udpglc/GALE_k_udpglc +c__udpgal/GALE_k_udpgal)";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		// Deficiencies
		if (c.equals(Naming.getCellId(1))){
		String[] defPars = {"GALE_kcat", "GALE_k_udpglc"};
		for (String p : defPars){
			model.getParameter(p).setConstant(false);
		}
		/* Events for the deficiencies
       		case 15;  GALE_kcat=32;    GALE_k_udpglc=0.082;
       		case 16;  GALE_kcat=0.046; GALE_k_udpglc=0.093;
       		case 17;  GALE_kcat=1.1;   GALE_k_udpglc=0.160;
       		case 18;  GALE_kcat=5.0;   GALE_k_udpglc=0.140;
       		case 19;  GALE_kcat=11;    GALE_k_udpglc=0.097;
       		case 20;  GALE_kcat=5.1;   GALE_k_udpglc=0.066;
       		case 21;  GALE_kcat=5.8;   GALE_k_udpglc=0.035;
       		case 22;  GALE_kcat=30;    GALE_k_udpglc=0.078;
       		case 23;  GALE_kcat=15;    GALE_k_udpglc=0.099; 
       */
		createDeficiencyEvent(model, 0, defPars, new String[]{"36", "0.069"});
		createDeficiencyEvent(model, 15, defPars, new String[]{"32", "0.082"});
		createDeficiencyEvent(model, 16, defPars, new String[]{"0.046", "0.093"});
		createDeficiencyEvent(model, 17, defPars, new String[]{"1.1", "0.160"});
		createDeficiencyEvent(model, 18, defPars, new String[]{"5.0", "0.140"});
		createDeficiencyEvent(model, 19, defPars, new String[]{"11", "0.097"});
		createDeficiencyEvent(model, 20, defPars, new String[]{"5.1", "0.066"});
		createDeficiencyEvent(model, 21, defPars, new String[]{"5.8", "0.035"});
		createDeficiencyEvent(model, 22, defPars, new String[]{"30", "0.078"});
		createDeficiencyEvent(model, 23, defPars, new String[]{"15", "0.099"});
		}
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
	}	
	
	/** [UGP] UDP-glucose pyrophosphorylase (glc1p + utp <-> udpglc + ppi)
		------------------------------------------------------------
		UGP_P = 1;             % [mM]
		UGP_f = 20;             % [-]
		UGALP_f = 0.01;        % [-]
		UGP_keq = 0.45;        % [-]  [Guynn1974, Duggleby1996] (1/4.55 Guynn1974) DeltaG = 3.0kJ/mol (keq = 0.31 % 0.28 - 0.34 )
		UGP_k_utp = 0.563;     % [mM] [Duggleby1996, Chang1996]
		UGP_k_glc1p = 0.172;   % [mM] [Duggleby1996, Chang1996]
		UGP_k_udpglc = 0.049;  % [mM] [Duggleby1996, Chang1996]
		UGP_k_ppi = 0.166;     % [mM] [Duggleby1996, Chang1996]
		UGP_k_gal1p  = 5.0;    % [mM]
		UGP_k_udpgal = 0.42;   % [mM] [Knop1970]
		UGP_ki_utp = 0.643;    % [mM] [Duggleby1996] (competitive udpglc)
		UGP_ki_udpglc = 0.643; % [mM] [Duggleby1996] (competitive utp)
		UGP_Vmax = UGP_f * GALK_Vmax*UGP_P/REF_P;   % [mole/s] 
		UGP_dm = ((1 +utp/UGP_k_utp +udpglc/UGP_ki_udpglc)*(1 +glc1p/UGP_k_glc1p +gal1p/UGP_k_gal1p) + (1 +udpglc/UGP_k_udpglc +udpgal/UGP_k_udpgal +utp/UGP_ki_utp)*(1 +ppi/UGP_k_ppi) -1);  % [-] 
		UGP = UGP_Vmax/(UGP_k_utp*UGP_k_glc1p) *(glc1p*utp - udpglc*ppi/UGP_keq)/UGP_dm;  % [mole/s] 
		
		[UGALP] UDP-galactose pyrophosphorylase (gal1p + utp <-> udpgal + ppi)
		------------------------------------------------------------	
		UGALP = UGALP_f*UGP_Vmax/(UGP_k_utp*UGP_k_gal1p) *(gal1p*utp - udpgal*ppi/UGP_keq)/UGP_dm;  % [mole/s] 
*/
	public static void createLocalizedUGP(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[UGP] UDP-glucose pyrophosphorylase (glc1p + utp <-> udpglc + ppi)", c);
		r.setCompartment(c);
		Reaction r1 = ReactionFactory.createLocalizedReaction(model, "[UGALP] UDP-galactose pyrophosphorylase (gal1p + utp <-> udpgal + ppi)", c);
		r1.setCompartment(c);
		// Global and local parameters
		String[] pars = {
				"UGP_f = 2000;             % [-]",
				"UGALP_f = 0.01;        % [-]",
				"UGP_keq = 0.45;        % [-]  [Guynn1974, Duggleby1996] (1/4.55 Guynn1974) DeltaG = 3.0kJ/mol (keq = 0.31 % 0.28 - 0.34 )",
				"UGP_k_utp = 0.563;     % [mM] [Duggleby1996, Chang1996]",
				"UGP_k_glc1p = 0.172;   % [mM] [Duggleby1996, Chang1996]",
				"UGP_k_udpglc = 0.049;  % [mM] [Duggleby1996, Chang1996]",
				"UGP_k_ppi = 0.166;     % [mM] [Duggleby1996, Chang1996]",
				"UGP_k_gal1p  = 5.0;    % [mM]",
				"UGP_k_udpgal = 0.42;   % [mM] [Knop1970]",
				"UGP_ki_utp = 0.643;    % [mM] [Duggleby1996] (competitive udpglc)",
				"UGP_ki_udpglc = 0.643; % [mM] [Duggleby1996] (competitive utp)"
		};	
		String [] parsLoc = {
				"UGP_P = 1;             % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// AssignmentRules
		String formula = "UGP_f * c__GALK_Vmax*c__UGP_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "UGP_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		formula = "((1 +c__utp/UGP_k_utp +c__udpglc/UGP_ki_udpglc)*(1 +c__glc1p/UGP_k_glc1p +c__gal1p/UGP_k_gal1p) + (1 +c__udpglc/UGP_k_udpglc +c__udpgal/UGP_k_udpgal +c__utp/UGP_ki_utp)*(1 +c__ppi/UGP_k_ppi) -1)";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "UGP_dm"), 
				Kind.DIMENSIONLESS.name(), formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		
		// UGP
		formula = "c__UGP_Vmax/(UGP_k_utp*UGP_k_glc1p) *(c__glc1p*c__utp - c__udpglc*c__ppi/UGP_keq)/c__UGP_dm";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// UGALP
		formula = "UGALP_f*c__UGP_Vmax/(UGP_k_utp*UGP_k_gal1p) *(c__gal1p*c__utp - c__udpgal*c__ppi/UGP_keq)/c__UGP_dm";
		ReactionFactory.createKineticLaw(r1, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
		System.out.println(String.format("%s -> [%s]\n", r1.getId(), r1.getDerivedUnits()));	
	}	
		
	
	/** [PPASE] Pyrophosphatase (ppi a -> 2 phos)
		------------------------------------------------------------
		PPASE_P = 1;                   % [mM]
		PPASE_f = 4E-6;                % [-]
		PPASE_k_pp = 0.008;            % [mM] [Yoshida1982]
		PPASE_n = 3;                   % [-]
		PPASE_Vmax = PPASE_f*UGP_Vmax *PPASE_P/REF_P;  % [mole/s]
		PPASE = PPASE_Vmax * ppi^PPASE_n/(ppi^PPASE_n + PPASE_k_pp^PPASE_n);  % [mole/s]
	 */
		public static void createLocalizedPPASE(Model model, String c, boolean createGlobal) throws ParseException{
			Reaction r = ReactionFactory.createLocalizedReaction(model, "[PPASE] Pyrophosphatase (ppi -> 2 phos)", c);
			r.setCompartment(c);
			// Global and local parameters
			String[] pars = {
					"PPASE_f = 0.05;                % [-]",
					"PPASE_k_ppi = 0.07;            % [mM] [Yoshida1982]",
					"PPASE_n = 4;                   % [-]"
			};
			String [] parsLoc = {
					"PPASE_P = 1;                   % [mM]"
			};
			if (createGlobal){
				ParameterFactory.createParameters(model, pars);
			}
			ParameterFactory.createLocalizedParameters(model, parsLoc, c);
			
			// AssignmentRules
			String formula = "PPASE_f*c__UGP_Vmax *c__PPASE_P/REF_P";
			AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "PPASE_Vmax"), 
					"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			// Reaction
			formula = "c__PPASE_Vmax * c__ppi^PPASE_n/(c__ppi^PPASE_n + PPASE_k_ppi^PPASE_n)";
			ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			
			System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
		}		
		
		
		/** [NDKU] ATP:UDP phosphotransferase (atp + udp <-> adp + utp)
			------------------------------------------------------------
			NDKU_P = 1;         % [mM]
			NDKU_f = 10;        % [-]
			NDKU_keq = 1;       % [-]
			NDKU_k_atp = 1.33;  % [mM] [Kimura1988, Fukuchi1994]
			NDKU_k_adp = 0.042; % [mM] [Kimura1988, Lam1986]
			NDKU_k_utp = 27;    % [mM] [Fukuchi1994]
			NDKU_k_udp = 0.19;  % [mM] [Kimuara1988]
			NDKU_Vmax = NDKU_f* UGP_Vmax *NDKU_P/REF_P;  % [mole/s]
			NDKU = NDKU_Vmax/NDKU_k_atp/NDKU_k_udp *(atp*udp - adp*utp/NDKU_keq)/...
    				((1+atp/NDKU_k_atp)*(1+udp/NDKU_k_udp) + (1+adp/NDKU_k_adp)*(1+utp/NDKU_k_utp) -1);  % [mole/s]
	 */
		public static void createLocalizedNDKU(Model model, String c, boolean createGlobal) throws ParseException{
			Reaction r = ReactionFactory.createLocalizedReaction(model, "[NDKU] ATP:UDP phosphotransferase (atp + udp <-> adp + utp)", c);
			r.setCompartment(c);
			// Global and local parameters
			String[] pars = {
					"NDKU_f = 2;         % [-]",
					"NDKU_keq = 1;       % [-]",
					"NDKU_k_atp = 1.33;  % [mM] [Kimura1988, Fukuchi1994]",
					"NDKU_k_adp = 0.042; % [mM] [Kimura1988, Lam1986]",
					"NDKU_k_utp = 27;    % [mM] [Fukuchi1994]",
					"NDKU_k_udp = 0.19;  % [mM] [Kimuara1988]"
			};
			String [] parsLoc = {
					"NDKU_P = 1;         % [mM]"
			};
			if (createGlobal){
				ParameterFactory.createParameters(model, pars);
			}
			ParameterFactory.createLocalizedParameters(model, parsLoc, c);
			
			// AssignmentRules
			String formula = "NDKU_f * c__UGP_Vmax * c__NDKU_P/REF_P";
			AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "NDKU_Vmax"), 
					"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			// Reaction
			formula = "c__NDKU_Vmax/NDKU_k_atp/NDKU_k_udp *(c__atp*c__udp - c__adp*c__utp/NDKU_keq)/" +
						"((1+c__atp/NDKU_k_atp)*(1+c__udp/NDKU_k_udp) + (1+c__adp/NDKU_k_adp)*(1+c__utp/NDKU_k_utp) -1)";
			ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
			
			System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
		}	
		
		
		/** [PGM1] Phosphoglucomutase-1 (glc1p <-> glc6p + phos)
			------------------------------------------------------------
			PGM1_P = 1;                  % [mM]
			PGM1_f = 12.0;                % [-]
			PGM1_keq = 10.0;             % [-] ( [glc6p]/[glc1p] ~10-12 [Guynn1974]) DeltaG=-7.1 [kJ/mol] [Koenig2012]
			PGM1_k_glc6p  = 0.67;        % [mM] [Kashiwaya1994]
			PGM1_k_glc1p = 0.045;        % [mM] [Kashiwaya1994, Quick1994]
			PGM1_Vmax = PGM1_f * GALK_Vmax*PGM1_P/REF_P;   % [mole/s]
			PGM1 = PGM1_Vmax/PGM1_k_glc1p *(glc1p - glc6p/PGM1_keq)/(1+glc1p/PGM1_k_glc1p+glc6p/PGM1_k_glc6p);  % [mole/s]
		 */
	public static void createLocalizedPGM1(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[PGM1] Phosphoglucomutase-1 (glc1p <-> glc6p)", c);
		r.setCompartment(c);
		// Global and local parameters
		String[] pars = {
				"PGM1_f = 50.0;                % [-]",
				"PGM1_keq = 10.0;             % [-] ( [glc6p]/[glc1p] ~10-12 [Guynn1974]) DeltaG=-7.1 [kJ/mol] [Koenig2012]",
				"PGM1_k_glc6p  = 0.67;        % [mM] [Kashiwaya1994]",
				"PGM1_k_glc1p = 0.045;        % [mM] [Kashiwaya1994, Quick1994]"
		};
		String [] parsLoc = {
				"PGM1_P = 1;                  % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// AssignmentRules
		String formula = "PGM1_f * c__GALK_Vmax*c__PGM1_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "PGM1_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// Reaction
		formula = "c__PGM1_Vmax/PGM1_k_glc1p *(c__glc1p - c__glc6p/PGM1_keq)/(1+c__glc1p/PGM1_k_glc1p+c__glc6p/PGM1_k_glc6p)";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
	}	
	
	/** [GLY] Glycolysis (glc6p <-> phos)
	------------------------------------------------------------*/
	public static void createLocalizedGLY(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[GLY] Glycolysis (glc6p <-> phos)", c);
		r.setCompartment(c);
		// Global and local parameters
		String[] pars = {
				"GLY_f = 0.1;                % [-]",
				"GLY_k_glc6p = 0.12;         % [mM] [concentrations]",
				"GLY_k_p = 0.2;              % [mM] [limitation phosphate]"
		};
		String [] parsLoc = {
				"GLY_P = 1;                  % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// AssignmentRules
		String formula = "GLY_f * c__PGM1_Vmax*c__GLY_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "GLY_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		// Reaction
		formula = "c__GLY_Vmax*(c__glc6p - GLY_k_glc6p)/GLY_k_glc6p * c__phos/(c__phos + GLY_k_p)";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));	
	}	
	
	
	/** [GTFGAL] Glycosyltransferase galactose (udpgal -> udp)
		[GTFGLC] Glycosyltransferase glucose (udpglc -> udp)
		------------------------------------------------------------ */
	public static void createLocalizedGTF(Model model, String c, boolean createGlobal) throws ParseException{
		Reaction r = ReactionFactory.createLocalizedReaction(model, "[GTFGAL] Glycosyltransferase galactose (udpgal -> udp)", c);
		r.setCompartment(c);
		Reaction r1 = ReactionFactory.createLocalizedReaction(model, "[GTFGLC] Glycosyltransferase glucose (udpglc -> udp)", c);
		r1.setCompartment(c);
		
		// Global and local parameters
		String[] pars = {
				"GTF_f = 2E-2;         % [-]",
				"GTF_k_udpgal = 0.1;   % [mM]  (10-50µM Transporters)",
				"GTF_k_udpglc = 0.1;   % [mM]"
		};
		String [] parsLoc = {
				"GTF_P = 1;            % [mM]"
		};
		if (createGlobal){
			ParameterFactory.createParameters(model, pars);
		}
		ParameterFactory.createLocalizedParameters(model, parsLoc, c);
		
		// AssignmentRules
		String formula = "GTF_f * c__GALK_Vmax * c__GTF_P/REF_P";
		AssignmentFactory.createAssignmentRule(model, Naming.createLocalizedId(c , "GTF_Vmax"), 
				"mole_per_s", formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		// Reaction
		formula = "c__GTF_Vmax * c__udpgal/(c__udpgal + GTF_k_udpgal)";
		ReactionFactory.createKineticLaw(r, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		formula = "0.0* c__GTF_Vmax * c__udpglc/(c__udpglc + GTF_k_udpglc)";
		ReactionFactory.createKineticLaw(r1, formula.replaceAll("c__", c + Naming.PREFIX_SEP));
		
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));
		System.out.println(String.format("%s -> [%s]\n", r1.getId(), r1.getDerivedUnits()));
	}	
	
}
