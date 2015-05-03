# -*- coding: utf-8 -*-
"""
Created on Wed Dec 10 17:30:06 2014

@author: mkoenig
"""

import roadrunner
from roadrunner import SelectionRecord

import libantimony

roadrunner.Config.setValue(roadrunner.Config.LLVM_SYMBOL_CACHE, True)

model_txt = """
    model test()
    // Reactions
    J0: S1 + S2 -> $S3; K3 * S1 * S2;
    
    compartment V;
    V = 1.0;
    
    // Species initializations:
    S1 in V;
    S1 = 1;

    // S2 init conditions is specified by the rule of K1 + K2;
    S2 in V;
    S3 in V;
    S2 = K1 + K2;
    S3 = 0;


    // Variable initialization:
    K1 = 1;
    K2 = 2;
    K3 = 0.1;
    K4 = K1 + K2;   # K4 has an initial assignment, only active at init or reset time.
    K5 := K1 + K2;  # K5 is defined by a rule, this is always active
    end
"""
model = libantimony.loadString(model_txt)
libantimony.writeSBMLFile('test.xml', 'test')

sbml_file = 'test.xml'
r = roadrunner.RoadRunner(sbml_file)
r.model.items()
r.selections = ['time'] + r.model.getBoundarySpeciesIds() + r.model.getFloatingSpeciesIds() 

# store all concentrations
conc_backup = dict()
for sid in r.model.getBoundarySpeciesIds():
    conc_backup[sid] = r["[{}]".format(id)]    
for sid in r.model.getFloatingSpeciesIds():
    conc_backup[sid] = r["[{}]".format(id)]


r.model.items()
print '* Change Parameters *'
r.V = 0.6
print r.model.items()

r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
r.reset()
r.model.items()


print '* Update concentrations *'
# TODO

# restore concentrations
for key, value in conc_backup.iteritems():
    r.model["[{}]".format(key)] = value
print r.model.items()
