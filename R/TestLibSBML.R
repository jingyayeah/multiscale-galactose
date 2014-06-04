library('libSBML')
filename = "/home/mkoenig/glucose-model/sbml/Koenig2014_Hepatic_Glucose_Model_annotated.xml"
doc        = readSBML(filename);
errors   = SBMLDocument_getNumErrors(doc);
SBMLDocument_printErrors(doc);
model = SBMLDocument_getModel(doc);
lofp <- Model_getListOfParameters(model)

# does not exist
p <- ListOfParameters_get(lofp, 'asfasf')
res <- tryCatch(SBase_getId(p), error = function(e) e)
print(res)
print(class(res))
is.null(p)

# exists
p <- ListOfParameters_get(lofp, 'HGP')
res <- tryCatch(SBase_getId(p), error = function(e) e)
print(res)
print(class(res))
is.null(p)

# direct way
# p$ref



