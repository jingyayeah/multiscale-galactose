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
from roadrunner import RoadRunner, SelectionRecord
from pandas import DataFrame
import warnings

from multiscale.util.timing import time_it


class MyRunner(RoadRunner):
    """
    Provides additional information about load times and
    simulate times.
    """
    @time_it(message="SBML compile")
    def __init__(self, *args, **kwargs):
        # super constructor
        RoadRunner.__init__(self, *args, **kwargs)
        self.debug = False
        # set the default settings for the integrator
        self.set_default_settings()

    #########################################################################
    # Settings
    #########################################################################
    def set_debug(self, debug):
        self.debug = debug

    def set_default_settings(self):
        """ Set default settings of integrator. """
        self.set_integrator_settings(
                variable_step_size=True,
                stiff=True,
                absolute_tolerance=1E-8,
                relative_tolerance=1E-8
        )

    def set_integrator_settings(self, **kwargs):
        """ Set integrator settings. """
        integrator = self.getIntegrator()
        for key, value in kwargs.items():
            # adapt the absolute_tolerance relative to the amounts
            if key == "absolute_tolerance":
                value = value * min(self.model.getCompartmentVolumes())
            integrator.setValue(key, value)

        if self.debug:
            print(integrator)

    #########################################################################
    # Selections
    #########################################################################
    def get_floating_concentration_selections(self):
        return ['time'] + ['[{}]'.format(s) for s in self.model.getFloatingSpeciesIds()]

    #########################################################################
    # Simulation
    #########################################################################
    # supported simulate options
    _simulate_args = frozenset(["start", "end", "steps", "selections"])

    @time_it()
    def simulate(self, *args, **kwargs):
        """ Timed simulate function. """
        for key in kwargs:
            assert(key in self._simulate_args)
        return RoadRunner.simulate(*args, **kwargs)

    def simulate_complex(self, initial_concentrations={}, initial_amounts={},
                         parameters={}, reset_parameters=False, **kwargs):
        """ Perform RoadRunner simulation.
            Sets parameter values given in parameters dictionary &
            initial values provided in dictionaries.

            Optional argument:
            parameters:
                dictionary of parameter changes

            reset_parameters:
                reset the parameter changes after the simulation

            initial_concentrations:
                dictionary of initial_concentrations

            initial_concentrations:
                dictionary of initial_amounts (overwrites initial concentrations)

            :returns tuple of simulation result and global parameters at end point of
                    simulation (<NamedArray>, <DataFrame>)
        """
        # TODO: Tests:examples for parameters, initial concentrations and amounts.
        # change parameters & recalculate initial assignments
        if len(parameters) > 0:
            concentrations = self.store_concentrations()
            changed = self._set_parameters(parameters)
            self.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
            self.restore_concentrations(concentrations)

        # set changed concentrations
        if len(initial_concentrations) > 0:
            self._set_initial_concentrations(initial_concentrations)
        # set changed amounts
        if len(initial_amounts) > 0:
            self._set_initial_amounts(initial_amounts)

        if ("steps" in kwargs) and (self.getIntegrator().getValue('variable_step_size') == True):
            warnings.warn("steps provided in variable_step_size simulation !")

        # simulate (dangerous as long as simulate arguments not validated)
        s = self.simulate(kwargs)

        if reset_parameters:
            self._set_parameters(changed)
            self.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)

        # simulation timecourse & global parameters for analysis
        return s, self.global_parameters_dataframe()


    def store_concentrations(self):
        """ Store FloatingSpecies concentrations of current model state. """
        return {"[{}]".format(sid): self["[{}]".format(sid)]
                for sid in self.model.getFloatingSpeciesIds()}

    def restore_concentrations(self, concentrations):
        """ Restore the FloatingSpecies concentrations given in dictionary. """
        assert(isinstance(concentrations, dict))
        for key, value in concentrations.iteritems():
            self[key] = value

    def store_amounts(self):
        """ Store FloatingSpecies amounts of current model state. """
        # TODO: test
        return {sid: self[sid] for sid in self.model.getFloatingSpeciesIds()}

    def restore_amounts(self, amounts):
        """ Restore FloatingSpecies amounts given in dictionary. """
        assert(isinstance(amounts, dict))
        for key, value in amounts.iteritems():
            amounts.model['[{}]'.format(key)] = value

    def _set_parameters(self, parameters):
        """ Set given dictionary of parameters in model.
            Returns dictionary of changes. """
        changed = dict()
        for key, value in parameters.iteritems():
            changed[key] = self.model[key]
            self.model[key] = value
        return changed

    def _set_initial_concentrations(self, init_concentrations):
        """ Set initial concentrations from dictionary.
            Returns dictionary of changes.
        """
        changed = dict()
        for key, value in init_concentrations.iteritems():
            changed[key] = self[key]
            name = 'init([{}])'.format(key)
            self[name] = value
        return changed

    def _set_initial_amounts(self, init_amounts):
        """ Set initial values from dictionary.
            Returns dictionary of changes.
        """
        changed = dict()
        for key, value in init_amounts.iteritems():
            changed[key] = self[key]
            name = 'init({})'.format(key)
            self.model[name] = value
        return changed


    #########################################################################
    # Helper for units & selections
    #########################################################################
    def get_global_constant_parameters(self):
        """ Subset of global parameters which are constant.
            Set of parameter which has constant values and is not calculated
            based on an initialAssignment.
        """
        # All global parameters which are constant have to be varied.
        parameter_ids = self.model.getGlobalParameterIds()
        import libsbml
        doc = libsbml.readSBMLFromString(self.getSBML())
        model = doc.getModel()
        const_parameter_ids = []
        for pid in parameter_ids:
            p = model.getParameter(pid)
            if p.constant:
                const_parameter_ids.append(pid)
        return const_parameter_ids


    #########################################################################
    # DataFrames
    #########################################################################

    def global_parameters_dataframe(self):
        """ Create GlobalParameter DataFrame. """
        return DataFrame({'value': self.model.getGlobalParameterValues()},
                         index=self.model.getGlobalParameterIds())


    def floating_species_dataframe(self):
        """ Create FloatingSpecies DataFrame. """
        return DataFrame({'concentration': self.model.getFloatingSpeciesConcentrations(),
                          'amount': self.model.getFloatingSpeciesAmounts()},
                         index=self.model.getFloatingSpeciesIds())


    def boundary_species_dataframe(self):
        """ Create BoundingSpecies DataFrame. """
        return DataFrame({'concentration': self.model.getBoundarySpeciesConcentrations(),
                          'amount': self.model.getBoundarySpeciesAmounts()},
                         index=self.model.getBoundarySpeciesIds())

    #########################################################################
    # Plotting
    #########################################################################
    @classmethod
    def plot_results(results, *args, **kwargs):
        """
        :param results: list of result matrices
        :return:
        """
        import matplotlib.pylab as plt

        plt.figure(figsize=(7, 4))
        for s in results:
            plt.plot(s[:, 0], s[:, 1:], *args, **kwargs)
            # print('tend:', s[-1, 0])
        # labels
        plt_fontsize = 30
        plt.xlabel('time [s]', fontsize=plt_fontsize)
        plt.ylabel('species [mM]', fontsize=plt_fontsize)
