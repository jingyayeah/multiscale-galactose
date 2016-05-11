from __future__ import print_function
from libsbml import *

doc = SBMLDocument(2, 1)
model = doc.createModel()
mid = 'PKPD model'
model.setId(mid)
