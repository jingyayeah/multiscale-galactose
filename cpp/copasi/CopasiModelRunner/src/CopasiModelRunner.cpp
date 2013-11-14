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
#include <set>


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
#include "ModelParameters.h"
#include "TimeCourseParameters.h"

/**
 * Main things to do are:
 * 	- [DONE] take a model file and convert it to Copasi format
 * 	- [DONE] change parameters in the model (galactose, blood flow)
 * 	- [DONE] perform time course simulations -> report
 * 	- [DONE] store data in files with SBML identifiers
 * 	- read the data into Matlab for analysis.
 * 	TODO: only read the file once; and than perform the simulation
 * 			with different settings;
 */

int main()
{
	std::cout << "Running CopasiModelRunner\n";
	// std::string filename = "./results/Galactose_v3_Nc1_Nf5.xml";
	std::string filename = "/home/mkoenig/multiscale-galactose-results/Galactose_v3_Nc1_Nf5.xml";
	std::string fnameCPS = filename.substr(0, filename.size()-3) + "cps";

	double flow = 60E-6;	// [m]
	double gal  = 0.00012;	// [m]

	const int Nflow = 11;
	double flows[Nflow]= {0.0E-6, 20E-6, 40.0E-6, 60.0E-6, 80.0E-6, 100E-6,
						120E-6, 140E-6, 160E-6, 180E-6, 200.0E-6};
	const int Ngal = 7;
	double gals[Ngal]= {0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0};

	//m.test();
	//m.SBML2CPS(filename, fnameCPS);
	ModelSimulator m = ModelSimulator(filename);
	TimeCourseParameters tcPars = TimeCourseParameters(0.0, 3000.0, 500, 1.0E-6, 1.0E-6);

	// Do the simulations for the different settings
	int counter = 1;
	for (int kf=0; kf<Nflow; ++kf){
		flow = flows[kf];
		for (int kg=0; kg<Ngal; ++kg){
			std::cout << "[" << 100.0*counter/(Nflow*Ngal) << "]";
			gal = gals[kg];
			ModelParameters mPars = ModelParameters(gal, flow);
			m.doTimeCourseSimulation(mPars, tcPars);
			counter ++;
		}
	}
	return 0;
}
