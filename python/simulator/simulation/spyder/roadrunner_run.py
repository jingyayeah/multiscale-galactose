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

folder = '/home/mkoenig/work/workbench/SBML/models/'
sbml_file = "".join([folder, 'input_function.xml'])
print sbml_file
rr = roadrunner.RoadRunner(sbml_file)

# small selection
# sel1 = ['time', '[PP__gal]', '[PV__gal]']

# full selection
sel2 = ['time']
sel2 += [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()]
sel2 += [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] 
sel2 += rr.model.getReactionIds()

rr.selections = sel2
header = ",".join(sel2)

absTol = 1E-6 * min(rr.model.getCompartmentVolumes())


    # is reset via rr.reset()
    # rr.model["init([PP__gal])"] = 2.0  # for floating species
    
# set parameters
rr.model["k1"] = 1
    
    # set initial concentrations on boundary species
    # changes["[PP__gal]"] = rr.model["[PP__gal]"]
    # rr.model["[PP__gal]"] = gal   # for boundary species

print '*** simulate ***'    
start = time.clock()
# s = rr.simulate(0, 100, absolute=1E-6, relative=1E-6, variableStep=True, stiff=True, sel=sel)
s = rr.simulate(0, 20, absolute=absTol, relative=1E-6, variableStep=True, stiff=True, plot=True)

elapsed = (time.clock()- start)    
print 'Time:', elapsed
print(rr.getInfo())

# write the custom CSV
print '*** store results ***'
tc_file = "".join([folder, 'test', '.csv'])
numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')

# print rr.model.items()