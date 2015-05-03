'''
Tools to help analyze simulation series, i.e. simulations 
belonging to the same task.
Parameter files are generated based on the information in the database.
All simulations within a task must have set the same parameters, i.e.
for the unaltered case the unaltered parameters have to be set 
explicitly. This enforces coherrent simulation information within a 
task.

Created on Mar 23, 2014
@author: Matthias Koenig
'''


import time
from sbmlsim.models import Task

def getParameterFilenameForTask(task, folder=None):
    '''TODO: proper general paths'''
    if (not folder):
        folder = "/home/mkoenig/multiscale-galactose-results/"

    mname = task.sbml_model.sbml_id
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

def createParameterInfoForTask(task):
    '''
    Write the parameter file for the task.
    Simulation Id is stored in collection with the parameters.
    The problem is that within a task there can be different
    numbers of parameters set. It has to be guaranteed by the
    SimulationFactory.
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
    for sim in task.simulation_set.all():
        data['sim'].append(sim.pk)
        data['status'].append(sim.status)
        data['core'].append(sim.core)
        data['duration'].append(sim.duration)
        # add all the parameters
        for p in sim.parameters.all():
            if data.has_key(p.name):
                data[p.name].append(p.value)
            else:
                data[p.name] = [p.value]
    
    # check that everything has the same length
    # this has to be guaranteed by the simulation generator
    for key in data.iterkeys():
        if ( len(data[key]) != len(data['sim']) ):
            print 'ERROR - wrong number of parameters'
    
    print 'time: ', (time.clock() - start)
    return data
        
    
if __name__ == "__main__":
    import django
    django.setup()
    
    # write the parameter files
    folder = "/home/mkoenig/multiscale-galactose-results/"
    ids = (1, 2 )
    for task_id in ids:    
        task = Task.objects.get(pk=task_id);
        createParameterFileForTask(task, folder);
    