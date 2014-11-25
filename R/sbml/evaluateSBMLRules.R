library(libSBML)

filename = filename <- '/home/mkoenig/multiscale-galactose-results/tmp_sbml/Galactose_v13_Nc20_Nf1.xml'
d        = readSBML(filename);
errors   = SBMLDocument_getNumErrors(d);
SBMLDocument_printErrors(d);

m = SBMLDocument_getModel(d);

level   = SBase_getLevel  (d);
version = SBase_getVersion(d);

cat("\n");
cat("File: ",filename," (Level ",level,", version ",version,")\n");

if (errors > 0) {
  stop("No model present.");  
}

printRuleMath <- function(n, r) {
  if ( Rule_isSetMath(r) ) {
    formula = formulaToString( Rule_getMath(r) );
    cat("Rule ",n,", formula: ",formula,"\n");    
  }
}

printAssignmentMath <- function(a) {
  if ( InitialAssignment_isSetMath(a) ) {
    formula = formulaToString( InitialAssignment_getMath(a) );
    n <- SBase_getId(a)
    cat("Rule ",n,", formula: ",formula,"\n");    
  }
}


cat("         ");
cat("  model id: ", ifelse(Model_isSetId(m), Model_getId(m) ,"(empty)"),"\n");

cat( "functionDefinitions: ", Model_getNumFunctionDefinitions(m) ,"\n" );
cat( "    unitDefinitions: ", Model_getNumUnitDefinitions    (m) ,"\n" );
cat( "   compartmentTypes: ", Model_getNumCompartmentTypes   (m) ,"\n" );
cat( "        specieTypes: ", Model_getNumSpeciesTypes       (m) ,"\n" );
cat( "       compartments: ", Model_getNumCompartments       (m) ,"\n" );
cat( "            species: ", Model_getNumSpecies            (m) ,"\n" );
cat( "         parameters: ", Model_getNumParameters         (m) ,"\n" );
cat( " initialAssignments: ", Model_getNumInitialAssignments (m) ,"\n" );


cat( "              rules: ", Model_getNumRules              (m) ,"\n" );
cat( "        constraints: ", Model_getNumConstraints        (m) ,"\n" );
cat( "          reactions: ", Model_getNumReactions          (m) ,"\n" );
cat( "             events: ", Model_getNumEvents             (m) ,"\n" );
cat( "\n" );

p <- Model_getParameter(m, 'Nc')
id <- Parameter_getId(p)
value <- Parameter_getValue(p)
print(id)
print(value)