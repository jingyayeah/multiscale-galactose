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
#include "ModelParameters.h"
#include "TimeCourseParameters.h"

/**
 * Main things to do are:
 * 	- [DONE] take a model file and convert it to Copasi format
 * 	- [DONE] change parameters in the model (galactose, blood flow)
 * 	- [DONE] perform time course simulations -> report
 * 	- [DONE] store data in files with SBML identifiers
 * 	- [DONE] read the data into Matlab for analysis.
 */

int main()
{
	std::cout << "CopasiModelRunner::main()\n";
	// std::string filename = "./results/Galactose_v3_Nc1_Nf5.xml";

	/** Galactose Peak studies */
	//std::string filename = "/home/mkoenig/multiscale-galactose-results/Galactose_v3_Nc1_Nf5.xml";
	//std::string filename = "/home/mkoenig/multiscale-galactose-results/Galactose_v3_Nc5_Nf5.xml";

	/** Dilution indicator studies */
	std::string filename = "/home/mkoenig/multiscale-galactose-results/Galactose_Dilution_v3_Nc5_Nf5.xml";
	std::string fnameCPS = filename.substr(0, filename.size()-3) + "cps";

	//m.test();
	//m.SBML2CPS(filename, fnameCPS);
	ModelSimulator m = ModelSimulator(filename);

	//TimeCourseParameters tcPars = TimeCourseParameters(0.0, 3000.0, 500, 1.0E-6, 1.0E-6);
	// read from integration
	TimeCourseParameters intOptions = TimeCourseParameters(0.0, 240.0, 960, 1.0E-6, 1.0E-6);

	//TODO: create a list object of parameters,
	// 		the initial concentrations are changed based on the names in the integration


	std::string simId = "sim1";
	std::cout << simId << std::endl;

	MParameter p1 = MParameter("flow_sin", 60E-6);
	std::cout << "p1 generated" << std::endl;
	MParameter p2 = MParameter("PP__gal", 0.00012);
	std::cout << "p2 generated" << std::endl;

	std::vector<MParameter> pars;
	std::cout << "pars.size() -> " << pars.size() << std::endl;
	pars.push_back(p1);
	std::cout << "p1 added to vector" << std::endl;
	pars.push_back(p2);
	std::cout << "pars.size() -> " << pars.size() << std::endl;

	for (std::vector<MParameter>::iterator it=pars.begin(); it!=pars.end(); ++it)
	    std::cout << (*it).getId() << " = " << (*it).getValue() << std::endl;
	std::cout << '\n';

	std::string reportTarget = "/home/mkoenig/multiscale-galactose-results/" + simId + ".txt";
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
