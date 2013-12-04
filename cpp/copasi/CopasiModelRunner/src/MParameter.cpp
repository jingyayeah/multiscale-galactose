/*
 * Parameter.cpp
 *
 *  Created on: Dec 3, 2013
 *      Author: mkoenig
 *
 *  The type of the elements must fulfill
 *  	CopyConstructible
 *  and
 *  	Assignable
 *  requirements.
 *
 */

#include <string>
#include <iostream>
#include "MParameter.h"

MParameter::MParameter(std::string id, double value)
: id_(id), value_(value)
{}

MParameter::MParameter(const MParameter& p)
: id_(p.id_), value_(p.value_)
{}

std::string MParameter::getId() const{
	return id_;
}

double MParameter::getValue() const{
	return value_;
}

