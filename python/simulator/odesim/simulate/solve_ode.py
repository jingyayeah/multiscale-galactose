"""
Perform ode integrations.

"""

import time
from django.utils import timezone
import roadrunner
from roadrunner import SelectionRecord
from simapp.models import ParameterType, SettingKey, SimulationStatus, ResultType

from odesim.roadrunner import roadrunner_tools as rt
from odesim.simulate import io as ode_io
from odesim.simulate.solve import simulation_exception


def solve_roadrunner(simulations):
    """ Integrate simulations with RoadRunner. """
    time_start = time.time()
    try:
        # read SBML
        comp_model = simulations[0].task.model
        rr = rt.load_model(comp_model.filepath)
    except RuntimeError:
        for sim in simulations:
            simulation_exception(sim)
        raise

    # set RoadRunner settings
    # TODO: what are these settings
    # roadrunner.Config.setValue(roadrunner.Config.OPTIMIZE_REACTION_RATE_SELECTION, True)
    roadrunner.Config.setValue(roadrunner.Config.PYTHON_ENABLE_NAMED_MATRIX, False)

    # set the selection
    # this has to be provided from the outside
    sel = ['time'] \
        + ["".join(["[", item, "]"]) for item in rr.model.getBoundarySpeciesIds()] \
        + ["".join(["[", item, "]"]) for item in rr.model.getFloatingSpeciesIds()] \
        + [item for item in rr.model.getReactionIds() if item.startswith('H')]
    rr.selections = sel

    # use the integration settings (adapt absTol to amounts)
    settings = simulations[0].task.method.get_settings_dict()

    # sbml
    sbml_id = comp_model.model_id
    for sim in simulations:
        _solve_roadrunner_single(rr, sbml_id, sim, settings=settings)
    return rr


def _solve_roadrunner_single(rr, sbml_id, sim, settings):
    """ Solves a single roadrunner simulation.
    This function should never be called, because some important setup is necessary
    based on task levels, like for instance generating the necessary directory structure
    on the local machine.

    :param rr: RoadRunner instance with loaded model
    :param sbml_id:
    :param sim:
    :param settings:
    :return:
    """
    try:
        tstart_total = time.time()
        sim.time_assign = timezone.now()  # correction due to bulk assignment

        # make a concentration backup
        conc_backup = dict()
        # for sid in rr.model.getBoundarySpeciesIds():
        #    conc_backup[sid] = rr["[{}]".format(sid)]
        for sid in rr.model.getFloatingSpeciesIds():
            conc_backup[sid] = rr["[{}]".format(sid)]

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
            # print 'set', name, ' = ', p.value

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
        t_int = time.time() - tstart_int

        '''
        # Store CSV
        csv_file = ode_io.csv_file(sbml_id, sim)
        tmp = time.time()
        ode_io.save_csv(csv_file, data=s, header=rr.selections)
        tmp = time.time() - tmp
        print("CSV: {}".format(tmp))
        '''

        # Store in HDF5
        h5_file = ode_io.hdf5_file(sbml_id, sim)
        tmp = time.time()
        ode_io.save_hdf5(h5_file, data=s, header=rr.selections)
        tmp = time.time() - tmp
        ode_io.store_result_db(sim, filepath=h5_file, result_type=ResultType.HDF5)
        print("HDF5: {}".format(tmp))

        # reset parameter changes
        for key, value in changes.iteritems():
            rr.model[key] = value
        rr.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)

        # reset initial concentrations
        rr.reset()
        time_total = time.time()-tstart_total
        print('Time: [{:.3f}|{:.3f} |{:.2f}]'.format(time_total, t_int, t_int/time_total*100))

        # simulation finished
        sim.time_sim = timezone.now()
        sim.status = SimulationStatus.DONE
        sim.save()

    except:
        simulation_exception(sim)


if __name__ == "__main__":
    # TODO: refactor in test
    import django
    django.setup()

    from simapp.models import Simulation, Task
    # sim_ids = range(1,2)
    # sims = [Simulation.objects.get(pk=sid) for sid in sim_ids]

    task = Task.objects.get(pk=1)
    simulations = Simulation.objects.filter(task=task)

    print('* Start integration *')
    print('Simulation: ', simulations)
    solve_roadrunner(simulations)