'''
Getting the samples from the simulations.

Created on Jul 29, 2014
@author: mkoenig
'''

from sbmlsim.models import Task, Simulation, Parameter, check_parameter_type


class SampleParameterException(Exception):
    pass

class SampleParameter(object):
    '''
    Sample parameter defines the value of a single parameter.
    In most cases these parameters corresponds to parameters in an SBML. 
    Depending on the ptype different behavior can be implemented, for instance
    in the integration.
    key, value, unit correspond to id, value, unit in the SBML.
    '''        
    def __init__(self, key, value, unit, ptype):
        check_parameter_type(ptype)
        
        self.key = key
        self.value = value
        self.unit = unit
        self.ptype = ptype
            
    @classmethod
    def fromparameter(cls, p):
        ''' Works with SampleParameter or django parameter. '''
        if hasattr(p, 'key'):
            # Sample parameter
            return cls(p.key, p.value, p.unit, p.ptype)
        else:
            # Django parameter
            return cls(p.name, p.value, p.unit, p.ptype)
    
    def __repr__(self):
        return "<{} = {:.3E} [{}] ({})>".format(self.key, self.value, 
                                                self.unit, self.ptype)
    

class Sample(dict):
    ''' A sample is a collection of SampleParameters. '''
    def add_parameter(self, p):
        if not isinstance(p, SampleParameter):
            raise SampleParameterException
        self[p.key] = p
    
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
        s.add_parameter(SampleParameter.fromparameter(p))
    return s
    

##################################################################
if __name__ == "__main__":
    import django
    django.setup()
    
    # read samples from django
    task = Task.objects.get(pk=3)
    samples = get_samples_from_task(task)
    
    for k, value in enumerate(samples):
        print(k, value)
    
    
    from simulation.demo.demo import create_demo_samples
    create_demo_samples(N=1, sampling="distribution")