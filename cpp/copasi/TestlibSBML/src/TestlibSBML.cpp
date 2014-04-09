//============================================================================
// Name        : TestlibSBML.cpp
// Author      : 
// Version     :
// Copyright   : 
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <sbml/SBMLTypes.h>

using namespace std;

int main() {
	SBMLDocument doc(3,1);
	Species* species = doc.createModel()->createSpecies();
	  species->setName("glc");
	  species->setInitialAmount(1.2);
	  cout << species->getInitialAmount() << endl;
	  cout << writeSBMLToString(&doc) << endl;
}
