"""
Subclass of RoadRunner with additional functionality.

Provides common functionality used in multiple simulation scenarios, like
- making selections
- timed simulations
- setting integrator settings
- setting values in model
- plotting
All simulations should be run via the MyRoadRunner class which provides
additional tests on the method.

Set of unittests provides tested functionality.
"""

from __future__ import print_function, division
import warnings
import libsbml
from roadrunner import RoadRunner, SelectionRecord
from pandas import DataFrame
from multiscale.util.timing import time_it


class MyRunner(RoadRunner):
    """
    Subclass of RoadRunner with additional functionality.
    """
    # TODO: the same init has to happen when a model is reloaded/loaded via
    # different means like load function
    @time_it(message="SBML compile")
    def __init__(self, *args, **kwargs):
        """
        See RoadRunner() information for arguments.
        :param args:
        :param kwargs:
        :return:
        """
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
    # Simulation
    #########################################################################
    # supported simulate options
    _simulate_args = frozenset(["start", "end", "steps", "selections"])

    @time_it()
    def simulate(self, *args, **kwargs):
        """ Timed simulate function. """
        for key in kwargs:
            assert(key in self._simulate_args)
        return RoadRunner.simulate(self, *args, **kwargs)

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
        # change parameters & recalculate initial assignments
        if len(parameters) > 0:
            concentrations = self.store_concentrations()
            changed = self._set_parameters(parameters)
            self.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
            self._set_concentrations(concentrations)

        # set changed concentrations
        if len(initial_concentrations) > 0:
            self._set_initial_concentrations(initial_concentrations)
        # set changed amounts
        if len(initial_amounts) > 0:
            self._set_initial_amounts(initial_amounts)

        if ("steps" in kwargs) and (self.getIntegrator().getValue('variable_step_size') == True):
            warnings.warn("steps provided in variable_step_size simulation !")

        # simulate (dangerous as long as simulate arguments not validated)
        s = self.simulate(**kwargs)

        if reset_parameters:
            self._set_parameters(changed)
            self.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)

        # simulation timecourse & global parameters for analysis
        return s, self.global_parameters_dataframe()

    #########################################################################
    # Setting & storing model values
    #########################################################################
    @classmethod
    def check_keys(cls, keys, key_type):
        import re
        if key_type == "INITIAL_CONCENTRATION":
            pattern = "^init\(\[\w+\]\)$"
        elif key_type == "INITIAL_AMOUNT":
            pattern = "^init\(\w+\)$"
        elif key_type == "CONCENTRATION":
            pattern = "^\[\w+\]$"
        elif key_type in ["AMOUNT", "PARAMETER"]:
            pattern = "^(?!init)\w+$"
        else:
            raise KeyError("Key type not supported.")

        for key in keys:
            assert(re.match(pattern, key))

    def store_concentrations(self):
        """
        Store FloatingSpecies concentrations of current model state.
        :return: {sid: ci} dictionary of concentrations
        """
        return {"[{}]".format(sid): self["[{}]".format(sid)] for sid in self.model.getFloatingSpeciesIds()}

    def store_amounts(self):
        """
        Store FloatingSpecies amounts of current model state.
        :return: {sid: ci} dictionary of amounts
        """
        return {sid: self[sid] for sid in self.model.getFloatingSpeciesIds()}

    def _set_values(self, value_dict):
        """
        Set values in model from {selection: value}.
        :return: {selection: original} returns dictionary of original values.
        """
        changed = dict()
        for key, value in value_dict.items():
            changed[key] = self[key]
            self[key] = value
        return changed

    def _set_parameters(self, parameters):
        """
        Set parameters in model from {sid: value}.
        :return: {sid: original} returns dictionary of original values.
        """
        self.check_keys(parameters.keys(), "PARAMETER")
        return self._set_values(parameters)

    def _set_initial_concentrations(self, concentrations):
        """
        Set initial concentration in model from {init([sid]): value}.
        :return: {init([sid]): original} returns dictionary of original values.
        """
        self.check_keys(concentrations.keys(), "INITIAL_CONCENTRATION")
        return self._set_values(concentrations)

    def _set_concentrations(self, concentrations):
        """
        Set concentrations in model from {[sid]: value}.
        :return: {[sid]: original} returns dictionary of original values.
        """
        self.check_keys(concentrations.keys(), "CONCENTRATION")
        return self._set_values(concentrations)

    def _set_initial_amounts(self, amounts):
        """
        Set initial amounts in model from {init(sid): value}.
        :return: {init(sid): original} returns dictionary of original values.
        """
        self.check_keys(amounts.keys(), "INITIAL_AMOUNT")
        return self._set_values(amounts)

    def _set_amounts(self, amounts):
        """
        Set amounts in model from {sid: value}.
        :return: {sid: original} returns dictionary of original values.
        """
        self.check_keys(amounts.keys(), "AMOUNT")
        return self._set_values(amounts)

    #########################################################################
    # Helper for units & selections
    #########################################################################
    # TODO: create some frozenset for fast checking
    # self.parameters = frozenset(self.)

    def selections_floating_concentrations(self):
        """
        Set floating concentration selections in RoadRunner.
            list[str] of selections for time, [c1], ..[cN]
        """
        self.selections = ['time'] + ['[{}]'.format(s) for s in self.model.getFloatingSpeciesIds()]

    def selections_floating_amounts(self):
        """
        Set floating amount selections in RoadRunner.
            list[str] of selections for time, c1, ..cN
        """
        self.selections = ['time'] + self.model.getFloatingSpeciesIds()


    def get_global_constant_parameters(self):
        """ Subset of global parameters which are constant.
            Set of parameter which has constant values and is not calculated
            based on an initialAssignment.
        """
        # All global parameters which are constant have to be varied.
        parameter_ids = self.model.getGlobalParameterIds()
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
    # TODO: create DataFrames of full information
    def global_parameters_dataframe(self):
        """ Create GlobalParameter DataFrame. """
        # TODO: add the units, constant, ..., assignmentRules
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
