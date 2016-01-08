# -*- coding: utf-8 -*-
"""
Performing simulation with event driven peak.

@author: Matthias Koenig
@date: 2015-05-28
"""
from __future__ import print_function
import os
import roadrunner
from roadrunner import SelectionRecord
print(roadrunner.getVersionStr())
import antimony

model_txt = """
    model time_peak()
    // Reactions
    J0: $PP_S -> 2 S3; K1 * PP_S;

    // Species initializations:
    var species S3;
    S3 = 0.5;
    // S4 := sin(time)
    PP_S = 0.0;

    // Rule for S1
    K1 = 0.5;    
    t_peak = 2;
    t_duration = 0.5;
    mu = t_peak + 0.5*t_duration;
    y_peak = 1/t_duration;
    sigma = 1/(y_peak*sqrt(2*pi));

    
    // Rule for the function 
    PP_S := 1/(sigma *sqrt(2*pi)) * exp(-(time-mu)^2/(2*sigma^2));    
    //PP_S' = -(time - mu)/(sigma^3*sqrt(2*pi)) * exp(- (time-mu)^2/(2*sigma^2));
    
    // PP_S := sin(time);
    // Additional events for triggering re-integration
    E1: at(time>=t_peak-4*sigma):  K1=K1;  

    end
"""
model = antimony.loadString(model_txt)

out_dir = os.path.dirname(os.path.abspath(__file__))
sbml_path = str(os.path.join(out_dir, 'time_peak.xml'))
print('SBML path:', sbml_path)
antimony.writeSBMLFile(sbml_path, 'time_peak')
r = roadrunner.RoadRunner(sbml_path)

# display the generated and parsed SBML
# print(r.getSBML())
print('default selections:', r.selections)
r.selections = ['time'] + r.model.getBoundarySpeciesIds() + r.model.getFloatingSpeciesIds() + r.model.getReactionIds()
print('floating species:', r.model.getFloatingSpeciesIds())
print('selections:', r.selections)

# tolerances & integration
absTol = 1E-12 *min(r.model.getCompartmentVolumes())
relTol = 1E-12
print('absTol:', absTol, '; relTol:', relTol)

print('Naive VarStep')
r.reset()
r.reset(SelectionRecord.ALL)
r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )
s = r.simulate(0, 7, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=True)   
# print(s)

# Forcing evaluation via maximumTimeStep
# but this takes forever in the evaluation 
print('VarStep with maxTimeStep')
r.reset()
r.reset(SelectionRecord.ALL)
r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )
s = r.simulate(0, 7, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=True, maximumTimeStep=0.5)   
# print(s['time'])
