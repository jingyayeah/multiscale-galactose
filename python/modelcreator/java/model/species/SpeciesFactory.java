package model.species;

import org.sbml.jsbml.Model;
import org.sbml.jsbml.Species;

import model.ExternalModel;
import model.ModelCreator.ModelType;
import model.utils.Naming;

/** Handle the creation of the species and localised species for the 
 * model and related tools.
 * @author Matthias Koenig
 * @date 2014-04-28
 *
 */
public class SpeciesFactory {
	public enum InitType{
		AMOUNT,
		CONCENTRATION;
	}
		
	public static Species createSpecies(Model model, String id, String name, String compartment, double init, String units, 
			InitType type){
		Species s = model.createSpecies(id, model.getCompartment(compartment));
		s.setName(name);
		if (type == InitType.AMOUNT){
			s.setInitialAmount(init);	
		} else if (type == InitType.CONCENTRATION){
			s.setInitialConcentration(init);
		}
		s.setUnits(units);
		s.setSubstanceUnits(model.getSubstanceUnits());
		s.setHasOnlySubstanceUnits(false);
		s.setBoundaryCondition(false);
		s.setConstant(false);
		return s;
	}
	
	
	/** Creates all the external species in sinusoid and disse space. */
	public static void createExternalSpecies(Model model, ExternalModel em, int Nc, int Nf){
		String[] sIdsExt = em.getSpeciesIds();
		String[] sNamesExt = em.getSpeciesNames();
		Double[] sInitExt = em.getSpeciesInits();
		Double[] ppInit = em.getSpeciesInitPP();
		//Double[] Ddata = em.getDdata();
		
		if (em.getModelType() != ModelType.GalactoseCell){
			// Compartments are numbered from 1, ...
			for (int k=0; k<sIdsExt.length; k++){
				String mId = sIdsExt[k];
				String mName = sNamesExt[k];
				Double init = sInitExt[k];
				String sId = Naming.createLocalizedId(Naming.getPeriportalId(), mId);
				createSpecies(model, sId, mName, Naming.getPeriportalId(), ppInit[k], "mole_per_m3", InitType.CONCENTRATION);
				for (int i=1; i<=Nc*Nf; i++){
					sId = Naming.createLocalizedId(Naming.getSinusoidId(i), mId);
					createSpecies(model, sId, mName, Naming.getSinusoidId(i), init, "mole_per_m3", InitType.CONCENTRATION);
					sId = Naming.createLocalizedId(Naming.getDisseId(i), mId);
					createSpecies(model, sId, mName, Naming.getDisseId(i), init, "mole_per_m3", InitType.CONCENTRATION);
				}
				sId = Naming.createLocalizedId(Naming.getPerivenousId(), mId);
				createSpecies(model, sId, mName, Naming.getPerivenousId(), init, "mole_per_m3", InitType.CONCENTRATION);
			}
		} else {
			// GalactoseCell model handle differently (only create disse)
			for (int k=0; k<sIdsExt.length; k++){
				String mId = sIdsExt[k];
				String mName = sNamesExt[k];
				Double init = sInitExt[k];
				for (int i=1; i<=Nc*Nf; i++){
					String sId = Naming.createLocalizedId(Naming.getDisseId(i), mId);
					createSpecies(model, sId, mName, Naming.getDisseId(i), init, "mole_per_m3", InitType.CONCENTRATION);
				}
			}
			
		}
	}
	
}
