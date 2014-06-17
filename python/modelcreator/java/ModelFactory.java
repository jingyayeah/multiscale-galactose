package core;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Collection;

import javax.xml.stream.XMLStreamException;

import org.sbml.jsbml.Model;
import org.sbml.jsbml.SBMLException;
import org.sbml.jsbml.text.parser.ParseException;

import model.CellModel;
import model.CellModelFactory;
import model.ExternalModel;
import model.ExternalModelFactory;
import model.ModelCreator;
import model.ModelCreator.ModelType;
import model.SBMLUtils;
import model.SinusoidModelPars;
import model.events.EventData;
import model.events.EventFactory;

/** Basic model generation class. 
 * Here the core models for DilutionIndicator studies and the galactose variations are
 * created.
 * 
 *	@author: Matthias Koenig
 *  @date: 2015-06-26  
 */
public class ModelFactory {
	public static final String RESULTS_FOLDER="/home/mkoenig/multiscale-galactose-results/tmp_sbml"; 
	private String resultsDirectory;
	
	
	
	public ModelFactory(String dir){
		resultsDirectory = dir;
	}

	/** Core model to calculate the dilution curves by Goresky et. Villeneuve.
	 * For the calculation a tracer peak of the external components is added at time 10.0 with the
	 * duration of peak time. 
	 * Various models with varying peak times are initialized. 
	 * For model simplification (run times) the internal cell models are reduced to the reactions and
	 * components influencing the multiple indicator dilution curves, namely the exchange of water. 
	 */
	public void createMultipleIndicatorModels(ModelType definedModel) throws SBMLException, ParseException, XMLStreamException, IOException{
		final int VERSION = 21;
		Double peakStart = 10.0;
		Double[] peakDuration = {0.5, 0.75, 1.0};
		int[] cells = {20};
		
		for (int kp=0; kp<peakDuration.length; ++kp){
			Double duration = peakDuration[kp];
			Collection<EventData> eDataCol = EventFactory.createDilutionPeakEventData(peakStart, duration);
			for (int Nc: cells){			
				String name = String.format("%s_P%02d", definedModel, kp);
				SinusoidModelPars pars = new SinusoidModelPars(name, VERSION, Nc, 1);
				CellModel cellModel = CellModelFactory.createCellModel(definedModel);
				ExternalModel extModel = ExternalModelFactory.createExternalModel(definedModel);

				System.out.println("Create Model: " + pars.getId());
	
				ModelCreator modelCreator = new ModelCreator(pars, extModel, cellModel, eDataCol);
				Model model = modelCreator.getModel();
				writeModel(model);
			}
		}
	}
	
	/**
	 * Master function to create models based on the given model type.
	 * The model differences are defined in the CellModel and ExternalModel classes
	 * for the respective model types.
	 */
	public void createModelsFromModelType(ModelType mtype, int[] cells) throws SBMLException, ParseException, XMLStreamException, IOException{
		final int VERSION = 21;
		for (int Nc: cells){
				SinusoidModelPars pars = new SinusoidModelPars(mtype.toString(), VERSION, Nc, 1);
				CellModel cellModel = CellModelFactory.createCellModel(mtype);
				ExternalModel extModel = ExternalModelFactory.createExternalModel(mtype);
				ModelCreator modelCreator = new ModelCreator(pars, extModel, cellModel);
				Model model = modelCreator.getModel();
				writeModel(model);
		}
	}
	
	/** Creates the Galactose models. */
	public void createGalactoseModels() throws SBMLException, ParseException, XMLStreamException, IOException{
		ModelType mtype = ModelType.Galactose;
		int[] cells = {1, 20};
		createModelsFromModelType(mtype, cells);
	}
	
	/** Creates the complete galactose models. */
	public void createGalactoseCompleteModels() throws SBMLException, ParseException, XMLStreamException, IOException{
		ModelType mtype = ModelType.GalactoseComplete;
		int[] cells = {1, 20};
		createModelsFromModelType(mtype, cells);
	}
	
	public void createGalactoseCellModel() throws SBMLException, ParseException, XMLStreamException, IOException{
		ModelType mtype = ModelType.GalactoseCell;
		int[] cells = {1};
		createModelsFromModelType(mtype, cells);
	}
	
	private void writeModel(Model model) throws SBMLException, FileNotFoundException, XMLStreamException{
		String fname = SBMLUtils.createSBMLFilenameForModelId(model.getId(), resultsDirectory);
		SBMLUtils.writeModelToSBML(model, fname);
	}
	
	public static void main(String[] args) throws SBMLException, ParseException, XMLStreamException, IOException{
		ModelFactory fac = new ModelFactory(RESULTS_FOLDER);
		 
		/* MultipleIndicator models */
		fac.createMultipleIndicatorModels(ModelType.MultipleIndicator);
		fac.createMultipleIndicatorModels(ModelType.GalactoseComplete);	
		/* Create the galactose steady state models */
		fac.createGalactoseModels();
		
		/* Create the galactose steady state models */
		fac.createGalactoseCompleteModels();
		
		/* Create the reduced model which only consists of space of disse and cells */
		// fac.createGalactoseCellModel();
	}
}
