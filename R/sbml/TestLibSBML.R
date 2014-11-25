rm(list=ls())
library('libSBML')
# version 5.10.2

# filename = "/home/mkoenig/multiscale-galactose-results/2014-08-13_T26/Galactose_v21_Nc20_galactose-challenge.xml"
filename = "/home/mkoenig/multiscale-galactose/R/analysis/sbml/test/Koenig2014_demo_kinetic_v7.xml"

doc        = readSBML(filename);
errors   = SBMLDocument_getNumErrors(doc);
SBMLDocument_printErrors(doc);
model = SBMLDocument_getModel(doc);
lofp <- Model_getListOfParameters(model)
lofp
Model_getId(model)
Model_getName(model)
SBase_getId(model)

# does not exist
p <- ListOfParameters_get(lofp, 'asfasf')
res <- tryCatch(SBase_getId(p), error = function(e) e)
print(res)
print(class(res))
is.null(p)

# exists
p <- ListOfParameters_get(lofp, 'Km_A')
res <- tryCatch(SBase_getId(p), error = function(e) e)
print(res)
print(class(res))
is.null(p)

# direct way
# p$ref



