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
sbml_file = "".join([folder, 'Galactose_v19_Nc20_Nf1.xml'])
rr = roadrunner.RoadRunner(sbml_file)

# small selection
sel1 = ['time', '[PP__gal]', '[PV__gal]']

# full selection
sel2 = ['time']
sel2 += [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()]
sel2 += [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] 
sel2 += rr.model.getReactionIds()

rr.selections = sel1
header = ",".join(sel1)

absTol = 1E-6 * min(rr.model.getCompartmentVolumes())

for gal in xrange(0,5):
    changes = dict()
    # is reset via rr.reset()
    # rr.model["init([PP__gal])"] = 2.0  # for floating species
    
    # set parameters
    changes["deficiency"] = rr.model["deficiency"]
    rr.model["deficiency"] = 0
    
    # set initial concentrations on boundary species
    changes["[PP__gal]"] = rr.model["[PP__gal]"]
    rr.model["[PP__gal]"] = gal   # for boundary species

    print '*** simulate ***'    
    start = time.clock()
    # s = rr.simulate(0, 100, absolute=1E-6, relative=1E-6, variableStep=True, stiff=True, sel=sel)
    s = rr.simulate(0, 5000, absolute=absTol, relative=1E-6, variableStep=True, stiff=True, plot=True)

    elapsed = (time.clock()- start)    
    print 'Time:', elapsed
    print(rr.getInfo())

    # write the custom CSV
    print '*** store results ***'
    tc_file = "".join([folder, 'test_gal', str(gal), '.csv'])
    numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')

    # reset
    rr.reset()
    for key, value in changes.iteritems():
        rr.model[key] = value    

# print rr.model.items()
