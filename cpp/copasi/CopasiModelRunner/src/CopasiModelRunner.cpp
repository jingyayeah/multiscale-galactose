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

/**
 * Main things to do are:
 * 	- [DONE] take a model file and convert it to Copasi format
 * 	- change parameters in the model (galactose, blood flow)
 * 	- [DONE] perform time course simulations -> report
 * 	- [DONE] store data in files with SBML identifiers
 * 	- read the data into Matlab for analysis.
 */

int main()
{
	std::cout << "Running CopasiModelRunner\n";
	// std::string filename = "./results/Galactose_v3_Nc1_Nf5.xml";
	std::string filename = "/home/mkoenig/multiscale-galactose/cpp/copasi/CopasiModelRunner/results/Galactose_v3_Nc1_Nf5.xml";
	std::string fnameCPS = filename.substr(0, filename.size()-3) + "cps";

	ModelSimulator m = ModelSimulator(filename);
	double flow = 60E-6;	// [m]
	double gal  = 2.0;	// [m]
	ModelParameters mPars = ModelParameters(gal, flow);

	//m.test();
	//m.SBML2CPS(filename, fnameCPS);

	m.doTimeCourseSimulation(filename, mPars);


	return 0;
}
