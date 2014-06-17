package model;

/** Model Parameters defining the sinusoid geometry.
 *  TODO: create models with arbitrary geometry, not only standard
 *  	geometry. 
 */
public class SinusoidModelPars {
	private String id; 
	private String name; 
	private int version;
	private int Nc;
	private int Nf;
	private int Nb;
	
	private double L =  500E-6;
	private double y_sin = 4.4E-6;
	private double y_dis = 1.2E-6;
	private double y_cell = 7.58E-6;
	private double flow_sin = 180E-6;
	private double f_fen = 0.09;
	private double Vol_liv = 1.5E-3;         
	private double rho_liv = 1.1E3; 
	private double Q_liv = 1.750E-3/60;
	
	private Boolean withFlow = true;
	private Boolean withDiffusion = true;
	private Boolean withCells = true;
	
	public SinusoidModelPars(String name, Integer version, int Nc, int Nf){
		this.name = name;
		this.version = version;
		this.Nc = Nc;
		this.Nf = Nf;
		Nb = Nc*Nf;
		id = createId();
	}
	
	private String createId(){
		return String.format("%s_v%d_Nc%d_Nf%d", name, version, Nc, Nf);
	}
	public String getId(){
		return id;
	}
	public String getName(){
		return name;
	}
	
	public int getVersion(){
		return version;
	}
	
	public Boolean isWithFlow() {
		return withFlow;
	}
	public Boolean isWithDiffusion() {
		return withDiffusion;
	}
	public Boolean isWithCells() {
		return withCells;
	}
	public double getL() {
		return L;
	}
	public double getY_sin() {
		return y_sin;
	}
	public double getY_dis() {
		return y_dis;
	}
	public double getY_cell() {
		return y_cell;
	}
	public double getFlow_sin() {
		return flow_sin;
	}
	public double getF_fen() {
		return f_fen;
	}
	public double getVol_liv() {
		return Vol_liv;
	}
	public double getRho_liv() {
		return rho_liv;
	}
	public double getQ_liv() {
		return Q_liv;
	}
	public int getNc() {
		return Nc;
	}
	public int getNf() {
		return Nf;
	}
	public int getNb() {
		return Nb;
	}
}
