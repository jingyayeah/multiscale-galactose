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
from __future__ import print_function, division

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
    time_start = time.time()
    r = roadrunner.RoadRunner(sbml_file)
    print('SBML load time: {}'.format(time.time() - time_start))
    return r


def global_parameters_dataframe(r):
    """ Create GlobalParameter DataFrame. """
    return DataFrame({'value': r.model.getGlobalParameterValues()},
                     index=r.model.getGlobalParameterIds())


def floating_species_dataframe(r):
    """ Create FloatingSpecies DataFrame. """
    return DataFrame({'concentration': r.model.getFloatingSpeciesConcentrations(),
                      'amount': r.model.getFloatingSpeciesAmounts()},
                     index=r.model.getFloatingSpeciesIds())


def boundary_species_dataframe(r):
    """ Create BoundingSpecies DataFrame. """
    return DataFrame({'concentration': r.model.getBoundarySpeciesConcentrations(),
                      'amount': r.model.getBoundarySpeciesAmounts()},
                     index=r.model.getBoundarySpeciesIds())

def print_integrator_settings(r):
    """
    Prints the roadrunner integrator settings.
    See https://github.com/sys-bio/roadrunner/issues/248
    :param r: roadrunner instance
    :return:
    """
    integrator = r.getIntegrator()
    print(integrator.getName())
    for key in integrator.getSettings():
        print(key, ':', integrator.getValue(key))

# ########################################################################
# Simulation
# ########################################################################
def simulate(r, t_start, t_stop, steps=None,
             parameters={}, init_concentrations={}, init_amounts={},
             absTol=1E-8, relTol=1E-8, debug=True):
    """ Perform RoadRunner simulation.
        Sets parameter values given in parameters dictionary &
        initial values provided in dictionaries.

        TODO: update & check if all the dependencies are handled correctly.
        TODO: this is very specific to the simulation scenario (especially the resets).
            So how to implement a more general simulation wropper with more options.
        TODO: implement tests.
        TODO: keep lean for fast simulations.

        Returns simulation results and global parameters at end of simulation.
    """
    # complete reset of model just to be sure
    r.reset()
    # normal reset is using: rr::Config::MODEL_RESET

    r.reset(SelectionRecord.ALL)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # concentration backup
    concentration_backup = dict()
    for sid in r.model.getFloatingSpeciesIds():
        concentration_backup[sid] = r["[{}]".format(sid)]
    
    # change parameters & recalculate initial assignments
    changed = _set_parameters(r, parameters)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # restore initial concentrations
    for key, value in concentration_backup.iteritems():
        r.model['[{}]'.format(key)] = value
    
    # set changed concentrations
    _set_initial_concentrations(r, init_concentrations)

    # set changed values
    _set_initial_amounts(r, init_amounts)

    # set integrator variables
    absTol = absTol * min(r.model.getCompartmentVolumes())  # absTol relative to the amounts
    integrator = r.getIntegrator()
    integrator.setValue('stiff', True)
    integrator.setValue('absolute_tolerance', absTol)
    integrator.setValue('relative_tolerance', relTol)
    if not steps:
        integrator.setValue('variable_step_size', True)
    else:
        integrator.setValue('variable_step_size', False)

    if debug:
        print(r)
        print_integrator_settings(r)



    # integrate
    timer_start = time.time()
    s = r.simulate(t_start, t_stop)
    timer_total = time.time() - timer_start
    
    # store global parameters for analysis
    gp = global_parameters_dataframe(r)
    
    # reset parameter changes    
    _set_parameters(r, changed)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # reset initial concentrations
    r.reset()    
    
    if debug:
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


def _set_initial_amounts(r, init_amounts):
    """ Set initial values from dictionary.
        Returns dictionary of changes.
    """
    changed = dict()
    for key, value in init_amounts.iteritems():
        changed[key] = r.model[key]
        name = 'init({})'.format(key)
        r.model[name] = value
    return changed
