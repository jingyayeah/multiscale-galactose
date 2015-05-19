"""

@author: mkoenig
@date: 2015-??-?? 
"""

import sys
import os
import traceback

from simapp.models import SimulationStatus
from project_settings import MULTISCALE_GALACTOSE_RESULTS
# TODO: what is the difference between SIM_DIR and MULT... ? -> unify

class SimulationException(Exception):
    pass

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
