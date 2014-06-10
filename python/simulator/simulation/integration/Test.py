'''
Created on May 22, 2014
@author: Matthias Koenig
'''

import time
import numpy
import roadrunner

print roadrunner.__version__


def createRoadRunnerSelection(rr, boundarySpecies=True, floatingSpecies=True, reaction=True):
    ''' 
    Creates Roadrunner selection in RoadRunner syntax.
        [species] -> concentration
        species -> amount
        [species'] -> concentration/time (rate of change)
        reaction -> reaction rates
    Control coefficients and elasticities also be selected (see Roadrunner documentation)
    '''
    sel = ['time']
    if (boundarySpecies):  
        sel += [ "".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()]

    if (floatingSpecies):
        sel += [ "".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()]

    if (reaction):
        sel += rr.model.getReactionIds()

    return sel
    

folder = '/home/mkoenig/multiscale-galactose-results/tmp_sim/'
sbml_file = "".join([folder, 'Galactose_v19_Nc20_Nf1.xml'])

rr = roadrunner.RoadRunner(sbml_file)
rr.selections = createRoadRunnerSelection(rr)

sel = ['time', '[PP__gal]', '[PV__gal]']
rr.selections = sel

header = ",".join(rr.selections)

# scale the absolute tolerance for the amounts
Vol_dis = rr.model.Vol_dis
absTol = 1E-6*Vol_dis


print 'simulate'
for d in xrange(0,24):
    print 'Deficiency = ', d
    changes = dict()
    
    # Set parameters
    changes["deficiency"] = rr.model["deficiency"]
    rr.model.deficiency = d
    
    # Set initial concentrations boundaries
    changes["[PP__gal]"] = rr.model["[PP__gal]"]
    rr.model["[PP__gal]"] = 2.0   # for boundary species
    
    
    start = time.clock()
    print 
    s = rr.simulate(0, 5000, absolute=1E-20, relative=1E-6, 
                    stiff=True, variableStep=True)                    

    elapsed = (time.clock()- start)    
    print 'Time:', elapsed

    tc_file = "".join([folder, 'D', str(d), '_RRtest.csv'])
    numpy.savetxt(tc_file, s, header=header, delimiter=",", fmt='%.6E')
    
    # Reset SBML to original state
    rr.reset()
    for key, value in changes.iteritems():
        rr.model[key] = value  
