'''
Created on Mar 23, 2014
@author: Matthias Koenig

Tools to help analyse series of Simulations, i.e. simulations
which belong to the same task.

Here simulations are collected from the database and the 
parameter files written for the simulations.
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import csv
from sim.models import Task

def createParameterFileForSeries(folder, task):
    '''
    Write the parameter file for the series. 
    '''
    # TODO: implement
    pass



def createParameterFileForTask(folder, task):
    '''
    Write the parameter file for the task.
    Simulation Id is stored in collection with the parameters.
    The problem is that within a task there can be different
    numbers of parameters set. It has to be guaranteed by the
    SimulationFactory.
    '''
    print "Create parameter file: ", task
    # collect the parameters for the simulations
    data = dict()
    data['sim'] = []
    data['status'] = []
    data['core'] = []
    data['duration'] = []
    for sim in task.simulation_set.all():
        data['sim'].append(sim.pk)
        data['status'].append(sim.status)
        data['core'].append(sim.core)
        data['duration'].append(sim.duration)
        for p in sim.parameters.parameters.all():
            if data.has_key(p.name):
                data[p.name].append(p.value)
            else:
                data[p.name] = [p.value]
    
    # check that everything has the same length
    # this has to be guaranteed by the simulation generator
    for key in data.iterkeys():
        if ( len(data[key]) != len(data['sim']) ):
            print 'ERROR - wrong number of parameters'
        
    # create csv writer
    mname = task.sbml_model.sbml_id
    fname = folder + "/T" + str(task.pk) + "_" + mname + "_parameters.csv" 
    f = file(fname, 'w')
    writer = csv.writer(f, delimiter=",", quotechar='"')
    
    # write the csv
    header = data.keys();
    print header
    writer.writerows([header,])
    for k in xrange(len(data['sim'])):
        tmp = [data[key][k] for key in header]
        writer.writerows([tmp,])
    f.close()
    
    
    

if __name__ == "__main__":
    folder = "/home/mkoenig/multiscale-galactose-results/2014-04-30_MultipleIndicator/"

    ids = range(11,16)
    for task_id in ids:    
        task = Task.objects.get(pk=task_id);
        createParameterFileForTask(folder, task);
    
    