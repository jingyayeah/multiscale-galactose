/*
 * ModelSimulator.h
 *
 *  Created on: Nov 13, 2013
 *      Author: mkoenig
 */

#ifndef MODELSIMULATOR_H_
#define MODELSIMULATOR_H_

#include <iostream>
#include <string>
#include "ModelParameters.h"
#include "TimeCourseParameters.h"

class ModelSimulator {
  public:
    ModelSimulator(std::string filename);
    void modelInfo(CCopasiDataModel* pDataModel);
    int readModel();
    int doSimulation(std::string filename);
    int doTimeCourseSimulation(ModelParameters, TimeCourseParameters);
    int SBML2CPS(std::string fnameSBML, std::string fnameCPS);
    int test();
    void destroy();

  private:
    std::string filename;
    CCopasiDataModel* pDataModel;
    int simulationCounter;

};

#endif /* MODELSIMULATOR_H_ */
