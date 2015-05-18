"""
Perform ode integration.
Can use different simulation backends like RoadRunner or COPASI.

"""
from __future__ import print_function
import sys
import traceback

from project_settings import MULTISCALE_GALACTOSE_RESULTS
from simapp.models import SimulatorType, SimulationStatus, MethodType

class SimulationException(Exception):
    pass

def run_simulations(simulations, task):
    """ Performs the simulations based on the given solver.
        Switches to the respective subcode for the individual solvers.
    """
    # switch method and simulatorType
    if task.method_type == MethodType.FBA:
        solve_fba(simulations)
    elif task.method_type == MethodType.ODE:
        if task.integrator == SimulatorType.COPASI:
            # TODO: refactor the COPASI solver
            raise NotImplemented
            solve_copasi(simulations)
        elif task.integrator == SimulatorType.ROADRUNNER:
            solve_roadrunner(simulations)
    else:
        raise SimulationException('Method not supported: {}'.format(method_type))


def simulation_exception(sim):
    """ Handling exceptions in the integration. """
    print('-' *60)
    print('*** Exception in ODE integration ***')

    filepath = os.path.join(MULTISCALE_GALACTOSE_RESULTS, 'ERROR_{}.log'.format(sim.pk))
    with open(filepath, 'a') as f_err:
        traceback.print_exc(file=f_err)
    traceback.print_exc(file=sys.stdout)

    print('-'*60)

    # update simulation status
    sim.status = SimulationStatus.ERROR
    sim.save()

