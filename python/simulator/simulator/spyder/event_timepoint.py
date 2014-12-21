# -*- coding: utf-8 -*-
"""

@author: mkoenig
"""

import roadrunner
from roadrunner import SelectionRecord

print roadrunner.__version__

import antimony
model_txt = """
    model test()
    // Reactions
    J0: $PP_S -> 2 S3; K1 * PP_S;

    // Species initializations:
    var species S3;
    S3 = 0.5;

    K1 = 0.5;    
    
    t_peak = 10;
    t_duration = 5;
    peak_status = 0
   
    // Rule for PP_S
    PP_S := peak_status * 1.0 
    
    // Event to trigger the peak
    E0: at(time>=0):  peak_status=0;  
    E1: at(time>=t_peak):  peak_status=1;  
    E2: at(time>=t_peak+t_duration):  peak_status=0;

    end
"""
model = antimony.loadString(model_txt)
sbml_file = 'test_peak.xml'
antimony.writeSBMLFile('test_peak.xml', 'test')

r = roadrunner.RoadRunner(sbml_file)
print r.getSBML()
r.selections = ['time'] + r.model.getBoundarySpeciesIds() + r.model.getFloatingSpeciesIds() + r.model.getReactionIds()

# tolerances & integration
absTol = 1E-12 *min(r.model.getCompartmentVolumes())
relTol = 1E-12

print 'Naive VarStep'
r.reset()
r.reset(SelectionRecord.ALL)
r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )
s = r.simulate(0, 20, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=True)   

