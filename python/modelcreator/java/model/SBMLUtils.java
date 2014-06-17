package model;

import java.io.FileNotFoundException;

import javax.xml.stream.XMLStreamException;

import org.sbml.jsbml.Model;
import org.sbml.jsbml.SBMLDocument;
import org.sbml.jsbml.SBMLException;
import org.sbml.jsbml.SBMLWriter;

public class SBMLUtils {
	public final static int SBML_LEVEL = 3;
	public final static int SBML_VERSION = 1;
	
	public static String createSBMLFilenameForModelId(String modelId, String folder){
		return folder + "/" + modelId + ".xml";
	}
	
	public static SBMLDocument createSBMLDocument(Model model){
		SBMLDocument doc = new SBMLDocument(SBML_LEVEL, SBML_VERSION);
		doc.setModel(model);
		return doc;
	}
	
	public static void writeModelToSBML(Model model, String filename) throws SBMLException, FileNotFoundException, XMLStreamException{
		SBMLDocument doc = createSBMLDocument(model);
		SBMLWriter.write(doc, filename, (char) ' ',(short) 2);
		System.out.println("SBML written by ModelCreator: " + filename);
	}
	

	
}
