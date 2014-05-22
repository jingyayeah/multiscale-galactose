# -*- coding: utf-8 -*-
"""
Spyder Editor

This temporary script file is located here:
/home/mkoenig/.spyder2/.temp.py
"""
import time
import numpy
import roadrunner
from roadrunner.roadrunner import Logger
print roadrunner.__version__

folder = '/home/mkoenig/multiscale-galactose-results/tmp_sim/'
sbml_file = "".join([folder, 'MultipleIndicator_P00_v19_Nc20_Nf1.xml'])
rr = roadrunner.RoadRunner(sbml_file)

# Create selection for variable of interest
# (take care of differences between concenrations and SBML ids)
sel = ['time']  
ids = ['time']

bs_ids = rr.model.getBoundarySpeciesIds()
sel += [ "".join(["[", item, "]"]) for item in bs_ids]
ids += bs_ids

fs_ids = rr.model.getFloatingSpeciesIds()
sel += [ "".join(["[", item, "]"]) for item in fs_ids]
ids += fs_ids

r_ids = rr.model.getReactionIds()
sel += r_ids
ids += r_ids
#print sel


print '*** simulate ***'
# Logger.setLevel(Logger.LOG_TRACE)
start = time.clock()
# s = rr.simulate(0, 100, absolute=1E-6, relative=1E-6, variableStep=True, stiff=True, sel=sel)
s = rr.simulate(0, 100, absolute=1E-20, relative=1E-6, variableStep=True, stiff=True, sel=sel, plot=True)

elapsed = (time.clock()- start)    
print 'Time:', elapsed
print(rr.getInfo())


# write the custom CSV
print '*** store results ***'
tc_file = "".join([folder, 'test.csv'])
numpy.savetxt(tc_file, s, header=", ".join(ids), delimiter=",", fmt='%.6E')


import os
print os.getcwd()
print tc_file
# Get items
# print rr.model.items()
