'''
Created on Dec 8, 2014

@author: mkoenig
'''
import time
import roadrunner
from roadrunner import SelectionRecord
print roadrunner.__version__

sbml_file = 'Galactose_v36_Nc20_galchallenge.xml'
sbml_file2 = 'Galactose_v43_Nc20_galchallenge.xml'

def test():
    print '#' * 40
    print 'test()'    
    print '#' * 40
    print("LLVM symbol cache value: " + str(roadrunner.Config.getValue(roadrunner.Config.LLVM_SYMBOL_CACHE)))
    print 'Loading :', sbml_file 
    start = time.clock()
    rr1 = roadrunner.RoadRunner(sbml_file)
    print 'Assignments load :', (time.clock()- start)
    start = time.clock()
    rr1 = roadrunner.RoadRunner(sbml_file)
    print 'Assignments repeat :', (time.clock()- start)
    print

    print 'Loading :', sbml_file2
    start = time.clock()
    rr2 = roadrunner.RoadRunner(sbml_file2)
    print 'Rules load :', (time.clock()- start)
    start = time.clock()
    rr2 = roadrunner.RoadRunner(sbml_file2)
    print 'Rules repeat :', (time.clock()- start)    
    
    # calculate proper absTol for concentrations
    # absTol = 1E-6 * min(rr1.model.getCompartmentVolumes())
    
    for rr in [rr1, rr2]:
        absTol = 1E-6 * min(rr.model.getCompartmentVolumes())
        
        # set selection
        sel = ['time']
        sel += [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()]
        sel += [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] 
        # Store reactions
        sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]   
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
        rr.model["[PP__gal]"] = 5.0
        print 'PP__gal', rr.model['[PP__gal]']
        rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
        print 'PP__gal', rr.model['[PP__gal]']
        print rr.model.getBoundarySpeciesIds()
                
        print '*** simulate ***'    
        start = time.clock()
        s = rr.simulate(0, 5000, absolute=absTol, relative=1E-6, variableStep=True, stiff=True, plot=False)    
        print 'Integration time:', (time.clock()- start)    
        

roadrunner.Config.setValue(roadrunner.Config.OPTIMIZE_REACTION_RATE_SELECTION, True)
roadrunner.Config.setValue(roadrunner.Config.LLVM_SYMBOL_CACHE, False)
test()

roadrunner.Config.setValue(roadrunner.Config.LLVM_SYMBOL_CACHE, True)
test()
