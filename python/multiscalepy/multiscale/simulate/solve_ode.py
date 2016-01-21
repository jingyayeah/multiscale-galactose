"""
Perform ode integrations.
"""

import time

from django.utils import timezone
from roadrunner import SelectionRecord
from simapp.models import ParameterType, SettingKey, SimulationStatus, ResultType

import roadrunner_tools as rt
import solve
import solve_io


def solve_roadrunner(simulations):
    """
    Integrate simulations with RoadRunner.
    :param simulations: list of database simulations
    :return: None
    """
    try:
        # read SBML
        comp_model = simulations[0].task.model
        r = rt.MyRunner(comp_model.filepath)
    except RuntimeError:
        for sim in simulations:
            solve.simulation_exception(sim)
        raise

    # set the selection
    # TODO:  this has to be provided from the outside (must be part of the simulation), i.e.
    # which subparts are stored
    # TODO: check if this is up to date
    sel = ['time'] \
        + ["".join(["[", item, "]"]) for item in r.model.getBoundarySpeciesIds()] \
        + ["".join(["[", item, "]"]) for item in r.model.getFloatingSpeciesIds()] \
        + [item for item in r.model.getReactionIds() if item.startswith('H')]
    r.selections = sel

    # use the integration settings (adapt absTol to amounts)
    settings = simulations[0].task.method.get_settings_dict()
    sbml_id = comp_model.model_id
    for sim in simulations:
        _solve_roadrunner_single(r, sbml_id, sim, settings=settings)


def _solve_roadrunner_single(rr, sbml_id, sim, settings):
    """ Solves a single roadrunner simulation.
    This function should never be called, because some important setup is necessary
    based on task levels, like for instance generating the necessary directory structure
    on the local machine.

    :param rr: MyRunner instance with loaded model
    :param sbml_id:
    :param sim:
    :param settings:
    :return:
    """
    # TODO: refactor with roadrunner tools (as much logic as possible there)
    try:
        tstart_total = time.time()
        sim.time_assign = timezone.now()  # correction due to bulk assignment

        # make a concentration backup
        conc_backup = rr.store_concentrations()

        # set all parameters in the model and store the changes for revert
        changes = dict()
        for p in sim.parameters.all():
            if p.parameter_type == ParameterType.GLOBAL_PARAMETER:
                name = str(p.key)
                changes[name] = rr.model[name]
                rr.model[name] = p.value
                # print 'set', name, ' = ', p.value

        # recalculate the initial assignments
        rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)

        # restore initial concentrations
        for key, value in conc_backup.iteritems():
            rr.model['[{}]'.format(key)] = value

        # apply concentration changes
        for p in sim.parameters.all():
            if p.parameter_type in [ParameterType.NONE_SBML_PARAMETER, ParameterType.GLOBAL_PARAMETER]:
                continue

            name = str(p.key)
            if p.parameter_type == ParameterType.BOUNDARY_INIT:
                name = '[{}]'.format(name)
            elif p.parameter_type == ParameterType.FLOATING_INIT:
                name = 'init([{}])'.format(name)

            changes[name] = rr.model[name]
            rr.model[name] = p.value

        # ode integration
        tstart_int = time.time()
        if settings[SettingKey.VAR_STEPS]:
            s = rr.simulate(settings[SettingKey.T_START], settings[SettingKey.T_END],
                            absolute=settings[SettingKey.ABS_TOL] * min(rr.model.getCompartmentVolumes()),
                            relative=settings[SettingKey.REL_TOL],
                            variableStep=True, stiff=True)
        else:
            s = rr.simulate(settings[SettingKey.T_START], settings[SettingKey.T_END], steps=settings[SettingKey.STEPS],
                            absolute=settings[SettingKey.ABS_TOL] * min(rr.model.getCompartmentVolumes()),
                            relative=settings[SettingKey.REL_TOL],
                            variableStep=False, stiff=True)
        time_integration = time.time() - tstart_int

        '''
        # Store CSV
        csv_file = ode_io.csv_file(sbml_id, sim)
        tmp = time.time()
        ode_io.save_csv(csv_file, data=s, header=rr.selections)
        tmp = time.time() - tmp
        print("CSV: {}".format(tmp))
        '''

        # Store in HDF5
        h5_file = solve_io.hdf5_file(sbml_id, sim)
        solve_io.save_hdf5(h5_file, data=s, header=rr.selections)
        solve_io.store_result_db(sim, filepath=h5_file, result_type=ResultType.HDF5)

        # reset parameter changes
        for key, value in changes.iteritems():
            rr.model[key] = value
        rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)

        # reset initial concentrations
        rr.reset()

        # simulation finished
        sim.time_sim = timezone.now()
        sim.status = SimulationStatus.DONE
        sim.save()
        time_total = time.time()-tstart_total
        print('Time: [{:.4f}|{:.4f}]'.format(time_total, time_integration))

    except:
        solve.simulation_exception(sim)
