package model;

import model.ModelCreator.ModelType;

public class CellModel extends AbstractModel {

	public CellModel(ModelType defModel, String[] speciesIds, 
						String[] speciesNames, Double[] speciesInit) {
		super(defModel, speciesIds, speciesNames, speciesInit);
	}
}
