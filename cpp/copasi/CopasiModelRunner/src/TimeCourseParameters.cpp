/*
 * TimeCourseParameters.cpp
 *
 *  Created on: Nov 14, 2013
 *      Author: mkoenig
 */

#include "TimeCourseParameters.h"


TimeCourseParameters::TimeCourseParameters(double t0, double dur, int steps, double rTol, double aTol){
	initialTime = t0;
	duration = dur;
	stepNumber = steps;
	relTol = rTol;
	absTol = aTol;
}

double TimeCourseParameters::getInitialTime(){
	return initialTime;
}
double TimeCourseParameters::getDuration(){
	return duration;
}
int TimeCourseParameters::getStepNumber(){
	return stepNumber;
}
double TimeCourseParameters::getRelTol(){
	return relTol;
}
double TimeCourseParameters::getAbsTol(){
	return absTol;
}


