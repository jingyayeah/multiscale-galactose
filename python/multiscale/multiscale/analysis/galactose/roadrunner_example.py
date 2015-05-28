# -*- coding: utf-8 -*-


import time
import numpy
import roadrunner
from roadrunner.roadrunner import Logger
from roadrunner import SelectionRecord
print roadrunner.__version__


# sbml_file = 'Galactose_v36_Nc1_galchallenge.xml'
sbml_file = 'Galactose_v43_Nc2_core.xml'
print sbml_file
rr = roadrunner.RoadRunner(sbml_file)


# selection to show problem
sel1 = ['time', '[PP__gal]', '[PV__gal]', 'scale_f', 'H01__scale', 'H01__GALK_Vmax', 'flow_sin', 'Q_sinunit']

rr.selections = sel1
header = ",".join(sel1)
# calculate proper absTol for concentrations
absTol = 1E-6 * min(rr.model.getCompartmentVolumes())


for value in [0, 100]:
    # save the changes for resetting
    changes = dict()    
    
    # Some general changes (not important)
    # set parameters
    changes["deficiency"] = rr.model["deficiency"]
    rr.model["deficiency"] = 0
    # set initial concentrations on boundary species
    changes["gal_challenge"] = rr.model["gal_challenge"]
    rr.model["gal_challenge"] = 8.0   # for boundary species
    
    # These are the important things
    # set scale_f
    changes["scale_f"] = rr.model["scale_f"]
    rr.model["scale_f"] = value   # for boundary species
        
    # set flow
    changes["flow_sin"] = rr.model["flow_sin"]
    rr.model["flow_sin"] = value   # for boundary species
    # rr.setValue("flow_sin", value)
    
    # !!!!
    # In the odesim all depending values on these changed parameters
    # should also be changed !!!
    # This is not the case !!!
    # Especially the initial assignments are not recalculated with the new
    # values ???? 
    # rr.reset()
    
    # rr.reset(SelectionRecord.RATE)
    # rr.reset(SelectionRecord.INITIAL)
    # rr.reset(SelectionRecord.FLOATING)
        
    print '*** simulate ***'    
    start = time.clock()
    # s = rr.simulate(0, 100, absolute=1E-6, relative=1E-6, variableStep=True, stiff=True, sel=sel)
    s = rr.simulate(0, 5000, absolute=absTol, relative=1E-6, variableStep=True, stiff=True, plot=True)

    elapsed = (time.clock()- start)    
    print 'Time:', elapsed
    print(rr.getInfo())

    # write the custom CSV
    print '*** store results ***'
    tc_file = "".join(['test_sim', str(value), '.csv'])
    numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')

    # reset all the changes
    rr.reset()
    for key, value in changes.iteritems():
        rr.model[key] = value


