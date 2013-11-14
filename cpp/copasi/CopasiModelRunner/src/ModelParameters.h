/*
 * ModelParameters.h
 *
 *  Created on: Nov 13, 2013
 *      Author: mkoenig
 */

#ifndef MODELPARAMETERS_H_
#define MODELPARAMETERS_H_

#include <iostream>
#include <string>

class ModelParameters {
  public:
    ModelParameters(double, double);
    double getPPGalactose();
    double getFlow();

  private:
    double ppGalactose;
    double flow;
};

#endif /* MODELPARAMETERS_H_ */
