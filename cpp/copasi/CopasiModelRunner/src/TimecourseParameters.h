/*
 * TimeCourseParameters.h
 *
 *  Created on: Nov 14, 2013
 *      Author: mkoenig
 */

#ifndef TIMECOURSEPARAMETERS_H_
#define TIMECOURSEPARAMETERS_H_


class TimecourseParameters {
  public:
	/** Create TimeCourseParameters t0, dur, steps, rTol, aTol. */
    TimecourseParameters(double, double, int, double, double);

    double getInitialTime() const;
    double getDuration() const;
    int getSteps() const;
    double getRelTol() const;
    double getAbsTol() const;

  private:
    double t0_;
    double duration_;
    int steps_;
    double rel_tol_;
    double abs_tol_;
};


#endif /* TIMECOURSEPARAMETERS_H_ */
