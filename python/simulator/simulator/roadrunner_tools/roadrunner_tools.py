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
from pandas import DataFrame
import pandas as pd

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


def get_global_parameters(r):
    ''' Create the global parameter DataFrame. '''
    return DataFrame({'value': r.model.getGlobalParameterValues()}, 
        index = r.model.getGlobalParameterIds())


#########################################################################    
# Dealing with selections
#########################################################################  
def set_selection(r, selection):
    ''' 
        Sets selection in Roadrunner and
        returns the corresponding selection dictionary. 
    '''
    r.selections = selection
    d = selection_dict(selection)
    return d 

def position_in_list(s_list, item):
    for pos, entry in enumerate(s_list):
        if item == entry:
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
    
def get_ids_from_selection(name, selections, comp_type='H'):
    '''
    Returns list of ids in selection for given name.
    '''
    ids = [item for item in selections if ( (item.startswith('[{}'.format(comp_type)) | item.startswith(comp_type)) 
                                    & (item.endswith('__{}]'.format(name)) | item.endswith('__{}'.format(name))) )]
    if len(ids) == 0:
        ids = [name, ]
    return ids

#########################################################################    
# Simulation
#########################################################################      
def simulation(r, parameters, inits, absTol=1E-8, relTol=1E-8):
    '''
    Performs RoadRunner simulation.
    '''    
    # complete reset of model just to be sure
    from roadrunner import SelectionRecord
    r.reset()
    r.reset(SelectionRecord.ALL)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )    
    
    # make a concentration backup
    conc_backup = dict()
    # for sid in r.model.getBoundarySpeciesIds():
    #    conc_backup[sid] = r["[{}]".format(sid)]    
    for sid in r.model.getFloatingSpeciesIds():
        conc_backup[sid] = r["[{}]".format(sid)]    
    
    # change parameters & recalculate initial assignments
    changed = _set_parameters(r, parameters)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # restore initial concentrations
    for key, value in conc_backup.iteritems():
        r.model['[{}]'.format(key)] = value    
    
    # set changed concentrations
    _set_initial_concentrations(r, inits)
          
    # perform integration
    absTol = absTol * min(r.model.getCompartmentVolumes()) # absTol relative to the amounts
    start = time.clock()
    s = r.simulate(0, 10000, absolute=absTol, relative=relTol, variableStep=True, stiff=True, plot=False)      
    print 'Integration time:', (time.clock()- start)
        
    # store global parameters for analysis
    gp = get_global_parameters(r)
    
    # reset parameter changes    
    _set_parameters(r, changed)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # reset intial concentrations
    r.reset()    
    
    return (s, gp)

def _set_parameters(r, parameters):
    ''' 
    Changes parameters in model.
    Returns dictionary of changes.
    '''
    
    changed = dict()
    for key, value in parameters.iteritems():
        changed[key] = r.model[key]
        r.model[key] = value 
    return changed

def _set_initial_concentrations(r, inits):
    '''
    Set the initial concentrations in the model.
    '''
    changed = dict()
    for key, value in inits.iteritems():
        changed[key] = r.model[key]
        name = 'init([{}])'.format(key)
        r.model[name] = value
    return changed
