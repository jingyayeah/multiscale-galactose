'''
Additional helper function for working with RoadRunner. 
Simplified scripts and functions which are reused in the 
workflow with roadrunner.

Especially the setting of parameters and the update of values
has to be done in a proper and unified way.

@author: Matthias Koenig
@date: 2014-12-19
'''
import time
import roadrunner

#########################################################################    
# Model Loading
#########################################################################  
def load_model(sbml):
    '''
    Load an SBML file in roadrunner
    '''
    print 'Loading :', sbml
    start = time.clock()
    r = roadrunner.RoadRunner(sbml)
    print 'SBML Rules load :', (time.clock()- start)
    return r

#########################################################################    
# Dealing with selections
#########################################################################  
def set_selection(r, selection):
    ''' 
        Sets selection in Roadrunner and
        returns the corresponding selection dictionary. 
    '''
    r.selection = selection
    d = selection_dict(selection)
    return d 

def position_in_list(s_list, item):
    for pos, entry in enumerate(s_list):
        if pos == entry:
            return pos
    return -1
        

def selection_dict(selections):
    ''' 
        Creates a dictionary of the selection to lookup indices. 
    '''
    d = {}
    for k, s in enumerate(selections):
        d[s] = k
    return d

#########################################################################    
# Simualtion
#########################################################################  

# TODO: make sure the simulation parameters are properly updated 
# and the concentration changes are handeled correctly. 
# This is the important part of the integration.
# If the corresponding changes are not handeled appropriately this can
# result in major problems.

def set_parameters(r, parameters):
    '''
    
    '''    
    
    changed = dict()
    for key, value in parameters.iteritems():
        changed[key] = r.model[key]
        r.model[key] = value 
        
    # TODO: not enough !
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
    
def simulation(r, parameters, inits, absTol=1E-8, relTol=1E-8):
    '''
        Performs RoadRunner simulation and returns the results.
    '''
    # TODO: Fix the simulations
    # Especiall the problems with reset of the models.
    # Here a full reset of everything is necessary
    
    # reset the initial concentrations
    from roadrunner import SelectionRecord
    r.reset()
    r.reset(SelectionRecord.ALL)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )    
    
    # set parameters
    changed = set_parameters(r, parameters)
    # in a second step set the initial changes
    set_inits(r, inits)
          
    # absTol is defined relative to the amounts
    absTol = absTol * min(r.model.getCompartmentVolumes())
    start = time.clock()
    s = r.simulate(0, 10000, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=False)      
    print 'Integration time:', (time.clock()- start)
    reset_changed(r, changed)
    
    return s
