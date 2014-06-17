package model.events;

import java.io.FileNotFoundException;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;

import javax.xml.stream.XMLStreamException;

import model.SBMLUtils;

import org.sbml.jsbml.ASTNode;
import org.sbml.jsbml.Event;
import org.sbml.jsbml.Model;
import org.sbml.jsbml.SBMLDocument;
import org.sbml.jsbml.SBMLException;
import org.sbml.jsbml.SBMLWriter;
import org.sbml.jsbml.Trigger;
import org.sbml.jsbml.text.parser.ParseException;

/**
 * Handeling of model events for the model.
 *
 * @author Matthias Koenig
 * @date 2014-04-19
 */

public class EventFactory {
	
	/** Creates the events based on the given EventData. 
	 * @throws ParseException */
	public static void createEventsInModel(Collection<EventData> eDataCol, Model model) throws ParseException{
		for (EventData eData: eDataCol){
			createEventInModelFromEventData(eData, model);
		}
	}
	 
	private static Event createEventInModelFromEventData(EventData eData, Model model) throws ParseException{
		Event e = model.createEvent(eData.getId());
		
		e.setName(eData.getName());
		e.setUseValuesFromTriggerTime(true);
		Trigger t = e.createTrigger(true, true);
		t.setMath(ASTNode.parseFormula(eData.getTrigger()));
		HashMap<String, String> assignments = eData.getAssignments();
		for (String key : assignments.keySet()){
			String a = assignments.get(key);
			e.createEventAssignment(key, ASTNode.parseFormula(a));	
		}
		return e;
	}
	
	/** Creates a dilution peak in the periportal components.
	 * The peak area is normalized to 1, i.e height = 1/duration.
	 * Returns the EventData for the dilution peak.
	 * TODO: some testing and quality checking of components
	 */
	public static Collection<EventData> createDilutionPeakEventData(Double tstart, Double duration){
		Double tend = (tstart + duration);
		Double p = 1.0/duration;
		String[] compounds = {"PP__gal", "PP__rbcM", "PP__alb", "PP__h2oM", "PP__suc"};
		Double[] peak = {p, p, p, p, p};
		Double[] background = {0.0, 0.0, 0.0, 0.0, 0.0};
		
		return createPeakEventData(tstart, tend, compounds, peak, background);
	}
	
	public static Collection<EventData> createPeakEventData(Double tstart, Double tend, String[] compounds, 
					Double[] peak, Double[] background){
		Collection<EventData> eDataCol = new LinkedList<EventData>();

		// Create peak events
		HashMap<String, String> aPre = new HashMap<String, String>();
		HashMap<String, String> aPeak = new HashMap<String, String>();
		HashMap<String, String> aPost = new HashMap<String, String>();
		for (int k=0; k<compounds.length; ++k){
			aPre.put(compounds[k], background[k].toString());
			aPeak.put(compounds[k], peak[k].toString());
			aPost.put(compounds[k], background[k].toString());
		}
		EventData eD0 = new EventData("EDIL_0", "pre Dilution Peak [PP]",
				   createTimeString(0.0), aPre);
		eDataCol.add(eD0);
		EventData eD1 = new EventData("EDIL_1", "Dilution Peak [PP]",
									   createTimeString(tstart), aPeak);
		eDataCol.add(eD1);
		EventData eD2 = new EventData("EDIL_2", "post Dilution Peak [PP]",
						createTimeString(tend), aPost);
		eDataCol.add(eD2);
		return eDataCol;
	}
	
	private static String createTimeString(Double time){
		return String.format("(time >= %f)", time);
	}
	
	
	public static void main(String[] args) throws ParseException, SBMLException, XMLStreamException, FileNotFoundException{
		
		Model model = new Model(SBMLUtils.SBML_LEVEL, SBMLUtils.SBML_VERSION);	
		model.createSpecies("PP__gal");
		model.createSpecies("PP__rbcM");
		model.createSpecies("PP__alb");
		model.createSpecies("PP__h2oM");
		model.createSpecies("PP__suc");
		
		Collection<EventData> eDataCol = createDilutionPeakEventData(10.0, 0.5);
		createEventsInModel(eDataCol, model);
		
		SBMLDocument doc = new SBMLDocument(SBMLUtils.SBML_LEVEL, SBMLUtils.SBML_VERSION);
		doc.setModel(model);
		(new SBMLWriter()).write(doc, System.out);
		(new SBMLWriter()).write(doc, "testEvents.xml");
	}
	
}
