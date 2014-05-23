'''
Created on May 22, 2014

@author: mkoenig
'''
# -*- coding: utf-8 -*-
"""
Spyder Editor

This temporary script file is located here:
/home/mkoenig/.spyder2/.temp.py
"""
import time
import numpy
import roadrunner
from libsbml import *
from roadrunner.roadrunner import Logger
print roadrunner.__version__


folder = '/home/mkoenig/multiscale-galactose-results/tmp_sim/'
sbml_file = "".join([folder, 'Galactose_v19_Nc20_Nf1.xml'])

rr = roadrunner.RoadRunner(sbml_file)
Vol_dis = rr.model.Vol_dis
absTol = 1E-6*Vol_dis

print 'simulate'
for d in xrange(0,24):
    # Set parameters
    rr.model.deficiency = d
    start = time.clock()
    #s = rr.simulate(0, 100, steps=4000, 
    #                    absolute=1E-6, relative=1E-6, stiff=True)
    # Logger.setLevel(Logger.LOG_TRACE)
    
    s = rr.simulate(0, 1000, 
                    absolute=absTol, relative=1E-6, stiff=True, variableStep=True)                    
    # Logger.setLevel(Logger.LOG_WARNING)

    elapsed = (time.clock()- start)    
    print 'Time:', elapsed
    rr.reset()


# <type 'numpy.ndarray'>
# print rr.selections



# Store Timecourse Results
# TODO: proper file format for analysis (header ?) -> use all ids of the sbml
# rr.plot(s)
        
tc_file = "".join([folder, 'test.csv'])
numpy.savetxt(tc_file, s, header=", ".join(rr.selections), delimiter=",")