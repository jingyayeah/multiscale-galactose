'''
Created on Mar 21, 2014

@author: mkoenig
'''
import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import matplotlib.pyplot as plt



from sim.models import Simulation, Timecourse
import numpy as np
import csv

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
    

def plotSimulationData(data):
    '''
    Plot data for the simulation
    ''' 
    # TODO create all the variables from the names
    time = data['time']
    PP__gal = data['PP__gal']
    PV__gal = data['PV__gal']
    PP__rbcM = data['PP__rbcM']
    PV__rbcM = data['PV__rbcM']
    
    # plot all the PP and PV pairs
    plt.plot(time, PP__gal)
    plt.plot(time, PV__gal)
    plt.plot(time, PP__rbcM)
    plt.plot(time, PV__rbcM)
    
    plt.ylabel('concentration [mM]')
    plt.xlabel('time [s]')
    plt.show()
    
    X = data['time']
    Y = data['PV__gal']
    T = np.arctan2(Y,X)

    # axes([0.025,0.025,0.95,0.95])
    # scatter(X,Y, s=75, c=T, alpha=.5)

    # xlim(-1.5,1.5), xticks([])
    # ylim(-1.5,1.5), yticks([])
    # savefig('../figures/scatter_ex.png',dpi=48)
    # show()

    


if __name__ == "__main__":
    sim = Simulation.objects.get(pk=10)
    tc = sim.timecourse
    data = getDataFromTimeCourse(tc)
    plotSimulationData(data);