package model.processes;

import model.ExternalModel;
import model.SBMLUtils;
import model.assignments.AssignmentFactory;
import model.parameters.ParameterFactory;
import model.utils.Naming;

import org.sbml.jsbml.Model;
import org.sbml.jsbml.Reaction;
import org.sbml.jsbml.SpeciesReference;
import org.sbml.jsbml.text.parser.ParseException;

public class TransportProcessFactory {
	/** Creates the blood flow reactions between sinusoidal compartments. */
	
	public static void createFlowReactions(Model model, ExternalModel em, int Nb) throws ParseException{
		String[] sIdsExt = em.getSpeciesIds();
		for (int k=0; k<sIdsExt.length; k++){
			String mId = sIdsExt[k];
			
			// changes between pp and 1 compartment flow
			String cFromId = Naming.getPeriportalId();
			String cToId = Naming.getSinusoidId(1);
			TransportProcessFactory.createFlowReaction(model, mId, cFromId, cToId);
			
			for (int i=1; i<Nb; i++){
				cFromId = Naming.getSinusoidId(i);
			    cToId = Naming.getSinusoidId(i+1);
			    TransportProcessFactory.createFlowReaction(model, mId, cFromId, cToId);			
			}
			
			// changes between Nb and pv
			cFromId = Naming.getSinusoidId(Nb);
		    cToId = Naming.getPerivenousId();
		    TransportProcessFactory.createFlowReaction(model, mId, cFromId, cToId);			
			
			// changes in pv flow
			cFromId = Naming.getPerivenousId();
			cToId = "NULL";
			TransportProcessFactory.createFlowReaction(model, mId, cFromId, cToId);
		}
	}
	
	/** Creates the diffusion reactions between sinusoidal compartments, 
	 * between disse compartments and between the sinusoidal and disse spaces.
	 */
	public static void createDiffusionReactions(Model model, ExternalModel em, int Nb) throws ParseException{
		String[] sIdsExt = em.getSpeciesIds();
		Double[] Ddata = em.getDdata();
		for (int k=0; k<sIdsExt.length; k++){
			String mId = sIdsExt[k];
			
			// Define diffusion constants
			ParameterFactory.createParameter(model, "D"+mId, Ddata[k], "m2_per_s", true);
			
			// Define geometrical diffusion constants
			AssignmentFactory.createInitialAssignment(model, "Dx_sin_"+mId, "m3_per_s", String.format("D%s/x_sin * A_sin", mId));
			AssignmentFactory.createInitialAssignment(model, "Dx_dis_"+mId, "m3_per_s", String.format("D%s/x_sin * A_dis", mId));
			AssignmentFactory.createInitialAssignment(model, "Dy_sindis_"+mId, "m3_per_s", String.format("D%s/y_dis * f_fen * A_sindis", mId));

			// [1] Sinusoid Diffusion
			// changes between pp and 1 sinusoid diffusion
			String cFromId = Naming.getPeriportalId();
			String cToId = Naming.getSinusoidId(1);
			TransportProcessFactory.createDiffusionReaction(model, mId, cFromId, cToId, "Dx_sin_"+mId);
			
			// changes in the internal sinusoid compartments
			for (int i=1; i<=Nb-1; i++){
				cFromId = Naming.getSinusoidId(i);
			    cToId = Naming.getSinusoidId(i+1);
			    TransportProcessFactory.createDiffusionReaction(model, mId, cFromId, cToId, "Dx_sin_"+mId);			
			}
			
			// changes between Nb and pv
			cFromId = Naming.getSinusoidId(Nb);
		    cToId = Naming.getPerivenousId();
		    TransportProcessFactory.createDiffusionReaction(model, mId, cFromId, cToId, "Dx_sin_"+mId);			
						
			// [2] Disse Diffusion
			for (int i=1; i<=Nb-1; i++){
				cFromId = Naming.getDisseId(i);
			    cToId = Naming.getDisseId(i+1);
			    TransportProcessFactory.createDiffusionReaction(model, mId, cFromId, cToId, "Dx_dis_"+mId);			
			}
			
			// [3] Sinusoid-Disse diffusion
			for (int i=1; i<=Nb; i++){
				cFromId = Naming.getSinusoidId(i);
			    cToId = Naming.getDisseId(i);
			    TransportProcessFactory.createDiffusionReaction(model, mId, cFromId, cToId, "Dy_sindis_"+mId);			
			}
		}
	}	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// MASTER EQUATIONS
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/** Transport via convection in the sinusoids. */
	public static Reaction createFlowReaction(Model model, String mId, String cFromId, String cToId) throws ParseException{
		
		String sFromId = Naming.createLocalizedId(cFromId, mId);
		String sToId = Naming.createLocalizedId(cToId, mId);
		String rId = Naming.createFlowId(cFromId, cToId, mId);
		
		Reaction r = model.createReaction(rId);
		r.setName(rId);
		r.setReversible(true);
		SpeciesReference sref = r.createReactant(model.getSpecies(sFromId));
		sref.setStoichiometry(1.0);
		if (SBMLUtils.SBML_LEVEL > 2){
			sref.setConstant(true);
		}
		if (!cToId.equals("NULL")){
			sref = r.createProduct(model.getSpecies(sToId));
			sref.setStoichiometry(1.0);
			if (SBMLUtils.SBML_LEVEL > 2){
				sref.setConstant(true);
			}
		}
		ReactionFactory.createKineticLaw(r, String.format("flow_sin * %s * A_sin", sFromId)); // in [mole/s]
		if (SBMLUtils.SBML_LEVEL > 2){
			r.setFast(false);
		}
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));
		return r;
	}
	
	/** Transport via Diffusion in sinusoids, space of Disse and in between. */
	public static Reaction createDiffusionReaction(Model model, String mId, String cFromId, String cToId, String Dxy) throws ParseException{
		// Get and create necessary ids
		String sFromId = Naming.createLocalizedId(cFromId, mId);
		String sToId = Naming.createLocalizedId(cToId, mId);
		String rId = Naming.createDiffusionId(cFromId, cToId, mId);
		
		// create reaction
		Reaction r = model.createReaction(rId);
		r.setName(rId);
		r.setReversible(true);
		SpeciesReference sref = r.createReactant(model.getSpecies(sFromId));
		sref.setStoichiometry(1.0);
		if (SBMLUtils.SBML_LEVEL > 2){
			sref.setConstant(true);
		}
		if (!cToId.equals("NULL")){
			sref = r.createProduct(model.getSpecies(sToId));
			sref.setStoichiometry(1.0);
			if (SBMLUtils.SBML_LEVEL > 2){
				sref.setConstant(true);
			}
		}
		// create kinetics
		if (!cToId.equals("NULL")){
			ReactionFactory.createKineticLaw(r, String.format("%s * (%s - %s)", Dxy, sFromId, sToId)); // in [mole/s]
		} else {
			ReactionFactory.createKineticLaw(r, String.format("%s * (%s)", Dxy, sFromId)); // in [mole/s]	
		}
		if (SBMLUtils.SBML_LEVEL > 2){
			r.setFast(false);
		}
		System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));
		return r;
	}
	
}
