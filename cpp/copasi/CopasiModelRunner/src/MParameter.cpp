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

MParameter::MParameter(std::string sid, double svalue) {
	id = sid;
	value = svalue;
	std::cout << "Parameter created;" << std::endl;
}

MParameter::MParameter(const MParameter& pref) {
	// allocate variables
	id = pref.id;
	value = pref.value;
}

std::string MParameter::getId() {
	return id;
}

double MParameter::getValue() {
	return value;
}


/*
Parameter::~Parameter(void)
{
    delete id;
    delete value;
}
*/
