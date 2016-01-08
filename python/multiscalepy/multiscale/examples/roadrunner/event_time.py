# -*- coding: utf-8 -*-
"""
Antimony based model with event triggered at certain event times.
The event times occur at exactly the same timepoint, which can be problematic.

@author: mkoenig
@date: 2015-05-05
"""
from __future__ import print_function
import antimony
import roadrunner
from roadrunner import SelectionRecord
import itertools

# Model definition via antimony.
# The model contains an Event triggered at t=2 [s].
model_txt = """
    model event_time()
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
model = antimony.loadString(model_txt)
sbml_file = 'event_time.xml'
antimony.writeSBMLFile('event_time.xml', 'event_time')

# load model in roadrunner and define the selection
r = roadrunner.RoadRunner(sbml_file)
r.selections = list(itertools.chain(['time'],
                                    r.model.getBoundarySpeciesIds(),
                                    r.model.getFloatingSpeciesIds(),
                                    r.model.getReactionIds()))
print(r.selections)
absTol = 1E-6 * min(r.model.getCompartmentVolumes())
relTol = 1E-6

r.reset()
r.reset(SelectionRecord.ALL)
r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
s = r.simulate(0, 7, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=True)
print(s)
