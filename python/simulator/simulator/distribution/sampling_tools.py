'''
Getting the samples from the simulations.

Created on Jul 29, 2014
@author: mkoenig
'''

import sim.PathSettings
from sim.models import Task, Simulation, Parameter

def get_samples_from_task(task):
    '''
    Reads all samples for the simulations in the task.
    '''
    sims = Simulation.objects.filter(task=task)
    samples = []
    for sim in sims:
        s = get_sample_from_simulation(sim)
        samples.append(s)
    return samples
    

def get_sample_from_simulation(sim):
    '''
    Reads the sample structure from the database, namely the
    parameters set for a simulation.
    Important to reuse the samples of a given task for another task.
    '''
    pars = Parameter.objects.filter(simulation=sim)
    s = dict()
    for p in pars:
        s[p.name] = (p.name, p.value, p.unit, p.ptype)
    return s
    

##################################################################
if __name__ == "__main__":
    task = Task.objects.get(pk=4)
    samples = get_samples_from_task(task)
    print samples
    
    from simulator.SimulationFactory import createDemoSamples
    for k in xrange(20):
        tmp = createDemoSamples(N=1, sampling="distribution")
        print tmp 
        