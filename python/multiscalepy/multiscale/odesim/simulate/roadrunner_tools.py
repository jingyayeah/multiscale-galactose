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
import warnings


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


# ########################################################################
# Simulation
# ########################################################################
def set_integrator_settings(r, variable_step_size=True, stiff=True,
                            absolute_tolerance=1E-8, relative_tolerance=1E-8, debug=True):
    """
    Sets the integrator settings once
    :param r: roadrunner instance
    :return:
    """
    # absTol relative to the amounts
    absolute_tolerance = absolute_tolerance * min(r.model.getCompartmentVolumes())
    # set integrator settings
    integrator = r.getIntegrator()
    integrator.setValue('stiff', stiff)
    integrator.setValue('absolute_tolerance', absolute_tolerance)
    integrator.setValue('relative_tolerance', relative_tolerance)
    integrator.setValue('variable_step_size', variable_step_size)

    if debug:
        print('*'*80)
        print(r)
        print('*'*80)

def simulate(r, t_start, t_stop, steps=None,
             parameters={}, init_concentrations={}, init_amounts={}, debug=True):
    """ Perform RoadRunner simulation.
        Sets parameter values given in parameters dictionary &
        initial values provided in dictionaries.

        TODO: update & check if all the dependencies are handled correctly.
        TODO: this is very specific to the simulation scenario (especially the resets).
            So how to implement a more general simulation wropper with more options.
        TODO: implement tests.
        TODO: keep lean for fast simulations.
        TODO: how to handle various simulation scenarios
        TODO: provide examples for parameters, initial concentrations and amounts.

        Necessary to handle the resets outside of roadrunner.
        r.reset()  # only resets initial concentrations
        r.reset(SelectionRecord.ALL)  # ?
        r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)  # recalculates all initial assignments (but also concentrations)

        Returns simulation results and global parameters at end of simulation.
    """
    # change parameters & recalculate initial assignments
    cdict = store_concentrations(r)  # concentration backup
    changed = _set_parameters(r, parameters)
    r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    restore_concentrations(r, cdict)  # restore concentrations
    
    # set changed concentrations
    _set_initial_concentrations(r, init_concentrations)
    # set changed amounts
    _set_initial_amounts(r, init_amounts)

    # integrate
    timer_start = time.time()
    if steps:
        if r.getIntegrator().getValue('variable_step_size'):
            warnings.warn("steps provided in variable_step_size simulation !")
        s = r.simulate(t_start, t_stop, steps)
    else:
        s = r.simulate(t_start, t_stop, steps)
    timer_total = time.time() - timer_start
    

    # reset parameter changes    
    # _set_parameters(r, changed)
    # r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
    
    # reset initial concentrations
    # r.reset()
    
    if debug:
        print('Integration time: {}'.format(timer_total))

    # simulation timecourse & global parameters for analysis
    return s, global_parameters_dataframe(r)


def store_concentrations(r):
    """ Store FloatingSpecies concentrations of current model state. """
    c = dict()
    for sid in r.model.getFloatingSpeciesIds():
        c[sid] = r["[{}]".format(sid)]
    return c


def restore_concentrations(r, cdict):
    """ Restore the FloatingSpecies concentrations given in the dict. """
    for key, value in cdict.iteritems():
        r.model['[{}]'.format(key)] = value


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


def plot_results(results):
    """
    :param results: list of result matrices
    :return:
    """
    import matplotlib.pylab as plt

    plt.figure(figsize=(10, 7))
    for s in results:
        plt.plot(s[:, 0], s[:, 1:], 'o-', color='black')
        print('tend:', s[-1, 0])
    # labels
    plt_fontsize = 30
    plt.xlabel('time [s]', fontsize=plt_fontsize)
    plt.ylabel('species [mM]', fontsize=plt_fontsize)