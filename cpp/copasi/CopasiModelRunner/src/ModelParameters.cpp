/*
 * ModelParameters.cpp
 *
 *  Created on: Nov 13, 2013
 *      Author: mkoenig
 */

#include "ModelParameters.h"

    ModelParameters::ModelParameters(double gal, double f){
    	ppGalactose = gal;
    	flow = f;
    }

    double ModelParameters::getPPGalactose(){
    	return ppGalactose;
    }

    double ModelParameters::getFlow(){
    	return flow;
    }


