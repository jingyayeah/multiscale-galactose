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
from path_settings import MULTISCALE_GALACTOSE

from samples import SampleParameter



from enum import Enum
class DistType(Enum):
    CONSTANT = 0   # (mean) 
    NORMAL = 1     # (mena, log)
    LOGNORMAL = 2  # (meanlog, stdlog)

class DistParsType(Enum):
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
        self.check()
        
        if self.dtype == DistType.LOGNORMAL:
            # convert lognormal mean, std => meanlog and stdlog
            if dist_pars.get(DistParsType.MEAN) and dist_pars.get(DistParsType.STD):
                self.pars[DistParsType.STDLOG] = getMeanLog(self.pars[DistParsType.MEAN], 
                                                          self.pars[DistParsType.STD])
                self.pars[DistParsType.STDLOG] = getSdLog(self.pars[DistParsType.MEAN], 
                                                          self.pars[DistParsType.STD])
        self.check_parameters()
        
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
            if len(self.pars) != 2:
                raise Dist.DistException('LogNormal distribution has 2 parameter.')   
            self.pars[DistParsType.MEANLOG]
            self.pars[DistParsType.STDLOG]
            
        else:
            raise Dist.DistException('DistType not supported: {}'.format(self.dtype))

    def check_parameters(self):
        ''' Check consistency of parameters within distribution. '''
        key = self.pars[0].key
        for p in self.pars:
            if p.key != key:
                raise Dist.DistException('All parameters of distribution need same key')
            
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

from sbmlsim.models import GLOBAL_PARAMETER

def getDemoDistributions():
    ''' Example distributions for demo network. ''' 
    d1 = Dist(DistType.LOGNORMAL, {
                    'mean' : SampleParameter('Vmax_b1', 5.0, 'mole_per_s', GLOBAL_PARAMETER),
                    'std' : SampleParameter('Vmax_b1', 0.5, 'mole_per_s', GLOBAL_PARAMETER),
    })
    
    d2 = Dist(DistType.LOGNORMAL, {
                    'mean' : SampleParameter('Vmax_b2', 2.0, 'mole_per_s', GLOBAL_PARAMETER),
                    'std' : SampleParameter('Vmax_b2', 0.4, 'mole_per_s', GLOBAL_PARAMETER)
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

                        