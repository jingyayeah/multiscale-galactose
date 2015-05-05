'''
Creating and managing Samples and the SampleParameters for simulations.

 Sample parameter defines the value of a single parameter.
    In most cases these parameters corresponds to parameters in an SBML. 
    Depending on the ptype different behavior can be implemented, for instance
    in the integration.
    key, value, unit correspond to id, value, unit in the SBML.

@author: Matthias Koenig
@date: 2015-05-05
'''
from __future__ import print_function
from sbmlsim.models import Task, Simulation, Parameter, check_parameter_type


class SampleParameterException(Exception):
    ''' Exception for any problem with parameter samples. '''
    pass


class SampleParameter(object):
    ''' Single parameter value definition. Samples are dicts
        of multiple SampleParameters. '''
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
    
    @property
    def parameters(self):
        return self.values()
    
    @classmethod
    def set_parameter_in_samples(cls, sample_par, samples):
        ''' Set SampleParameter in all samples.
            Is SampleParameter with given key already exists it is overwritten. '''
        for s in samples:
            s.add_parameter(sample_par)
        return samples


from copy import deepcopy

def deepcopy_samples(samples):
    ''' Returns a deepcopy of the list of samples. 
        Required for the creation of derived samples 
        TODO: is this working ?
    '''
    return deepcopy(samples)


def setParameterValuesInSamples(raw_samples, p_list):
    ''' ? how is the p_list structured ? '''
    for pset in p_list:
        check_parameter_type(pset['ptype'])
            
    Np = len(p_list)                # numbers of parameters to set
    Nval = len(p_list[0]['values']) # number of values from first p_dict
    
    samples = []
    for s in raw_samples:
        for k in range(Nval):
            # make a copy of the dictionary
            snew = s.copy()
            # set all the information
            for i in range(Np):
                p_dict = p_list[i]
                snew[p_dict['pid']] = (p_dict['pid'], p_dict['values'][k], p_dict['unit'], p_dict['ptype'])
            samples.append(snew)
    return samples


# TODO refactor this
from sbmlsim.models import SBMLModel, Task, Simulation, Parameter
from sbmlsim.models import UNASSIGNED


from django.db import transaction

@transaction.atomic
def createSimulationsForSamples(task, samples):
    ''' Creates the simulation for a given sample.
    Does not check if the odesim already exists.
    - creates the Parameters
    - creates empty odesim and adds the parameters.
    Function does not check if the odesim with given parameters
    already exists.
    TODO: create in one transaction.
    '''
    
    # bulk create simulations
    # sims_list = [Simulation(task=task, status=UNASSIGNED) for k in xrange(samples)]
    # Simulation.objects.bulk_create(sims_list)
    
    sims = []
    for sample in samples:
        sim = Simulation(task=task, status=UNASSIGNED)
        parameters = []
        for sp in sample.parameters:
            # This takes forever to check if parameter already in db
            p, _ = Parameter.objects.get_or_create(name=sp.key, value=sp.value, unit=sp.unit, ptype=sp.ptype);
            parameters.append(p)
        
        # sim = sims_list[k]
        sim.parameters.add(*parameters)
        sims.append(sim)
        print(sim)
        
    return sims




def get_samples_from_task(task):
    ''' Returns all samples for simulations for given task. '''
    sims = Simulation.objects.filter(task=task)
    return [get_sample_from_simulation(sim) for sim in sims]
    

def get_sample_from_simulation(sim):
    '''
    Reads the sample structure from the database, namely the
    parameters set for a odesim.
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
    
    
    from odesim.models.demo import create_demo_samples
    create_demo_samples(N=1, sampling="distribution")