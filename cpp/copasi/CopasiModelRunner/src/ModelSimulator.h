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

class ModelSimulator {
  public:
    ModelSimulator(std::string filename);
    void modelInfo(CCopasiDataModel* pDataModel);
    int doSimulation(std::string filename);
    int SBML2CPS(std::string fnameSBML, std::string fnameCPS);
    int test();

  private:
    std::string filename;
};

#endif /* MODELSIMULATOR_H_ */
