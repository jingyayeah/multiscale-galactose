package model;

import model.ModelCreator.ModelType;

//TODO: implement in better table (better overview)
public class CellModelFactory {
	
	public static CellModel createCellModel(ModelType definedModel){
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
	
	private static CellModel createGalactoseModel(ModelType definedModel){
		// Define names
		String[] sIds = {"gal", "galM", "h2oM", "glc1p", "glc6p", "gal1p", "udpglc", "udpgal", "galtol", "atp", "adp", "utp", "udp", "phos", "ppi", "nadp", "nadph"};
		String[] sNames = {"D-galactose", "D-galactose M", "H2O M", "D-glucose-1-phosphate", "D-glucose-6-phosphate",
							"D-galactose-1-phosphate", "UDP-D-glucose", "UDP-D-galactose", "D-galactitol", "ATP", "ADP", "UTP",
											"UDP", "Phosphate", "Pyrophosphate", "NADP", "NADPH"};
		Double[] sInit = {0.00012,    0.0,   0.0,    0.012,    0.12,    0.001,   0.34,     0.11,     0.001,    2.7,   1.2,   0.27,  0.09,  5.0,  0.008, 0.1, 0.1}; 	// [mole_per_m3]
		return new CellModel(definedModel, sIds, sNames, sInit);
	}
	
	private static CellModel createGalactoseCompleteModel(ModelType definedModel){
		return createGalactoseModel(definedModel);
	}
	
		
	private static CellModel createGalactoseCellModel(ModelType definedModel){
		// Define names
		String[] sIds = {"gal", "galM", "h2oM", "glc1p", "glc6p", "gal1p", "udpglc", "udpgal", "galtol", "atp", "adp", "utp", "udp", "phos", "ppi", "nadp", "nadph"};
		String[] sNames = {"D-galactose", "D-galactose M", "H2O M", "D-glucose-1-phosphate", "D-glucose-6-phosphate",
							"D-galactose-1-phosphate", "UDP-D-glucose", "UDP-D-galactose", "D-galactitol", "ATP", "ADP", "UTP",
											"UDP", "Phosphate", "Pyrophosphate", "NADP", "NADPH"};
		Double[] sInit = {0.00012,    0.0,   0.0,    0.012,    0.12,    0.001,   0.34,     0.11,     0.001,    2.7,   1.2,   0.27,  0.09,  5.0,  0.008, 0.1, 0.1}; 	// [mole_per_m3]
		return new CellModel(definedModel, sIds, sNames, sInit);
	}
	
	
	private static CellModel createMultipleIndicatorModel(ModelType definedModel){
		String[] sIds   = {"h2oM"};
		String[] sNames = {"Water marked"};
		Double[] sInit  = {0.0}; 	// [mole_per_m3]
		return new CellModel(definedModel, sIds, sNames, sInit);
	}
	
	private static CellModel createSimpleModel(ModelType definedModel){
		String[] sIds = {"h2oM"};
		String[] sNames = {"H2O M"};
		Double[] sInit = {0.0}; 	// [mole_per_m3]
		return new CellModel(definedModel, sIds, sNames, sInit);
	}
}
