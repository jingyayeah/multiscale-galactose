package model;

import model.ModelCreator.ModelType;

/** Describing metabolic cell model. 
 * 
 * TODO: better implementation via HashSets, ...
 * TODO: as an interface ?
 * */
public class AbstractModel {
	private ModelType modelType;
	private String[] speciesIds;
	private String[] speciesNames;
	private Double[] speciesInit;
	
	
	public AbstractModel(ModelType modelType, String[] speciesIds, String[] speciesNames, Double[] speciesInit){
		this.modelType = modelType;
		this.speciesIds = speciesIds;
		this.speciesNames = speciesNames;
		this.speciesInit = speciesInit;
	}
	
	public ModelType getModelType(){
		return modelType;
	}
	
	public String[] getSpeciesIds() {
		return speciesIds;
	}
	public String getSpeciesId(int k) {
		return speciesIds[k];
	}	
	
	public String[] getSpeciesNames() {
		return speciesNames;
	}
	public String getSpeciesName(int k){
		return speciesNames[k];
	}

	public Double[] getSpeciesInits() {
		return speciesInit;
	}
	public Double getSpeciesInit(int k){
		return speciesInit[k];
	}
	
	public int getIdsCount(){
		return speciesIds.length;
	}
}
