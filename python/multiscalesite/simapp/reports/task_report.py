"""
Creating report of the parameters of a given task.
Parameters of a single task are collected.

"""
from __future__ import print_function
import pandas as pd
from pandas import DataFrame


# TODO: refactor

import time
from simapp.models import Task

# Manage the files
def getParameterFilenameForTask(task, folder=None):
    """TODO: proper general paths"""
    if not folder:
        folder = "/home/mkoenig/multiscale-galactose-results/"

    mname = task.model.sbml_id
    return ''.join([folder, "/", str(task), "_", mname, "_parameters.csv"])


def createParameterFileForTask(task, folder=None):
    fname = getParameterFilenameForTask(task, folder=folder)
    f = file(fname, 'w')
    f.write(createParameterStringInfoForTask(task))
    f.close()
    return fname


def createParameterStringInfoForTask(task):
    data = createParameterInfoForTask(task)
    # create the content
    header = data.keys()
    lines = ['# ' + ", ".join(header)]
    for k in xrange(len(data['sim'])):
        lines +=  [", ".join([str(data[key][k]) for key in header])]
    return "\n".join(lines)



class TaskReport(object):
    def __init__(self, task):
        self.task = task

    def create_parameter_dataframe(self):
        """
        Simulation pk is stored in collection with other parameters.
        """
        # get all the parameter names
        header = set(['sim', 'status', 'core', 'duration'])
        set.add()
        d_sim = {}
        for sim in self.task.simulations.all():
            parameters = sim.parameters.all()
            d_sim[sim] = parameters
            header.add([p.key for p in parameters])

        print(d_sim)
        print(header)


        '''
        print 'Create Parameter File for: ', str(task)
        start = time.clock()
        # collect the parameters for the simulations
        data = dict()
        data['sim'] = []
        data['status'] = []
        data['core'] = []
        data['duration'] = []


        # TODO: make this faster by getting the related information
        for sim in task.simulations.all():
            data['sim'].append(sim.pk)
            data['status'].append(sim.status)
            data['core'].append(sim.core)
            data['duration'].append(sim.duration)
            # add all the parameters
            for p in sim.parameters.all():
                if data.has_key(p.key):
                    data[p.key].append(p.value)
                else:
                    data[p.key] = [p.value]

        # check that everything has the same length
        # this has to be guaranteed by the odesim generator
        for key in data.iterkeys():
            if len(data[key]) != len(data['sim']):
                print 'ERROR - wrong number of parameters'

        print 'time: ', (time.clock() - start)
        return data
        '''

if __name__ == "__main__":
    import django
    django.setup()

    from simapp.models import Task
    task = Task.objects.get(pk=32)
    task_report = TaskReport(task)
    task_report.create_parameter_dataframe()
