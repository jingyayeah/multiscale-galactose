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
from simapp.models import ParameterType

# TODO: rename Sample -> ParameterCollection (??) , better naming
class SampleParameterException(Exception):
    ''' Exception for any problem with parameter samples. '''
    pass


class SampleParameter(object):
    ''' Class for storing key = value [unit] settings for simulation.
        The key corresponds to the identifier of the object to set and is
        in most cases an SBML SBase identifier. 
        Allowed types are the allowed parameter types defined in the 
        django model.
     '''
    def __init__(self, key, value, unit, ptype):
        ParameterType.check_type(ptype)
        
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
            return cls(p.key, p.value, p.unit, p.ptype)
    
    def __repr__(self):
        return "<{} = {:.3E} [{}] ({})>".model_format(self.key, self.value, 
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
        ParameterType.check_type(pset['ptype'])
            
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


##################################################################
if __name__ == "__main__":
    import django
    django.setup()
    
    from odesim.models.demo import create_demo_samples
    create_demo_samples(N=1, sampling="distribution")