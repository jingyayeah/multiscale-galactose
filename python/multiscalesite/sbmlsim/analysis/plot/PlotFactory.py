'''
Create plots for the simulations to analyse.

Created on Jul 15, 2014

@author: mkoenig
'''

from subprocess import call
import shlex

import sim.PathSettings
from sim.models import Simulation, Timecourse, DONE
from sim.PathSettings import MULTISCALE_GALACTOSE_RESULTS, MULTISCALE_GALACTOSE


def simulationPlot(sid, sim_file, out_dir):
    ''' Call a R script to generate the basic plots '''
    print 'Generate simulation plot'
    
    # call the R scripts
    call_command = 'Rscript ' + MULTISCALE_GALACTOSE + '/R/analysis/makePlot.R ' + sim_file + ' ' + out_dir
    print call_command
    call(shlex.split(call_command))
    


if __name__ == '__main__':
    # generate the example plot
    sid = 497
    out_dir = MULTISCALE_GALACTOSE_RESULTS + '/tmp_plot'
    
    sim = Simulation.objects.get(pk=sid)
    if not sim.status == DONE:
        print 'no timecourse available'
    else:
        # problems if not on the server with database
        sim_file = sim.timecourse.file.path
        simulationPlot(sid, sim_file, out_dir)
    
    
    





