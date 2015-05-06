'''
Definition of parameter distributions.

Parameter distributions are used for generating samples of the model.
A sample is a combination of parameters to be set in the model.
Only terminal parameters can be set in the model currently, i.e. 
SBML parameters which are constant and not calculated by an 
initial assignment. 

Parameter distributions are defined in the best case scenario
in an external file, for instance csv and loaded from this source.
An important part is that the units of the parameter distribution have
to be identical to the units of the actual parameter being set, i.e. 
the parameter distributions have to fit to the actual parameters in 
the model.
Parameters should be given in SI units (but have to be at least the units defined
in the SBML so that no additional conversions of units are necessary. 

TODO: support additional distributions. I.e. store the type of the 
      distribution and the corresponding parameters.
TODO: store the information in appropriate text format

The parameter files for the distribution should look the following:


@author: Matthias Koenig
@date: 2014-05-04
'''
from __future__ import print_function

import math
import numpy as np
        
from project_settings import MULTISCALE_GALACTOSE

from samples import SampleParameter

from util.util_classes import EnumType, Enum

class DistType(EnumType, Enum):
    CONSTANT = 0   # (mean) 
    NORMAL = 1     # (mena, log)
    LOGNORMAL = 2  # (meanlog, stdlog)


class DistParsType(EnumType, Enum):
    MEAN = 0  
    STD = 1    
    MEANLOG = 2 
    STDLOG = 3

     
class Dist(object):
    ''' Class for handling the various distribution data. 
        For every distributed parameter one Dist object is
        generated.
            
        TODO: add support for sample generation from distribution
    '''
    class DistException(Exception): pass
    
    def __init__(self, dist_type, dist_pars):
        self.dtype = dist_type
        self.pars = dist_pars

        if self.dtype == DistType.LOGNORMAL:
            self.convert_lognormal_mean_std()
                
        self.check()
        self.check_parameters()
    
    @property
    def key(self):
        ''' Return the common key of the parameters, i.e. the 
            key of the parameter which is influenced by the distribution. '''
        return self.pars.values()[0].key
    
    @property
    def unit(self):
        return self.pars.values()[0].unit
    
    @property
    def ptype(self):
        return self.pars.values()[0].ptype
    
    def samples(self, N=1):
        ''' Create samples from the distribution. '''        
        if self.dtype == DistType.CONSTANT:
            data = self.pars[DistParsType.MEAN].value * np.ones(N)
            
        elif self.dtype == DistType.NORMAL:
            data = np.random.normal(self.pars[DistParsType.MEAN].value,
                                    self.pars[DistParsType.STD].value, 
                                    N)
                
        elif self.dtype == DistType.LOGNORMAL:
            data = np.random.lognormal(self.pars[DistParsType.MEANLOG].value,
                                       self.pars[DistParsType.STDLOG].value, 
                                       N)
        else:
            raise Dist.DistException('DistType not supported: {}'.format(self.dtype))
        
        if N == 1:
            return data[0]
        return data
        
    def mean(self):
        ''' Mean value of distribution for mean sampling. '''
        if self.dtype in (DistType.CONSTANT, DistType.NORMAL, DistType.LOGNORMAL):
            return self.pars[DistParsType.MEAN].value
        else:
            raise Dist.DistException('DistType not supported: {}'.format(self.dtype))
    
    def convert_lognormal_mean_std(self):
        ''' Convert lognormal mean, std => meanlog and stdlog. '''
        if self.pars.has_key(DistParsType.MEAN) and self.pars.has_key(DistParsType.STD):
            # get the old sample parameter
            sp_mean = self.pars[DistParsType.MEAN]
            sp_std = self.pars[DistParsType.STD]
            # calculate meanlog and stdlog
            meanlog = getMeanLog(sp_mean.value, sp_std.value)
            stdlog =  getSdLog(sp_mean.value, sp_std.value)
            # store new parameters
            self.pars[DistParsType.MEANLOG] = SampleParameter(sp_mean.key, meanlog,
                                                                  sp_mean.unit, sp_mean.ptype)
            self.pars[DistParsType.STDLOG] = SampleParameter(sp_std.key, stdlog,
                                                                  sp_std.unit, sp_std.ptype) 
            # remove old paramters
            # del self.pars[DistParsType.MEAN]
            # del self.pars[DistParsType.STD]
    
    def check(self):
        ''' Check consistency of the defined distributions. '''
        if self.dtype == DistType.CONSTANT:
            if len(self.pars) != 1:
                raise Dist.DistException('Constant distribution has 1 parameter.')
            self.pars[DistParsType.MEAN]
            
        elif self.dtype == DistType.NORMAL:
            if len(self.pars) != 2:
                raise Dist.DistException('Normal distribution has 2 parameter.')
            self.pars[DistParsType.MEAN]
            self.pars[DistParsType.STD]
            
        elif self.dtype == DistType.LOGNORMAL:
            if len(self.pars) < 2:
                raise Dist.DistException('LogNormal distribution has 2 parameter.')   
            self.pars[DistParsType.MEANLOG]
            self.pars[DistParsType.STDLOG]
            
        else:
            raise Dist.DistException('DistType not supported: {}'.format(self.dtype))

    def check_parameters(self):
        ''' Check consistency of parameters within distribution. '''
        # check that the keys are identical for all parameters in distribution
        key = None
        unit = None
        ptype = None
        for p in self.pars.values():
            if not key:
                key = p.key
                unit = p.unit
                ptype = p.ptype
                continue
            if p.key != key:
                raise Dist.DistException('All parameters of distribution need same key')
            if p.unit != unit:
                raise Dist.DistException('All parameters of distribution need same unit')
            if p.ptype != ptype:
                raise Dist.DistException('All parameters of distribution need same ptype')
            
        if self.dtype == DistType.CONSTANT:
            pass
            
        elif self.dtype == DistType.NORMAL:
            pass
            
        elif self.dtype == DistType.LOGNORMAL:
            pass
        
    def __repr__(self):
        return '{} : {}'.format(self.dtype, self.pars)



def getGalactoseDistributions():
    return _readGalactoseDistributions()

def _readGalactoseDistributions():
    ''' Reads the fitted distributions (lognormal)
    '''
    fname = MULTISCALE_GALACTOSE + '/results/distributions/distribution_fit_data.csv'
    with open(fname) as f:
        data = dict()
        header = []
        for k, line in enumerate(f.readlines()):
            if (k==0):
                tokens = [t.strip() for t in line.split(',')]
                header = tokens[1:]
                continue
            
            tokens = [t.strip() for t in line.split(',')]
            tokens = tokens[1:]
            data[tokens[0]] = _createDictFromKeysAndValues(header, tokens) 
    return data

def _createDictFromKeysAndValues(keys, values):
    ''' Helper function for creating the dictionary. '''
    d = dict()
    for k in range(len(keys)):
        key = keys[k]
        value = values[k]
        if value == 'NA':
            value = None
        if (value and (key not in ['name', 'unit', 'scale_unit'])):
            value = float(value)
            # value = values[k]
        d[key] = value
    return d



def getDemoDistributions():
    from sbmlsim.models import ParameterType    
    ''' Example distributions for demo network. ''' 
    d1 = Dist(DistType.LOGNORMAL, {
                    DistParsType.MEAN : SampleParameter('Vmax_b1', 5.0, 'mole_per_s', 
                                                        ParameterType.GLOBAL_PARAMETER),
                    DistParsType.STD : SampleParameter('Vmax_b1', 0.5, 'mole_per_s', 
                                                        ParameterType.GLOBAL_PARAMETER),
    })
    
    d2 = Dist(DistType.LOGNORMAL, {
                    DistParsType.MEAN : SampleParameter('Vmax_b2', 2.0, 'mole_per_s', 
                                                        ParameterType.GLOBAL_PARAMETER),
                    DistParsType.STD : SampleParameter('Vmax_b2', 0.4, 'mole_per_s', 
                                                        ParameterType.GLOBAL_PARAMETER)
    })
    return (d1, d2)

def _readDemoDistributions():
    pass

def getMeanLog(mean, std):
    return math.log(mean**2 / math.sqrt(std**2+mean**2));

def getSdLog(mean, std):
    return math.sqrt(math.log(std**2/mean**2 + 1));

################################################################################

if __name__ == "__main__":
    print('-' * 80)
    data = getGalactoseDistributions()
    for key, value in data.iteritems():
        print(key, ':', value)
    print('-' * 80)    

    print('-' * 80)
    dists = getDemoDistributions()
    for d in dists: 
        print(d)
    print('-' * 80)
    print(getMeanLog(2.0, 0.4))
    print(getSdLog(2.0, 0.4))
                        