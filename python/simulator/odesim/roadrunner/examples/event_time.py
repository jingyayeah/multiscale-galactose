# -*- coding: utf-8 -*-
"""
@author: mkoenig
"""

import roadrunner
from roadrunner import SelectionRecord
print roadrunner.getVersionStr()

import libantimony
model_txt = """
    model test()
    // Reactions
    J0: $PP_S -> 2 S3; K1 * PP_S;

    // Species initializations:
    var species S3;
    var species S4;
    S3 = 0.5;
    PP_S = 0.0;
    S4 := 2*S3;

    // Rule for S1
    K1 = 0.5;    
    
    
    // Additional events for triggering re-integration
    E1: at(time>=2):  S3=5;  
    end
"""
model = libantimony.loadString(model_txt)
sbml_file = 'event_test.xml'
libantimony.writeSBMLFile('event_test.xml', 'test')

r = roadrunner.RoadRunner(sbml_file)

print r.getSBML()
r.selections = ['time'] + r.model.getBoundarySpeciesIds() + r.model.getFloatingSpeciesIds() + r.model.getReactionIds()

# tolerances & integration
absTol = 1E-6 *min(r.model.getCompartmentVolumes())
relTol = 1E-6
print absTol, relTol

print 'Naive VarStep'
r.reset()
r.reset(SelectionRecord.ALL)
r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )
s = r.simulate(0, 7, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=True)   
print s


