#include "TimecourseParameters.h"
#include <iostream>

TimecourseParameters::TimecourseParameters(double t0, double dur, int steps, double rel_tol, double abs_tol)
: t0_(t0), duration_ (dur), steps_(steps), rel_tol_(rel_tol), abs_tol_(abs_tol)
{}

double TimecourseParameters::getInitialTime() const{
	return t0_;
}
double TimecourseParameters::getDuration() const{
	return duration_;
}
int TimecourseParameters::getSteps() const{
	return steps_;
}
double TimecourseParameters::getRelTol() const{
	return rel_tol_;
}
double TimecourseParameters::getAbsTol() const{
	return abs_tol_;
}
void TimecourseParameters::print() const{
	std::cout << t0_ << "|" << duration_ << "|" << steps_ << "|" << rel_tol_
			  << "|" << abs_tol_ << std::endl;
}
