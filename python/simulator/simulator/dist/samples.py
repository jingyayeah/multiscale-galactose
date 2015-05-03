'''
Getting the samples from the simulations.

Created on Jul 29, 2014
@author: mkoenig
'''

from sbmlsim.models import Task, Simulation, Parameter, check_parameter_type


class SampleParameterException(Exception):
    pass


class SampleParameter(object):        
    def __init__(self, name, value, unit, ptype):
        check_parameter_type(ptype)
        
        self.name = name
        self.value = value
        self.unit = unit
        self.ptype = ptype
            
    @classmethod
    def fromparameter(cls, p):
        ''' Works with SampleParameter or django parameter. '''
        return cls(p.name, p.value, p.unit, p.ptype)
    
    def __repr__(self):
        return "<SampleParameter {} = {}{} ({})>".format(self.name, self.value, self.unit, self.ptype)
    

class Sample(dict):
    ''' A sample is a collection of SampleParameters. '''
    def add_parameter(self, p):
        if not isinstance(p, SampleParameter):
            raise SampleParameterException
        self[p.name] = p
    
    def get_parameter(self, key):
        return self[key]

    

def get_samples_from_task(task):
    ''' Returns all samples for simulations for given task. '''
    sims = Simulation.objects.filter(task=task)
    return [get_sample_from_simulation(sim) for sim in sims]
    

def get_sample_from_simulation(sim):
    '''
    Reads the sample structure from the database, namely the
    parameters set for a simulation.
    Important to reuse the samples of a given task for another task.
    '''
    pars = Parameter.objects.filter(simulation=sim)
    s = Sample()
    for p in pars:
        s.add_parameter(SampleParameter(p.name, p.value, p.unit, p.ptype))
    return s
    
    
    

##################################################################
if __name__ == "__main__":
    import django
    django.setup()
    
    task = Task.objects.get(pk=3)
    samples = get_samples_from_task(task)
    print samples
    
    """
    from simulator.SimulationFactory import createDemoSamples
    for k in xrange(20):
        tmp = createDemoSamples(N=1, sampling="distribution")
        print tmp 
    """ 