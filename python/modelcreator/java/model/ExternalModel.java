package model;

import java.util.HashMap;

import model.ModelCreator.ModelType;

/** External model components in Disse and Sinusoid. */
public class ExternalModel extends AbstractModel{
    ///////////////////////////////////
	static HashMap<String, Double> ddata; 
	static {
		ddata = new HashMap<String, Double>();
		ddata.put("h2oM", 2200E-12);  // [m2_per_s]
		ddata.put("suc",   720E-12);  // [m2_per_s]
		ddata.put("glc",   910E-12);  // [m2_per_s]
		ddata.put("gal",   910E-12);  // [m2_per_s]
		ddata.put("galM",  910E-12);  // [m2_per_s]
		ddata.put("alb",    90E-12);  // [m2_per_s]
		ddata.put("rbcM",    0E-12);  // [m2_per_s]
	}
		
    public static Double[] getDiffusionCoefficientsForIds(String[] ids){
    	Double[] coeffs = new Double[ids.length];
    	for (int k=0; k<ids.length; ++k){
    		String id = ids[k];
    		if (! ddata.containsKey(id) ){
    			System.err.println("Diffusion Coefficient not defined for: " + id);
    			coeffs[k] = -1.0;
    		}else{
    			coeffs[k] = ddata.get(id);
    		}
    	}
		return coeffs;
	}
    ///////////////////////////////////
	
	private Double[] speciesInitPP;
	private Double[] Ddata;
	
	public ExternalModel(ModelType defModel, String[] speciesIds, String[] speciesNames, Double[] speciesInit, Double[] ppInit){
		super(defModel, speciesIds, speciesNames, speciesInit);
		this.speciesInitPP = ppInit;
		this.Ddata = getDiffusionCoefficientsForIds(speciesIds);
	}
	
	public Double[] getSpeciesInitPP() {
		return speciesInitPP;
	}
	public Double getSpeciesInitPP(int k) {
		return speciesInitPP[k];
	}
	
	public Double[] getDdata() {
		return Ddata;
	}
	public Double getDdata(int k) {
		return Ddata[k];
	}
	
}
