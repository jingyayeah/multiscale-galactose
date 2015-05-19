"""
Perform ode integration.
Can use different simulation backends like RoadRunner or COPASI.

"""
from __future__ import print_function


from simapp.models import SimulatorType, MethodType
from odesim.simulate.solve_fba import solve_fba
from odesim.simulate.solve_io import create_simulation_directory
from odesim.simulate.solve_ode import solve_roadrunner

def run_simulations(simulations, task):
    """ Performs the simulations based on the given solver.
        Switches to the respective subcode for the individual solvers.
    """
    # switch method and simulatorType
    create_simulation_directory(task)

    if task.method_type == MethodType.FBA:
        solve_fba(simulations)
    elif task.method_type == MethodType.ODE:
        if task.integrator == SimulatorType.COPASI:
            raise NotImplemented
            # solve_ode.solve_copasi(simulations)
        elif task.integrator == SimulatorType.ROADRUNNER:
            solve_roadrunner(simulations)
    else:
        raise SimulationException('Method not supported: {}'.format(method_type))




