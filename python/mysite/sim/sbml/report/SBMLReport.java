package report;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.xml.stream.XMLStreamException;

import org.apache.commons.io.FileUtils;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.apache.velocity.exception.ParseErrorException;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.apache.velocity.tools.generic.EscapeTool;
import org.sbml.jsbml.Model;
import org.sbml.jsbml.SBMLDocument;
import org.sbml.jsbml.SBMLReader;
import org.sbml.jsbml.UnitDefinition;

import core.ModelFactory;
import annotation.miriam.NamedSBaseInfoFactory;
import equation.EquationTools;

/** Generate an SBML Report which can be used as supplement for the publication. 
 * Necessary to encode all the information pieces in the SBML.
 * 
 * Support the MVC model, view controller separation.
 * 
 * http://wiki.apache.org/velocity/FrontPage
 * 
 * Create html which can be imported in word or converted to PDF.
 * 
 * [1] Use Template language to define the html which is generated.
 * [2] Generate images for the formulas.
 * 
 * Features
 *  # Additional information #
 * 	SBase.notes, SBase.metaId, SBase.sboTerm
 *  Model.substanceUnits, Model.timeUnits, Model.volumeUnits, Model.areaUnits, Model.lengthUnits,
 *  	Model.extentUnits, model.conversionFactor
 *  Reaction.compartment, Reaction.fast
 *  
 * Features to support 
 * TODO: fix the NaNs (initialAssignments vs. Rules !, also fix in the model)
 * TODO: create the database links
 * TODO: handle DIMENSIONLESS in unified way
 * 
 * TODO: fix css navigation bug : wrong links
 * TODO: equations as images
 */
public class SBMLReport {
	private static String TEMPLATE = "sbmlreport.vm";
	private static String VELOCITY_PROPERTIES = "velocity.properties";
	
	private String sbmlFilename;
	private String reportFolder;
	private Model model;
	
	public SBMLReport(String sbmlFile, String reportFolder){
		sbmlFilename = sbmlFile;
		this.reportFolder = reportFolder;
		model = readModel(sbmlFilename);
	}
	
	private static Model readModel(String filename) {
		Model m = null;
		// Read the model
		SBMLReader reader = new SBMLReader();
		SBMLDocument doc;
		try {
			doc = reader.readSBML(filename);
			m = doc.getModel();
		} catch (XMLStreamException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return m;
	}
	
	public String getReportFilename(){
		return reportFolder + "/" + model.getId() + ".html";
	}
	
	public void createReport() throws XMLStreamException, IOException{
		VelocityContext context = createVelocityContextForModel(model);
		renderTemplateWithContext(TEMPLATE, context);
		createReportFiles();
	}
	
	/** Copies the necessary files in the report folder 
	 * @throws IOException */
	private void createReportFiles() throws IOException{
		String[] names = {"report.css", "jquery.js", "jquery.dataTables.js",
				"sbml.gif"};
		
		// css, jQuery.js, jQuery.dataTables.js
		for (String name : names){
			FileUtils.copyFile(new File(name), new File(reportFolder +'/'+ name ));
		}
	}
	
	/** Here the SBML information is packed for the template
	 * language. 
	 * Make a context object and populate with the data.  This
     *  is where the Velocity engine gets the data to resolve the
     *  references (ex. $list) in the template
	 */
	private VelocityContext createVelocityContextForModel(Model model){
        VelocityContext context = new VelocityContext();
        
        // Put the model, all information can be extracted
        context.put("model", model);
        
        // Put the reaction equations in the context
        EquationTools eqtools = new EquationTools();
        context.put("eqtools", eqtools);
          
        // Escape Tool to handle the raw XML information
        EscapeTool esc = new EscapeTool();
        context.put("esc", esc);
          
        // MIRIAM info too
        NamedSBaseInfoFactory fac = new NamedSBaseInfoFactory(null);
        context.put("fac", fac);
        
		return context;
	}
		
	private void renderTemplateWithContext(String templateFile, VelocityContext context){
		try{
			Velocity.init(VELOCITY_PROPERTIES);
            /*
             *  get the Template object.  This is the parsed version of your
             *  template input file.  Note that getTemplate() can throw
             *   ResourceNotFoundException : if it doesn't find the template
             *   ParseErrorException : if there is something wrong with the VTL
             *   Exception : if something else goes wrong (this is generally
             *        indicative of as serious problem...)
             */
            Template template =  null;
            try
            {
                template = Velocity.getTemplate(templateFile);
            }
            catch( ResourceNotFoundException rnfe )
            {
                System.out.println("Example : error : cannot find template " + templateFile );
            }
            catch( ParseErrorException pee )
            {
                System.out.println("Example : Syntax error in template " + templateFile + ":" + pee );
            }

            /* Now have the template engine process your template using the
             *  data placed into the context.  Think of it as a  'merge'
             *  of the template and the data to produce the output stream. */
            String reportFilename = getReportFilename();
            BufferedWriter writer = new BufferedWriter(new FileWriter(reportFilename));
            if ( template != null)
                template.merge(context, writer);

            /* flush and cleanup */
            writer.flush();
            writer.close();
            
        }
        catch( Exception e )
        {
            System.out.println(e);
        }		
	}	
	
	public static void main(String args[]) throws XMLStreamException, IOException{
		// System.setProperty("http.proxyHost", "proxy.charite.de");
		// System.setProperty("http.proxyPort", "888");
		
		// reports are written in the results folder
		String folder = ModelFactory.RESULTS_FOLDER;
		
		String[] modelIds = {"Galactose_Dilution_v4_Nc1_Nf1", "Galactose_Dilution_v4_Nc1_Nf1_annotated"};
		for (String modelId: modelIds){
			String sbmlFileName = folder + modelId + ".xml";
			String reportFolder = folder;
			SBMLReport report = new SBMLReport(sbmlFileName, reportFolder);
			report.createReport();
			System.out.println("SBML report written:" + report.getReportFilename());
		}
	}
}
