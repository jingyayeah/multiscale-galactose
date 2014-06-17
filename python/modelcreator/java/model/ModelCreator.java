package model;

import java.io.FileNotFoundException;
import java.util.Collection;
import java.util.LinkedList;

import javax.xml.stream.XMLStreamException;

import org.sbml.jsbml.Creator;
import org.sbml.jsbml.History;
import org.sbml.jsbml.Model;
import org.sbml.jsbml.SBMLException;
import org.sbml.jsbml.Unit.Kind;
import org.sbml.jsbml.text.parser.ParseException;

import model.parameters.ParameterFactory;
import model.processes.GalactoseReactionFactory;
import model.processes.GalactoseTransporterFactory;
import model.processes.TransportProcessFactory;
import model.species.SpeciesFactory;
import model.units.UnitDefinitionFactory;
import model.utils.Naming;
import model.assignments.AssignmentFactory;
import model.compartments.CompartmentFactory;
import model.events.EventData;
import model.events.EventFactory;

/** Main class to generate the final SBML of the hierarchical model.
 * The model components are packed with the given Events in the SBML.
 * 
 * @author Matthias Koenig
 * 
 * TODO: break up in more components 
 */

public class ModelCreator {
	
	public enum ModelType{
		Galactose, GalactoseComplete, MultipleIndicator, Simple, GalactoseCell;
	}
		
	private Model model;
	private SinusoidModelPars pars;
	private ExternalModel em;
	private CellModel cm;
	private Collection<EventData> eData = new LinkedList<EventData>();
	private int Nc;
	private int Nf;
	private int Nb;
	
	public ModelCreator(SinusoidModelPars sinusoidalParameters, 
		    ExternalModel extModel, 
		    CellModel cellModel) throws SBMLException, FileNotFoundException, ParseException, XMLStreamException{
		init(sinusoidalParameters, extModel, cellModel);
	}
	
	public ModelCreator(SinusoidModelPars sinusoidalParameters, 
					    ExternalModel extModel, 
					    CellModel cellModel, 
					    Collection<EventData> eventData) throws SBMLException, FileNotFoundException, ParseException, XMLStreamException{
		init(sinusoidalParameters, extModel, cellModel);
		eData = eventData;
	}
	
	private void init(SinusoidModelPars sinusoidalParameters, ExternalModel extModel, CellModel cellModel){
		pars = sinusoidalParameters;
		em = extModel;
		cm = cellModel;
		Nc = pars.getNc();
		Nf = pars.getNf();
		Nb = pars.getNb();
	}
	
	public Model getModel(){
		if (model == null){
			createModel();
		}
		return model;
	}
	
	public void createModel(){
		model = createCoreModel();
		try {
			createFullModel();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	private Model createCoreModel(){
		Model m = new Model(pars.getId(), SBMLUtils.SBML_LEVEL, SBMLUtils.SBML_VERSION);
		m.setName(pars.getName());
		
		// generate the unit definitions
		UnitDefinitionFactory.createUnitDefinitions(m);
		return m;
	}
	
	/** Creates the full sinusoid model. Flow with Diffusion and cell metabolism. 
	 * @throws ParseException */
	private void createFullModel() throws ParseException{
		createParameters();
		createAssignmentRules();
		CompartmentFactory.createExternalCompartments(model, em, Nc, Nf);
		SpeciesFactory.createExternalSpecies(model, em, Nc, Nf);

		if (em.getModelType() != ModelType.GalactoseCell){
			if (pars.isWithFlow()){
				TransportProcessFactory.createFlowReactions(model, em, Nb);
			}
			if (pars.isWithDiffusion()){
				TransportProcessFactory.createDiffusionReactions(model, em, Nb);
			}
		}
		if (pars.isWithCells()){
			createCellReactions(model);
		}
		
		// Events
		EventFactory.createEventsInModel(eData, model);
		
		//TODO: boundary conditions ? CHECK THIS
		// Boundary Conditions (also provide from outside)
		createBoundaryConditions(model);
	}
	
	private void createParameters(){
		ParameterFactory.createParameter(model, "L", pars.getL(), "m", true);
		ParameterFactory.createParameter(model, "y_sin", pars.getY_sin(), "m", true);
		ParameterFactory.createParameter(model, "y_dis", pars.getY_dis(), "m", true);
		ParameterFactory.createParameter(model, "y_cell", pars.getY_cell(), "m", true);
		ParameterFactory.createParameter(model, "flow_sin", pars.getFlow_sin(), "m_per_s", true);
		ParameterFactory.createParameter(model, "f_fen", pars.getF_fen(), Kind.DIMENSIONLESS.getName(), true);
		
		ParameterFactory.createParameter(model, "Vol_liv", pars.getVol_liv(), "m3", true);
		ParameterFactory.createParameter(model, "rho_liv", pars.getRho_liv(), "kg_per_m3", true);
		ParameterFactory.createParameter(model, "Q_liv", pars.getQ_liv(), "m3_per_s", true);
		
		ParameterFactory.createParameter(model, "Nc", new Double(Nc), Kind.DIMENSIONLESS.getName(), true);
		ParameterFactory.createParameter(model, "Nf", new Double(Nf), Kind.DIMENSIONLESS.getName(), true);
	}
	
	private void createAssignmentRules() throws ParseException{
		AssignmentFactory.createInitialAssignment(model, "Nb", Kind.DIMENSIONLESS.getName(), "Nf*Nc");
		AssignmentFactory.createInitialAssignment(model, "x_cell", "m", "L/Nc");
		AssignmentFactory.createInitialAssignment(model, "x_sin",  "m", "x_cell/Nf");

		AssignmentFactory.createInitialAssignment(model, "A_sin",  "m2", "pi*y_sin^2");
		AssignmentFactory.createInitialAssignment(model, "A_dis",  "m2", "pi*(y_sin+y_dis)^2 - A_sin");
		AssignmentFactory.createInitialAssignment(model, "A_sindis",  "m2", "2*pi*y_sin*x_sin");
		
		AssignmentFactory.createInitialAssignment(model, "Vol_sin",  "m3", "A_sin*x_sin");
		AssignmentFactory.createInitialAssignment(model, "Vol_dis",  "m3", "A_dis*x_sin");
		AssignmentFactory.createInitialAssignment(model, "Vol_cell", "m3", "pi*(y_sin+y_dis+y_cell)^2 *x_cell- pi*(y_sin+y_dis)^2*x_cell");	
		AssignmentFactory.createInitialAssignment(model, "Vol_pp",  "m3", "Vol_sin");
		AssignmentFactory.createInitialAssignment(model, "Vol_pv",  "m3", "Vol_sin");
		
		AssignmentFactory.createInitialAssignment(model, "f_sin", Kind.DIMENSIONLESS.getName(), "Vol_sin/(Vol_sin + Vol_dis + Vol_cell)");
		AssignmentFactory.createInitialAssignment(model, "f_dis", Kind.DIMENSIONLESS.getName(), "Vol_dis/(Vol_sin + Vol_dis + Vol_cell)");
		AssignmentFactory.createInitialAssignment(model, "f_cell", Kind.DIMENSIONLESS.getName(), "Vol_cell/(Vol_sin + Vol_dis + Vol_cell)");
		

		AssignmentFactory.createInitialAssignment(model, "Vol_sinunit",  "m3", "L*pi*(y_sin + y_dis + y_cell)^2");				
		AssignmentFactory.createInitialAssignment(model, "Q_sinunit",  "m3_per_s", "pi*y_sin^2*flow_sin");
		AssignmentFactory.createInitialAssignment(model, "m_liv",  "kg", "rho_liv * Vol_liv");
		AssignmentFactory.createInitialAssignment(model, "q_liv",  "m3_per_skg", "Q_liv/m_liv");		
	}
	
	private void createCellReactions(Model model) throws ParseException {
		switch (em.getModelType()) {
			case Galactose:
				createGalactoseCellModels(model);
				break;
			case GalactoseComplete:
				createGalactoseCellModels(model);
				break;
			case MultipleIndicator:
				createMultipleIndicatorCellModels(model);
				break;
			case GalactoseCell:
				createGalactoseCellModels(model);
			default:
				System.err.println("Model not supported: "
										+ em.getModelType().toString());
		}
	}
	
	
	/** 
	 * Galactose specific cell model which is included and coupled.
	 * Depending on the actual model different functions have to be called.
	 * @param model
	 * @throws ParseException
	 */
	private void createGalactoseCellModels(Model model) throws ParseException{
		// create the compartments
		CompartmentFactory.createCellCompartments(model, Nc);
		
		// Create global cell parameters
		ParameterFactory.createParameter(model, "scale_f = 10E-15;  % [-]");
		AssignmentFactory.createInitialAssignment(model, "scale", Kind.DIMENSIONLESS.getName(), "scale_f");
		ParameterFactory.createParameter(model, "REF_P = 1;        % [mM]");
		ParameterFactory.createParameter(model, "deficiency = 0;   % [-]");  // Type of galactosemia
		
		// Create the information for all the Nc cells
		boolean createGlobal = true;	// global parameters have to be generated once
		for (int c=1; c<=Nc; c++){
			String cId = Naming.getCellId(c);
							
			// Create species
			for (int k=0; k<cm.getIdsCount(); k++){
				String mId = cm.getSpeciesId(k);
				String mName = cm.getSpeciesName(k);
				Double sInit = cm.getSpeciesInit(k);
				String locId = Naming.createLocalizedId(cId, mId);
				SpeciesFactory.createSpecies(model, locId, mName, cId, sInit, "mole_per_m3", SpeciesFactory.InitType.CONCENTRATION);
			}
			
			// TODO: handle model specific
			// create assignment rules for balances
			String formula = "c__nadp + c__nadph";
			AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "nadp_tot"), "mole_per_m3", formula.replaceAll("c__", cId+Naming.PREFIX_SEP));
			formula = "c__atp + c__adp";
			AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "adp_tot"), "mole_per_m3", formula.replaceAll("c__", cId+Naming.PREFIX_SEP));
			formula = "c__utp + c__udp + c__udpglc + c__udpgal";
			AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "udp_tot"), "mole_per_m3", formula.replaceAll("c__", cId+Naming.PREFIX_SEP));
			formula = "3*c__atp + 2*c__adp + 3*c__utp + 2*c__udp + c__phos + 2*c__ppi + c__glc1p + c__glc6p + c__gal1p + 2* c__udpglc + 2*c__udpgal";
			AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "phos_tot"), "mole_per_m3", formula.replaceAll("c__", cId+Naming.PREFIX_SEP));
			
			if (c>1){
				createGlobal = false;
		    }
		
			// Create the localized reactions in the cells
			GalactoseReactionFactory.createLocalizedGALK(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedIMP(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedATPS(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedALDR(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedNADPR(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedGALT(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedGALE(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedUGP(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedPPASE(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedNDKU(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedPGM1(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedGLY(model, cId, createGlobal);
			GalactoseReactionFactory.createLocalizedGTF(model, cId, createGlobal);
			
			// Create the transporters
			for (int kf=1; kf<=Nf; kf++){
				if (kf > 1){ createGlobal = false; }
				
				String cFrom = Naming.getDisseId( (c-1)*Nf + kf);
				String cTo = Naming.getCellId(c);
				GalactoseTransporterFactory.createLocalizedGLUT2(model, cFrom, cTo, createGlobal);	
				if (em.getModelType() != ModelType.GalactoseCell){
					GalactoseTransporterFactory.createLocalizedH2OT(model, cFrom, cTo, createGlobal);
				}
			}
			
			// Make assignment rule for the summation
			String formula_H2OTM = "";
			String formula_GLUT2_GAL = "";
			String formula_GLUT2_GALM = "";
			for (int kf = 1; kf <= Nf; kf++){
				String prefix = "+";
				if (kf == 1){
					prefix = "";
				}
				formula_H2OTM += prefix + Naming.getDisseId( (c-1)*Nf + kf) + "__" +"H2OTM";
				formula_GLUT2_GAL += prefix + Naming.getDisseId( (c-1)*Nf + kf) + "__" +"GLUT2_GAL";
				formula_GLUT2_GALM += prefix + Naming.getDisseId( (c-1)*Nf + kf) + "__" +"GLUT2_GALM";
			}
			if (em.getModelType() != ModelType.GalactoseCell){
				AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "H2OTM"), "mole_per_m3", formula_H2OTM);
				AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "GLUT2_GAL"),  "mole_per_m3", formula_GLUT2_GAL);
				AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "GLUT2_GALM"), "mole_per_m3", formula_GLUT2_GALM);
			} else {
				AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "GLUT2_GAL"),  "mole_per_m3", formula_GLUT2_GAL);
			}
		}
	}
	
	
	/** 
	 * Minimal multiple indicator dilution curve model.
	 * @param model
	 * @throws ParseException
	 */
	private void createMultipleIndicatorCellModels(Model model) throws ParseException{
		// Create cell compartment 1, ..., Nc
		for (int c=1; c<=Nc; c++){
			// Create the species
			CompartmentFactory.createCompartment(model, Naming.getCellId(c), Naming.getCellName(c), 3, "m3");
			CompartmentFactory.createInitialAssignmentsForCompartment(model, Naming.getCellId(c), "m3", "Vol_cell");
		}
		
		// Create global cell parameters
		ParameterFactory.createParameter(model, "scale_f = 10E-15;  % [-]");
		AssignmentFactory.createInitialAssignment(model, "scale", Kind.DIMENSIONLESS.getName(), "scale_f");
		ParameterFactory.createParameter(model, "REF_P = 1;        % [mM]");
		
		// Create the information for all the Nc cells
		boolean createGlobal = true;	// global parameters have to be generated once
		for (int c=1; c<=Nc; c++){
			String cId = Naming.getCellId(c);
							
			// Create species
			for (int k=0; k<cm.getIdsCount(); k++){
				String mId = cm.getSpeciesId(k);
				String mName = cm.getSpeciesName(k);
				Double sInit = cm.getSpeciesInit(k);
				String locId = Naming.createLocalizedId(cId, mId);
				SpeciesFactory.createSpecies(model, locId, mName, cId, sInit, "mole_per_m3", SpeciesFactory.InitType.CONCENTRATION);
			}
			
			if (c>1){
				createGlobal = false;
		    }
			
			// Create the transporters
			for (int kf=1; kf<=Nf; kf++){
				if (kf > 1){ createGlobal = false; }
				
				String cFrom = Naming.getDisseId( (c-1)*Nf + kf);
				String cTo = Naming.getCellId(c);
				GalactoseTransporterFactory.createLocalizedH2OT(model, cFrom, cTo, createGlobal);	
			}
			
			// Make assignment rule for the summation
			String formula_H2OTM = "";
			for (int kf = 1; kf <= Nf; kf++){
				String prefix = "+";
				if (kf == 1){
					prefix = "";
				}
				formula_H2OTM += prefix + Naming.getDisseId( (c-1)*Nf + kf) + "__" +"H2OTM";
			}
			AssignmentFactory.createInitialAssignment(model, Naming.createLocalizedId(cId, "H2OTM"), "mole_per_m3", formula_H2OTM);
		}
	}
	
	/** Sets the PP boundary conditions. 
	 * 	model.getSpecies("PP__rbcM").setBoundaryCondition(true);
	 */
	private void createBoundaryConditions(Model model){
		if (em.getModelType() == ModelType.GalactoseCell){
			return;
		}
		// Set constant in periportal
		String[] ids = em.getSpeciesIds();
		for (String id: ids){
			String sId = Naming.getPeriportalId() + "__" + id;
			model.getSpecies(sId).setBoundaryCondition(true);
		}
	}
	
}
