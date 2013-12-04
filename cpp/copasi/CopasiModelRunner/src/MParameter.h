/*
 * Parameter.h
 *
 *  Created on: Dec 3, 2013
 *      Author: mkoenig
 */

#ifndef MPARAMETER_H_
#define MPARAMETER_H_

#include <string>

class MParameter {
  public:
    MParameter(std::string, double);
    MParameter(const MParameter&);
    // ~Parameter();
    std::string getId() const;
    double getValue() const;

  private:
    std::string id_;
    double value_;
};

#endif /* MPARAMETER_H_ */
