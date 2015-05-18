"""
Helper functions for RoadRunner simulations.
These provided simplified access to common functionality used in
different simulation scenarios.

The setting and updating of parameters and initial concentrations
can be problematic and should be done in a clear way via the
simulation function.

Simulations should be run via the roadrunner tools to make sure all simulations
are reproducible.
"""
from __future__ import print_function

import time
import roadrunner
from roadrunner import SelectionRecord
from pandas import DataFrame

# ########################################################################
# Model Loading
# ########################################################################
def load_model(sbml_file):
    """ Load SBML file in RoadRunner and returns the roadrunner object.
    Provides additional information about load times.
    time and file.
    """
    print('Loading : {}'.format(sbml_file))
    start = time.time()
    r = roadrunner.RoadRunner(sbml_file)
    duration = time.time() - start
    print('SBML load time : {}'.format(duration))
    return r

# ########################################################################
# Simulation
# ########################################################################
def simulation(r, t_start, t_stop, steps=None, parameters={}, init_concentrations={}, init_values={},
               absTol=1E-8, relTol=1E-8, info=True):
    """ Performs RoadRunner simulation.
        Sets paramter values given in parameters dictionary and
        initial values provided in inits dictionary.
        Returns simulation results and global parameters at end of simulation.
    """
    # complete reset of model just to be sure
    r.reset()
    r.reset(SelectionRecord.ALL)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER )    
    
    # concentration backup
    conc_backup = dict()    
    for sid in r.model.getFloatingSpeciesIds():
        conc_backup[sid] = r["[{}]".format(sid)]
    
    # change parameters & recalculate initial assignments
    changed = _set_parameters(r, parameters)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # restore initial concentrations
    for key, value in conc_backup.iteritems():
        r.model['[{}]'.format(key)] = value
    
    # set changed concentrations
    _set_initial_concentrations(r, init_concentrations)

    # set changed values
    _set_initial_values(r, init_values)

    # perform integration
    absTol = absTol * min(r.model.getCompartmentVolumes())  # absTol relative to the amounts
    timer_start = time.time()
    if not steps:
        # variable step size integration
        s = r.simulate(t_start, t_stop, absolute=absTol, relative=relTol,
                       variableStep=True, stiff=True, plot=False)
    else:
        # stepwise integration
        s = r.simulate(t_start, t_stop, steps=steps, absolute=absTol, relative=relTol,
                       variableStep=False, stiff=True, plot=False)
    timer_total = time.time() - timer_start
    
    # store global parameters for analysis
    gp = _get_global_parameters(r)
    
    # reset parameter changes    
    _set_parameters(r, changed)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # reset initial concentrations
    r.reset()    
    
    if info:
        print('Integration time: {}'.format(timer_total))
    
    return s, gp

def _set_parameters(r, parameters):
    """ Set given dictionary of parameters in model.
        Returns dictionary of changes. """
    changed = dict()
    for key, value in parameters.iteritems():
        changed[key] = r.model[key]
        r.model[key] = value 
    return changed

def _set_initial_concentrations(r, init_concentrations):
    """ Set initial concentrations from dictionary.
        Returns dictionary of changes.
    """
    changed = dict()
    for key, value in init_concentrations.iteritems():
        changed[key] = r.model[key]
        name = 'init([{}])'.format(key)
        r.model[name] = value
    return changed

def _set_initial_values(r, init_values):
    """ Set initial values from dictionary.
        Returns dictionary of changes.
    """
    changed = dict()
    for key, value in init_values.iteritems():
        changed[key] = r.model[key]
        name = 'init({})'.format(key)
        r.model[name] = value
    return changed


def _get_global_parameters(r):
    """ Create the global parameter DataFrame. """
    return DataFrame({'value': r.model.getGlobalParameterValues()},
                     index=r.model.getGlobalParameterIds())
