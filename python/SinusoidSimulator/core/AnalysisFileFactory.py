'''
Created on Mar 23, 2014
@author: Matthias Koenig


'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import csv
from sim.models import Task, Simulation, ParameterCollection


def createParameterFileForTask(folder, task):
    # Write the parameter file for the task
    # Create csv
    
    # collect the parameters for the simulations
    data = dict()
    data['sim'] = []
    for sim in task.simulation_set.all():
        data['sim'].append(sim.pk)
        for p in sim.parameters.parameters.all():
            if data.has_key(p.name):
                data[p.name].append(p.value)
            else:
                data[p.name] = [p.value]
    # check that everything has the same length
    for key in data.iterkeys():
        if ( len(data[key]) != len(data['sim']) ):
            print 'ERROR - wrong number of parameters'
        
    
    fname = folder + "/T" + str(task.pk) + "_parameters.csv" 
    f = file(fname, 'w')
    writer = csv.writer(f, delimiter=",", quotechar='"')
    
    # write the header
    header = data.keys();
    print header
    writer.writerows([header,])
    for k in xrange(len(data['sim'])):
        tmp = [data[key][k] for key in header]
        writer.writerows([tmp,])
    f.close()
    
    
    


if __name__ == "__main__":
    task = Task.objects.get(pk=1);
    folder = "/home/mkoenig/multiscale-galactose-results"
    createParameterFileForTask(folder, task);
