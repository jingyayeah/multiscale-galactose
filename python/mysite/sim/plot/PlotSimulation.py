'''
Created on Mar 21, 2014
@author: Matthias Koenig

Class for generating plots from timecourses using matplotlib
'''
import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import matplotlib.pyplot as plt
from sim.models import Simulation, Timecourse, Plot, TIMECOURSE
import numpy as np
import csv
from django.core.exceptions import ObjectDoesNotExist
from django.core.files import File

def getColumns(inFile, delim="\t", header=True):
    """
    Get columns of data from inFile. The order of the rows is respected
    
    :param inFile: column file separated by delim
    :param header: if True the first line will be considered a header line
    :returns: a tuple of 2 dicts (cols, indexToName). cols dict has keys that 
    are headings in the inFile, and values are a list of all the entries in that
    column. indexToName dict maps column index to names that are used as keys in 
    the cols dict. The names are the same as the headings used in inFile. If
    header is False, then column indices (starting from 0) are used for the 
    heading names (i.e. the keys in the cols dict)
    """
    cols = {}
    indexToName = {}
    for lineNum, line in enumerate(inFile):
        if lineNum == 0:
            headings = line.split(delim)
            i = 0
            for heading in headings:
                heading = heading.strip()
                if header:
                    cols[heading] = []
                    indexToName[i] = heading
                else:
                    # in this case the heading is actually just a cell
                    cols[i] = [heading]
                    indexToName[i] = i
                i += 1
        else:
            cells = line.split(delim)
            i = 0
            for cell in cells:
                cell = float(cell.strip())
                cols[indexToName[i]] += [cell]
                i += 1
                
    return cols, indexToName


def getDataFromTimeCourse(tc):
    '''
    Read data from the timecourse csv and create a dictionary for 
    the individual variables. 
    '''
    filename = tc.file.path
    cols, indexToName = getColumns(open(filename, "rb"), delim=",", header=True)    
    return cols;
    
    
def createPlotPPPV(sim, folder):
    '''
    Create the periportal (PP), perivenious (PV) plots.
    
    Access the data via the x data dictionary via SBML ids.
    PP__gal = x['PP__gal']
    PV__gal = x['PV__gal']
    PP__rbcM = x['PP__rbcM']
    PV__rbcM = x['PV__rbcM']
    ''' 
    x = getDataFromTimeCourse(sim.timecourse)
    time = x['time']
    del x['time']
    
    # TODO: handle the colors of the plots, unified color schema for
    # ids
    
    for name, values in x.iteritems():
        # plot all the PP__ and PV__
        if (name.startswith("PP__") or name.startswith("PV__")):
            plt.plot(time, x[name])
    
    # plot all the PP and PV pairs
    plt.title("Simulation " + str(sim.pk))
    plt.ylabel('concentration [mM]')
    plt.xlabel('time [s]')
    plt.xlim([0, 80])
    plt.ylim([-0.1, 1.1])
    # plt.show()
    
    # scatter(X,Y, s=75, c=T, alpha=.5)

    # 
    # TODO save the plot in the static file
    filename = folder + "/" + sim.task.sbml_model.sbml_id + "_pppv.png"
    print filename
    plt.savefig(filename, dpi=48)
    print "Figure created"
    
    try:
        plot = Plot.objects.get(timecourse=sim.timecourse.pk)
        print 'Plot already exists'
    except ObjectDoesNotExist:
        print 'plot is created'
        f = open(filename, 'rb')
        plot = Plot(timecourse=sim.timecourse, plot_type=TIMECOURSE, file=File(f))
        plot.save()
        f.close()
    # show()
    
def createSimulationPlots(sim, folder):
    createPlotPPPV(sim, folder);
    
    
if __name__ == "__main__":
    folder = "/home/mkoenig/multiscale-galactose-results/test"
    sim = Simulation.objects.get(pk=40)
    createSimulationPlots(sim, folder);
    
