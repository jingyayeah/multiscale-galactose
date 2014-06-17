package model;

import model.ModelCreator.ModelType;

/** Factory class for the creation of ExtModels  */
public class ExternalModelFactory {

	public static ExternalModel createExternalModel(ModelType definedModel){
		switch(definedModel){
			case Galactose:
				return createGalactoseModel(definedModel);
			case GalactoseComplete:
				return createGalactoseCompleteModel(definedModel);
			case MultipleIndicator:
				return createMultipleIndicatorModel(definedModel);
			case Simple:
				return createSimpleModel(definedModel);
			case GalactoseCell:
				return createGalactoseCellModel(definedModel);
			default:
				System.err.println("No External model defined for type:" + definedModel);
				return null;
		}
	}

	/** External substances for the galactose model. */
	private static ExternalModel createGalactoseModel(ModelType definedModel){
		// String[] ids = {"rbcM", "suc", "alb", "gal", "galM", "h2oM"};
		// String[] names = ids;
		// Double[] sInit = {0.0, 0.0, 0.0, 0.00012, 0.0, 0.0};  // [mole_per_m3]
		// Double[] ppInit = {0.0, 0.0, 0.0, 0.00012, 0.0, 0.0}; // [mole_per_m3]
		String[] ids = {"gal", "galM", "h2oM"};
		String[] names = ids;
		Double[] sInit = {0.00012, 0.0, 0.0};  // [mole_per_m3]
		Double[] ppInit = {0.00012, 0.0, 0.0}; // [mole_per_m3]
		return new ExternalModel(definedModel, ids, names, sInit, ppInit);
	}
	
	/** External substances for the galactose model. */
	private static ExternalModel createGalactoseCompleteModel(ModelType definedModel){
		String[] ids = {"gal", "galM", "rbcM", "alb", "suc", "h2oM" };
		String[] names = {"D-galactose", "D-galactoseM", "Red Blood Cells", "Albumin", "Succinate", "Water"};
		Double[] sInit = {0.00012,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0}; 	//[mole_per_m3]
		Double[] ppInit = {0.00012, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};	//[mole_per_m3]
		return new ExternalModel(definedModel, ids, names, sInit, ppInit);
	}
	
	
	/** External substances for the galactose model. */
	private static ExternalModel createGalactoseCellModel(ModelType definedModel){
		String[] ids = {"gal", "galM"};
		String[] names = ids;
		Double[] sInit = {0.00012, 0.0};       // [mole_per_m3]
		Double[] ppInit = {0.00012, 0.0}; 	   // [mole_per_m3]
		return new ExternalModel(definedModel, ids, names, sInit, ppInit);
	}
	
	private static ExternalModel createMultipleIndicatorModel(ModelType definedModel){
		String[] ids = {"gal", "rbcM", "alb", "suc", "h2oM" };
		String[] names = {"D-galactose", "Red Blood Cells", "Albumin", "Succinate", "Water"};
		Double[] sInit = {0.00012, 0.0, 0.0, 0.0, 0.0, 0.0}; 	//[mole_per_m3]
		Double[] ppInit = {0.00012, 0.0, 0.0, 0.0, 0.0, 0.0};	//[mole_per_m3]
		return new ExternalModel(definedModel, ids, names, sInit, ppInit);
	}
	
	private static ExternalModel createSimpleModel(ModelType definedModel){
		String[] ids = {"h2oM"};
		String[] names = {"water"};
		Double[] sInit = {0.0}; 	    // [mole_per_m3]
		Double[] ppInit = {0.0};	    // [mole_per_m3]
		return new ExternalModel(definedModel, ids, names, sInit, ppInit);
	}
}
