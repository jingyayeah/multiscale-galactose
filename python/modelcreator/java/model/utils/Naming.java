package model.utils;

public class Naming {
	public final static String PREFIX_SEP = "__"; 
	
	// Naming of the variables
	public static String getSinusoidId(int i){
		return String.format("S%03d", i); 
	}
	public static  String getSinusoidName(int i){
		return String.format("[S%03d] Sinusoid Space %d", i, i); 
	}
	
	public static  String getDisseId(int i){
		return String.format("D%03d", i); 
	}
	public static  String getDisseName(int i){
		return String.format("[D%03d] Disse Space %d", i, i); 
	}
	
	public static  String getCellId(int i){
		return String.format("H%02d", i); 
	}
	public static  String getCellName(int i){
		return String.format("[H%02d] Hepatocyte %d", i, i); 
	}
	
	public static  String getPeriportalId(){
		return "PP"; 
	}
	public static  String getPeriportalName(){
		return "[PP] periportal"; 
	}
	
	public static  String getPerivenousId(){
		return "PV";
	}
	public static  String getPerivenousName(){
		return "[PV] perivenious";
	}
	
	// This is how localized ids are generated
	public static String createLocalizedId(String compartment, String id){
		return compartment + PREFIX_SEP + id;
	}
	public static String createLocalizedName(String compartment, String name){
		return String.format("%s (%s)", name, compartment);
	}
	
	/** Names for the flow reactions in the model. */
	public static String createFlowId(String c1, String c2, String sId){
		return String.format("Flow%s%s_%s", c1, c2, sId);
	}
	
	/** Names for the diffusion reactions in the model. */
	public static String createDiffusionId(String c1, String c2, String sId){
		return String.format("Diff%s%s_%s", c1, c2, sId);
	}
}
