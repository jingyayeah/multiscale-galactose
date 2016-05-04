from __future__ import print_function, division
from libsbml import *

sbmlns = SBMLNamespaces(3, 1, "fbc", 2)
doc = SBMLDocument(sbmlns)
doc.setPackageRequired("fbc", False)
model = doc.createModel()
mplugin = model.getPlugin("fbc")
mplugin.setStrict(False)
