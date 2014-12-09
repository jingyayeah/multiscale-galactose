'''
Simulation with RoadRunner model for description of the Multiple Indicator
Dilution Data.

@author: mkoenig
'''
import time
import roadrunner
print roadrunner.__version__

def load_model(sbml):
    print 'Loading :', sbml_file
    start = time.clock()
    r = roadrunner.RoadRunner(sbml)
    print 'SBML Rules load :', (time.clock()- start)    
    return(r)

def set_parameters(r, parameters):
    changed = dict()
    for key, value in parameters.iteritems():
        changed[key] = r.model[key]
        r.model[key] = value 
    r.reset()
    return changed

def reset_changed(r, changed):
    for key, value in changed.iteritems():
        r.model[key] = value  
    r.reset()

def set_inits(r, inits):
    changed = dict()
    for key, value in inits.iteritems():
        changed[key] = r.model[key]
        name = "".join(['init([', key, '])'])
        r.model[name] = value 
    return changed
    
def simulation(r, selection, parameters, inits):
    # reset the initial concentrations
    r.reset()
    # set selection
    r.selections = selection
    # set parameters
    changed = set_parameters(r, parameters)
    # in a second step set the initial changes
    set_inits(r, inits)
        
    print '*** simulate ***'    
    absTol = 1E-6 * min(r.model.getCompartmentVolumes())
    relTol = 1E-6
    start = time.clock()
    s = r.simulate(0, 5000, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=False)    
    print 'Integration time:', (time.clock()- start)
    reset_changed(r, changed)
    
    return s
    
def plot(r, show=True):
    import pylab as p
    result = r.getSimulationData()
    if result is None:
        raise Exception("no simulation result")
    
    time = result[:,0]

    selections = r.selections
    for i in range(1, len(selections)):
        series = result[:,i]
        name = selections[i]
        p.plot(time, series, label=str(name))
        p.legend()
    if show:
        p.show()
    
#########################################################################    
# Galactose Challenge
#########################################################################    
sbml_file = 'Galactose_v43_Nc20_galchallenge.xml'
r = load_model(sbml_file)
print r.model.items()

# set selection
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# Store reactions
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

parameters = { 
        "gal_challenge" : 8.0,
    }
inits = {}
s = simulation(r, sel, parameters, inits)
plot(r)


#########################################################################    
# Galactose Challenge
#########################################################################  
sbml_file = 'Galactose_v43_Nc20_dilution.xml'
r = load_model(sbml_file)
print r.model.items()

# set selection
sel = ['time']
sel += [ "".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()]
sel += [ "".join(["[", item, "]"]) for item in ['PV__alb', 'PV__gal', 'PV__galM', 'PV__h2oM', 'PV__rbcM', "PV__suc"]]
# sel += [ "".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] 
# Store reactions
# sel += [item for item in rr.model.getReactionIds() if item.startswith('H')]

parameters = { 
        "gal_challenge" : 8.0,
    }
inits = {"PP__gal" : 8.0,}

# set the boundary concentrations
# PP__gal = (0.28, 5, 12.5, 17.5) # [mM]

s1 = simulation(r, sel, parameters, inits)
plot(r)



