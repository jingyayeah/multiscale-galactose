"""
Perform ode integration.
Can use different simulation backends like RoadRunner or COPASI.

"""
from __future__ import print_function
import sys
import traceback

from project_settings import MULTISCALE_GALACTOSE_RESULTS
from simapp.models import SimulatorType, SimulationStatus


class IntegrationException(Exception):
    pass


def run_simulations(simulations, task):
    """ Performs the simulations based on the given solver.
        Switches to the respective subcode for the individual solvers.
    """
    task.
    if integrator == SimulatorType.COPASI:
        integrate_copasi(simulations)
    elif integrator == SimulatorType.ROADRUNNER:
        integrate_roadrunner(simulations, keep_tmp)
    else:
        raise IntegrationException('Integrator not supported: {}'.format(integrator))


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




