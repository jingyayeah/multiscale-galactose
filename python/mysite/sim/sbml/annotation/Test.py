'''
Created on Jun 2, 2014

@author: mkoenig
'''
from libsbml import *

doc = SBMLDocument(3,1)
model = doc.createModel('Test')

s1 = model.createSpecies()
s1.setId('s1')

# ! should at least give a warning, just does nothing
s1.setSBOTerm('11')

# ! should also give a warning, just does nothing
# (based on SBML example)
# http://sbml.org/Software/libSBML/docs/cpp-api/add_c_v_terms_8cpp-example.html !!!
cv1 = CVTerm();
cv1.setQualifierType(BIOLOGICAL_QUALIFIER);
cv1.setBiologicalQualifierType(BQB_IS_VERSION_OF);
cv1.addResource("http://www.ebi.ac.uk/interpro/#IPR002394");
s1.addCVTerm(cv1);

xml = writeSBMLToString(doc)
print(xml)

# After reading the source code => necessary to set metaid first
# (jsbml just creates a metaid if one tries to write RDFannotation to elements
#  without metaids)
s1.setMetaId('asasdfasfasdfasd')
s1.addCVTerm(cv1);
xml = writeSBMLToString(doc)
print(xml)
   
    