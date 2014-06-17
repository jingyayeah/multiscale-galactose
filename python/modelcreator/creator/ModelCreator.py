
'''
Creates the model from the core data.

Created on Jun 17, 2014
@author: mkoenig
'''
from  libsbml import SBMLDocument, UNIT_KIND_SECOND

SBML_LEVEL = 3;
SBML_VERSION = 1;

mid = 'test.xml'

doc = SBMLDocument(SBML_LEVEL, SBML_VERSION);
model = doc.createModel(mid) 



unitdef = model.createUnitDefinition();
unitdef.setId("per_second");

unit = unitdef.createUnit();
unit.setKind(UNIT_KIND_SECOND);
unit.setExponent(-1);


# use the parse formula
