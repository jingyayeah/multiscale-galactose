'''
Create simulation plots from timecourses.

@author: Matthias Koenig
@date: 2015-04-20
'''

import path_settings

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from sbmlsim.models import Task, Plot, DONE


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


def createTaskPlots(task, folder):
    '''
    Create Histogramm of the Task parameters.
    '''    
    # get the parameter data for the task
    data = dict()
    for sim in task.simulation_set.all():
        for p in sim.parameters.parameters.all():
            if data.has_key(p.name):
                data[p.name].append(p.value)
            else:
                data[p.name] = [p.value]
    
    # create histogram for every parameter
    Np = len(data.keys())
    f, axarr = plt.subplots(1, Np)
    f.set_size_inches(Np*3, 3)
    num_bins = 20 
    for k, key in enumerate(data.keys()):
        x = data[key]
        axarr[k].hist(x, num_bins, normed=0, facecolor='green', alpha=0.5)
        axarr[k].set_title(key)
    
    '''
    m = 10.0;
    std = 5.0;
    mu = math.log(m**2 / math.sqrt(std**2+m**2));
    sigma = math.sqrt(math.log(std**2/m**2 + 1));
    x = npr.lognormal(mu, sigma, 400)
    num_bins = 20
    n, bins, patches = plt.hist(x, num_bins, normed=1, facecolor='green', alpha=0.5)
    plt.xlabel('Smarts')
    plt.ylabel('Probability')
    plt.title(r'Histogram of Task Parameters')
    '''
    
    filename = folder + "/" + task.sbml_model.sbml_id + "_T" + str(task.pk) + ".png"
    print filename
    plt.savefig(filename, dpi=720)
    print "Task Figure created"

    
def createPlotPPPV(sim, folder):
    '''
    Create the periportal (PP), perivenious (PV) plots.
    
    Access the data via the x data dictionary via SBML ids.
    PP__gal = x['PP__gal']
    PV__gal = x['PV__gal']
    PP__rbcM = x['PP__rbcM']
    PV__rbcM = x['PV__rbcM']
    ''' 
    if (sim.status != DONE):
        print "No timecourse available for simulation"
        return
    
    x = getDataFromTimeCourse(sim.timecourse)
    time = x['time']
    del x['time']
    
    fig = plt.figure()
    fig.set_size_inches(5, 5)
    
    # plot all the PP and PV pairs
    # TODO: handle the colors of the plots, unified color schema for
    # ids
    compounds = []
    for name, values in x.iteritems():
        if (name.startswith("PP__") or name.startswith("PV__")):
            sname = name[4:]
            if sname in compounds:
                continue
            compounds.append(sname)
            plt.plot(time, x['PP__'+sname], color='k')
            plt.plot(time, x['PV__'+sname], label=name)
    
    plt.legend(loc=1)
    
    plt.title("Simulation " + str(sim.pk))
    plt.ylabel('concentration [mM]')
    plt.xlabel('time [s]')
    plt.xlim([7, 80])
    plt.ylim([-0.1, 1.1])

    # scatter(X,Y, s=75, c=T, alpha=.5)

    filename = folder + "/" + sim.task.sbml_model.sbml_id + "_pppv.png"
    print filename
    plt.savefig(filename, dpi=72, bbox_inches='tight')
    print "Figure created"
    
    f = open(filename, 'rb')
    try:
        plot = Plot.objects.get(timecourse=sim.timecourse.pk)
        print 'Plot already exists'
        print 'Overwrite picture'
        plot.plot_type = TIMECOURSE
        plot.file = File(f)
        plot.save()
    except ObjectDoesNotExist:
        print 'plot is created'
        
        plot = Plot(timecourse=sim.timecourse, plot_type=TIMECOURSE, file=File(f))
        plot.save()
    
    f.close()
    # show()
    
def createSimulationPlots(sim, folder):
    createPlotPPPV(sim, folder);


    
if __name__ == "__main__":

    folder = "/home/mkoenig/multiscale-galactose-results/test"
    
    # sim = Simulation.objects.get(pk=40)
    # createSimulationPlots(sim, folder);
    
    task = Task.objects.get(pk=2)
    createTaskPlots(task, folder)
