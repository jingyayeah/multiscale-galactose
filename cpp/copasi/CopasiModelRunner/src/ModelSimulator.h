/*
 * ModelSimulator.h
 *
 *  Created on: Nov 13, 2013
 *      Author: mkoenig
 */

#ifndef MODELSIMULATOR_H_
#define MODELSIMULATOR_H_

#include <string>
#include <vector>
#include "MParameter.h"
#include "TimecourseParameters.h"

class ModelSimulator {
  public:
    ModelSimulator(std::string filename);
    void modelInfo(CCopasiDataModel* pDataModel);
    int readModel();
    int doSimulation(std::string filename);
    int doTimeCourseSimulation(const std::vector<MParameter> &, const TimecourseParameters &, const std::string &);
    int SBML2CPS(std::string fnameSBML, std::string fnameCPS);
    int test();
    void destroy();

  private:
    std::string filename;
    //CCopasiDataModel* pDataModel;
    int simulationCounter;

};

#endif /* MODELSIMULATOR_H_ */
