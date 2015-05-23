"""
Testing the libsbml annotation capacities.
"""
from __future__ import print_function
import libsbml
from modelcreator.annotation import annotation

# create model
doc = libsbml.SBMLDocument(3, 1)
model = doc.createModel('Test')

s1 = model.createSpecies()
s1.setId('s1')

# ! should at least give a warning, just does nothing
s1.setSBOTerm('11')

# ! should also give a warning, just does nothing
# (based on SBML example)
# http://sbml.org/Software/libSBML/docs/cpp-api/add_c_v_terms_8cpp-example.html !!!
cv1 = libsbml.CVTerm()
cv1.setQualifierType(libsbml.BIOLOGICAL_QUALIFIER)
cv1.setBiologicalQualifierType(libsbml.BQB_IS_VERSION_OF)
cv1.addResource("http://www.ebi.ac.uk/interpro/#IPR002394")
s1.addCVTerm(cv1)

xml = libsbml.writeSBMLToString(doc)
print(xml)

# After reading the source code => necessary to set metaid first
# (jsbml just creates a metaid if one tries to write RDFannotation to elements
#  without metaids)

test = model.getElementBySId("s1")
meta_id = 'meta_id_' + annotation.ModelAnnotator.create_meta_id()
test.setMetaId(meta_id)
test.addCVTerm(cv1)

xml = libsbml.writeSBMLToString(doc)
print(xml)

qualifier = "BQB_IS"
cv = libsbml.CVTerm()
cv.setBiologicalQualifierType(qualifier)
print(cv)
print(cv.getBiologicalQualifierType())
