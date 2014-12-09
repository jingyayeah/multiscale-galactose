'''
Created on Dec 8, 2014

@author: mkoenig
'''
import time
import roadrunner
print roadrunner.__version__

# Load the model once to work with it
sbml_file = 'Galactose_v43_Nc20_galchallenge.xml'
print sbml_file

print 'Loading :', sbml_file
start = time.clock()
r = roadrunner.RoadRunner(sbml_file)
print 'SBML Rules load :', (time.clock()- start)

print r.model.items()


# calculate proper absTol for concentrations
# absTol = 1E-6 * min(rr1.model.getCompartmentVolumes())

for rr in [rr1, rr2]:
    absTol = 1E-6 * min(rr.model.getCompartmentVolumes())
    print rr.model.getCompartmentVolumes()
    print 'Tolerance:', absTol
    
    # set selection
    sel = ['time']
    sel += [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()]
    sel += [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] 
    # Store reactions
    # sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]
    rr.selections = sel
    
    
    # set parameters
    rr.model["deficiency"] = 0
    rr.model["flow_sin"] = 2.7E-06
    rr.model["scale_f"] = 6.625E-15
    rr.model["gal_challenge"] = 8.0
    rr.model["y_dis"] = 1.2E-06
    rr.model["L"] = 0.0005
    rr.model["y_sin"] = 4.4E-6
    rr.model["y_cell"] = 7.58E-6
    rr.reset()    
    
    print '*** simulate ***'    
    start = time.clock()
    s = rr.simulate(0, 5000, absolute=absTol, relative=1E-6, variableStep=True, stiff=True, plot=False)    
    print 'Integration time:', (time.clock()- start)    
    
