"""
Helper functions for RoadRunner simulations.
These provided simplified access to common functionality used in
different simulation scenarios.

The setting and updating of parameters and initial concentrations
can be problematic and should be done in a clear way via the
simulation function.

@author: Matthias Koenig
@date: 2015-05-05
"""
from __future__ import print_function

import time
import roadrunner
from roadrunner import SelectionRecord
from pandas import DataFrame


#########################################################################    
# Model Loading
#########################################################################  
def load_model(sbml):
    ''' Load an SBML file in roadrunner providing information about load
        time and file. '''
    print('Loading : {}'.model_format(sbml))
    start = time.time()
    r = roadrunner.RoadRunner(sbml)
    duration = time.time() - start
    print('SBML load time : {}'.model_format(duration))
    return r

#########################################################################    
# Simulation
#########################################################################      
def simulation(r, parameters, inits, t_start=0, t_stop=10000, absTol=1E-8, relTol=1E-8, info=True):
    ''' Performs RoadRunner simulation.
        Sets paramter values given in parameters dictionary and 
        initial values provided in inits dictionary.
        Returns simulation results and global parameters at end of simulation.
    '''    
    # complete reset of model just to be sure
    r.reset()
    r.reset(SelectionRecord.ALL)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )    
    
    # concentration backup
    conc_backup = dict()    
    for sid in r.model.getFloatingSpeciesIds():
        conc_backup[sid] = r["[{}]".model_format(sid)]    
    
    # change parameters & recalculate initial assignments
    changed = _set_parameters(r, parameters)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # restore initial concentrations
    for key, value in conc_backup.iteritems():
        r.model['[{}]'.model_format(key)] = value    
    
    # set changed concentrations
    _set_initial_concentrations(r, inits)
          
    # perform integration
    absTol = absTol * min(r.model.getCompartmentVolumes()) # absTol relative to the amounts
    tmp = time.time()
    s = r.simulate(t_start, t_stop, absolute=absTol, relative=relTol, 
                   variableStep=True, stiff=True, plot=False)
    t_int = time.time() - tmp
    
    # store global parameters for analysis
    gp = get_global_parameters(r)
    
    # reset parameter changes    
    _set_parameters(r, changed)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # reset intial concentrations
    r.reset()    
    
    if info:
        print('Integration time: {}'.model_format(t_int))
    
    return (s, gp)

def _set_parameters(r, parameters):
    ''' Set given dictionary of parameters in model.
        Returns dictionary of changes. '''
    changed = dict()
    for key, value in parameters.iteritems():
        changed[key] = r.model[key]
        r.model[key] = value 
    return changed

def _set_initial_concentrations(r, inits):
    '''Set initial concentrations from dictionary in the model.
    '''
    changed = dict()
    for key, value in inits.iteritems():
        changed[key] = r.model[key]
        name = 'init([{}])'.model_format(key)
        r.model[name] = value
    return changed

def get_global_parameters(r):
    ''' Create the global parameter DataFrame. '''
    return DataFrame({'value': r.model.getGlobalParameterValues()}, 
        index = r.model.getGlobalParameterIds())

# def position_in_list(s_list, item):
#     for pos, entry in enumerate(s_list):
#         if item == entry:
#             return pos
#     return -1
        
