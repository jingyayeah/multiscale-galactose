'''
Create plots for the simulations to analyse.

Created on Jul 15, 2014

@author: mkoenig
'''

from subprocess import call
import shlex

import project_settings
from simapp.models import Simulation, DONE


def simulationPlot(sid, sim_file, out_dir):
    ''' Call a R script to generate the basic plots '''
    print 'Generate odesim plot'
    
    # call the R scripts
    call_command = 'Rscript ' + project_settings.MULTISCALE_GALACTOSE + '/R/analysis/makePlot.R ' + sim_file + ' ' + out_dir
    print call_command
    call(shlex.split(call_command))
    


if __name__ == '__main__':
    # generate the example plot
    sid = 497
    out_dir = project_settings.MULTISCALE_GALACTOSE_RESULTS + '/tmp_plot'
    
    sim = Simulation.objects.get(pk=sid)
    if not sim.status == DONE:
        print 'no timecourse available'
    else:
        # problems if not on the server with database
        sim_file = sim.timecourse.file.path
        simulationPlot(sid, sim_file, out_dir)
    
    
    





