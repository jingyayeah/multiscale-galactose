// Copyright (C) 2010 - 2013 by Pedro Mendes, Virginia Tech Intellectual
// Properties, Inc., University of Heidelberg, and The University
// of Manchester.
// All rights reserved.

// Copyright (C) 2009 by Pedro Mendes, Virginia Tech Intellectual
// Properties, Inc., EML Research, gGmbH, University of Heidelberg,
// and The University of Manchester.
// All rights reserved.

/**
 * This is an example on how to build models with the COPASI backend API.
 */
#include <iostream>
#include <vector>
#include <string>
#include <list>

#define COPASI_MAIN

#include "copasi/copasi.h"
#include "copasi/report/CCopasiRootContainer.h"
#include "copasi/CopasiDataModel/CCopasiDataModel.h"
#include "copasi/model/CModel.h"
#include "copasi/model/CCompartment.h"
#include "copasi/model/CMetab.h"
#include "copasi/model/CReaction.h"
#include "copasi/model/CChemEq.h"
#include "copasi/model/CModelValue.h"
#include "copasi/function/CFunctionDB.h"
#include "copasi/function/CFunction.h"
#include "copasi/function/CEvaluationTree.h"

#include "ModelSimulator.h"
#include "MParameter.h"
#include "TimecourseParameters.h"

/**
 * Main function called with arguments.
 * ./CopasiModelRunner -sbml sbml_file -parameters pars_file
 *
 * The parameters are set in the model and the integration performed.
 *
 * Main things to do are:
 * 	- take a model file and convert it to Copasi format
 * 	- change parameters in the model (galactose, blood flow)
 * 	- perform time course simulations
 * 	- create report of integration & store data in files with SBML identifiers
 * 	- read the data into Matlab for analysis
 *
 * 	TODO: create a makefile
 *
 *  Dilution indicator studies - Model to integrate
 *	std::string filename = "/home/mkoenig/multiscale-galactose-results/Dilution_Curves_v4_Nc1_Nf1.xml";
 *	std::string filename = "/home/mkoenig/multiscale-galactose-results/Dilution_Curves_v4_Nc20_Nf1.xml";
 */

#include <boost/program_options/options_description.hpp>
#include <boost/program_options/parsers.hpp>
#include <boost/program_options/variables_map.hpp>
#include <iostream>
#include <string>
#include <set>
#include <sstream>
#include <exception>
#include <fstream>

#include <boost/config.hpp>
#include <boost/program_options/detail/config_file.hpp>
#include <boost/program_options/parsers.hpp>
namespace po = boost::program_options;
namespace pod = boost::program_options::detail;

/** Reads the config file which contains the settings for the
 * integration timecourse and the parameters which have to be set before
 * integration.
 */
std::map<std::string, std::string> parseConfigFile(std::string filename) {
	std::ifstream config(filename.c_str());
	//parameters
	std::set<std::string> options;
	std::map<std::string, std::string> parameters;
	options.insert("*");
	try {
		for (pod::config_file_iterator i(config, options), e; i != e; ++i) {
			std::cout << i->string_key << " = " << i->value[0] << std::endl;
			parameters[i->string_key] = i->value[0];
		}
		std::cout << parameters["StatLogServer.Path"] << std::endl;
	} catch (std::exception& e) {
		std::cerr << "Exception: " << e.what() << std::endl;
	}
	return parameters;
}


/** Parse the Timecourse Parameters from the settings file. */
TimecourseParameters createTimecourseParametersFromMap(std::map<std::string, std::string> map){
	double t0, dur, rTol, aTol;
	int steps;
	// Check if all the necessary values are in the map
	if( 	(map.find("Timecourse.t0") != map.end() ) &&
			(map.find("Timecourse.dur") != map.end()) &&
			(map.find("Timecourse.steps") != map.end()) &&
			(map.find("Timecourse.rTol") != map.end()) &&
			(map.find("Timecourse.aTol") != map.end()) ){
		t0 = atof(map["Timecourse.t0"].c_str());
		dur = atof(map["Timecourse.dur"].c_str());
		steps = atoi(map["Timecourse.steps"].c_str());
		rTol = atof(map["Timecourse.rTol"].c_str());
		aTol = atof(map["Timecourse.aTol"].c_str());
	}
	TimecourseParameters tcp (t0, dur, steps, rTol, aTol);
	tcp.print();
	return tcp;
}

/* Create the parameter vector from the parameter file.
 *
 * TODO: read information from parameter file
 * TODO: create a list object of parameters,
 * 		the initial concentrations are changed based on the names in the integration
 * TODO: use a HashMap to get the parameters by name
 */
std::vector<MParameter> createParametersFromMap(std::map<std::string, std::string> map){
	// [see	http://sektorgaza.blogspot.de/2007/08/how-to-parse-ini-files-with-boost.html]
	std::vector<MParameter> pars;

	// Iterate over the map
	std::map<std::string, std::string>::iterator iter;
	std::string key;
	for (iter = map.begin(); iter != map.end(); ++iter) {
		key = iter->first;
		// Check if startswith 'Parameters.'
		if (key.find("Parameters.") != std::string::npos) {
			std::string short_key = key.substr(key.find("Parameters."), key.length());
			std::cout << short_key << " <- " << key << std::endl;
			MParameter p (short_key, atof(map[key].c_str()));
			pars.push_back(p);
		}

	}


	// when to init with new ?
	// what is the difference between MParameter() and new MParameter
		MParameter p1 ("flow_sin", 60E-6);
		MParameter p2 ("PP__gal", 0.00012);
		pars.push_back(p1);
		pars.push_back(p2);

		for (std::vector<MParameter>::const_iterator it=pars.begin(); it!=pars.end(); ++it){
		    std::cout << (*it).getId() << " = " << (*it).getValue() << std::endl;
		    std::cout << '\n';
		}
		return pars;
}


std::string createSimulationFilenameFromMap(std::map<std::string, std::string> map){
	std::string fname = "sim_test";
	// TODO: generate the filename out of the map



	return fname;
}




std::string createCopasiFilenameFromSBML(std::string sbml_filename){
	std::string cps_filename = sbml_filename.substr(0, sbml_filename.size()-3) + "cps";
	return cps_filename;
}

std::string createSimulationFilename(std::string sbml_filename, std::map<std::string, std::string>){
	// TODO: use unique parameter identifier for simulation
	std::string cps_filename = sbml_filename.substr(0, sbml_filename.size()-3) + "_copasi.csv";
	return cps_filename;
}


/** Read the command line information and run the integration
 * with the parsed information.
 */
int main(int argc, const char* argv[])
{
	std::string author = "Matthias Koenig";
	std::string version = "0.1";
	std::string sbml_filename;
	std::string pars_filename;

	// Read the information from command line option
	 po::options_description description("CopasiModelRunner Usage");

	 description.add_options()
	        ("help,h", "Display this help message")
	        ("sbml,s", po::value<std::string>(), "SBML file")
	        ("pars,p", po::value<std::string>(), "Parameter file")
	        ("version,v", "Display the version number");

	  po::positional_options_description pos;
	   // pos.add("input-files", -1);

	    po::variables_map vm;
	    po::store(po::command_line_parser(argc, argv).options(description).positional(pos).run(), vm);
	    po::notify(vm);

	    // check for options
	    if(vm.count("help")){
	        std::cout << description;
	        std::cout << "CopasiModelRunner Version " << version << std::endl;
	        std::cout << "Author  " << author << std::endl;
	        return 0;
	    }

	    if(vm.count("sbml")){
	    	sbml_filename = vm["sbml"].as<std::string>();
	    	std::cout << "SBML file: " << sbml_filename << std::endl;

	    } else {
	    	std::cout << "SBML file missing" << std::endl;
	    	std::cout << description;
	    	return 0;
	    }

	    if(vm.count("pars")){
	    	pars_filename = vm["pars"].as<std::string>();
	        std::cout << "Parameter file: " << pars_filename << std::endl;
	    } else {
	    	std::cout << "Parameter file missing" << std::endl;
	    	std::cout << description;
	    	return 0;
	    }

	    if(vm.count("version")){
	        std::cout << "CopasiModelRunner Version " << version << std::endl;
	        return 0;
	    }

	////////////////////////////////////////////////////////
	std::cout << "CopasiModelRunner::main()\n";


	std::map<std::string, std::string> map = parseConfigFile(pars_filename);
	TimecourseParameters tcPars = createTimecourseParametersFromMap(map);
	std::vector<MParameter> pars = createParametersFromMap(map);

	std::string cps_filename = createCopasiFilenameFromSBML(sbml_filename);
	std::string report_filename = createSimulationFilename(sbml_filename, map);

	return 0;

	// Create a new ModelSimulator for the file
	// ModelSimulator m (sbml_filename);
	// m.doTimeCourseSimulation(pars, tcPars, report_filename);

	// return 0;
}
