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
 * 	TODO: read input arguments (sbml file and parameter file)
 */

#include <boost/program_options/options_description.hpp>
#include <boost/program_options/parsers.hpp>
#include <boost/program_options/variables_map.hpp>

namespace po = boost::program_options;

int main(int argc, const char* argv[])
{
	////////////////////////////////////////////////////////
	std::string author = "Matthias Koenig";
	std::string version = "0.1";
	////////////////////////////////////////////////////////

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
	        std::cout << "SBML file: " << vm["sbml"].as<std::string>() << std::endl;
	    } else {
	    	std::cout << "SBML file missing" << std::endl;
	    	std::cout << description;
	    	return 0;
	    }

	    if(vm.count("pars")){
	        std::cout << "Parameter file: " << vm["pars"].as<std::string>() << std::endl;
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

	// Load information from provided files

	std::cout << "CopasiModelRunner::main()\n";

	/** Dilution indicator studies - Model to integrate */
	//std::string filename = "/home/mkoenig/multiscale-galactose-results/Dilution_Curves_v4_Nc1_Nf1.xml";
	std::string filename = "/home/mkoenig/multiscale-galactose-results/Dilution_Curves_v4_Nc20_Nf1.xml";
	std::string fnameCPS = filename.substr(0, filename.size()-3) + "cps";

	// Create the vector of parameters to set
	// when to init with new ?
	// what is the difference between MParameter() and new MParameter
	MParameter p1 ("flow_sin", 60E-6);
	std::cout << "p1 generated" << std::endl;
	MParameter p2 ("PP__gal", 0.00012);
	std::cout << "p2 generated" << std::endl;

	std::vector<MParameter> pars;
	std::cout << "pars.size() -> " << pars.size() << std::endl;
	pars.push_back(p1);
	std::cout << "p1 added to vector" << std::endl;
	pars.push_back(p2);
	std::cout << "pars.size() -> " << pars.size() << std::endl;

	for (std::vector<MParameter>::const_iterator it=pars.begin(); it!=pars.end(); ++it){
	    std::cout << (*it).getId() << " = " << (*it).getValue() << std::endl;
	    std::cout << '\n';
	}


	//m.test();
	//m.SBML2CPS(filename, fnameCPS);
	// Create a new ModelSimulator for the file
	ModelSimulator m (filename);

	// Create TimeCourseParameters t0, dur, steps, rTol, aTol
	TimecourseParameters intOptions (0.0, 100.0, 1000, 1.0E-6, 1.0E-6);

	//TODO: create a list object of parameters,
	// 		the initial concentrations are changed based on the names in the integration

	std::string simId = "sim2";
	std::cout << simId << std::endl;



	std::string reportTarget = "/home/mkoenig/multiscale-galactose-results/" + simId + "._copasiSE.csv";
	m.doTimeCourseSimulation(pars, intOptions, reportTarget);


	/*
	double flow = 60E-6;	// [m]
	double gal  = 0.00012;	// [m]
	//const int Nflow = 11;
	//double flows[Nflow]= {0.0E-6, 20E-6, 40.0E-6, 60.0E-6, 80.0E-6, 100E-6,
	//					120E-6, 140E-6, 160E-6, 180E-6, 200.0E-6};
	const int Nflow = 5;
	double flows[Nflow]= {0.0E-6, 30E-6, 60.0E-6, 90E-6, 120E-6};

	//const int Ngal = 7;
	// double gals[Ngal]= {0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
	const int Ngal = 5;
	double gals[Ngal]= {0, 1.0, 2.0, 4.0 , 6.0};


	int counter = 1;
	for (int kf=0; kf<Nflow; ++kf){
		flow = flows[kf];
		ModelParameters mPars = ModelParameters(0.00012, flow);
		m.doTimeCourseSimulation(mPars, tcPars);
	}
	*/


	// Do the simulations for the different settings
	// Galactose Peak
	/*
	int counter = 1;
	for (int kf=0; kf<Nflow; ++kf){
		flow = flows[kf];
		for (int kg=0; kg<Ngal; ++kg){

			std::cout << "[" << 100.0*counter/(Nflow*Ngal) << "]";
			gal = gals[kg];
			ModelParameters mPars = ModelParameters(gal, flow);
			m.doTimeCourseSimulation(mPars, tcPars);
			counter ++;;
		}
	}
	*/
	//m.destroy();
	return 0;
}
