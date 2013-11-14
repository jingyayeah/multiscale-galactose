/*
 * TimeCourseParameters.h
 *
 *  Created on: Nov 14, 2013
 *      Author: mkoenig
 */

#ifndef TIMECOURSEPARAMETERS_H_
#define TIMECOURSEPARAMETERS_H_


class TimeCourseParameters {
  public:
	/** Create TimeCourseParameters t0, dur, steps, rTol, aTol. */
    TimeCourseParameters(double, double, int, double, double);
    double getInitialTime();
    double getDuration();
    int getStepNumber();
    double getRelTol();
    double getAbsTol();

  private:
    double initialTime;
    double duration;
    int stepNumber;
    double relTol;
    double absTol;
};


#endif /* TIMECOURSEPARAMETERS_H_ */
