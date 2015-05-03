'''
Definition of parameter distributions.

Parameter distributions are optimally defined in csv files and loaded.
Parameters should be given in SI units (or at least in the units defined
in the SBML so that no additional conversions of units are necessary. 

TODO: support additional distributions. I.e. store the type of the 
      distribution and the corresponding parameters.
TODO: store the information in appropriate text format

@author: Matthias Koenig
@date: 2014-05-03
'''
from __future__ import print_function

import math
from path_settings import MULTISCALE_GALACTOSE

class DistException(Exception):
    pass

from enum import Enum
class DistType(Enum):
    CONSTANT = 0   # (mean) 
    NORMAL = 1     # (mena, log)
    LOGNORMAL = 2  # (meanlog, stdlog)
     
class Dist(object):
    ''' Class for handling the various distribution data. 
        For every distributed parameter one Dist object is
        generated.
    '''
    def __init__(self, dist_type, dist_pars):
        self.dtype = dist_type
        self.pars = dist_pars
        self.check()
        
    def check(self):
        ''' Check consistency of the defined distributions. '''
        if self.dtype == DistType.CONSTANT:
            if len(self.pars) != 1:
                raise DistException('Constant distribution has 1 parameter.')
            self.pars['mean']
            
        elif self.dtype == DistType.NORMAL:
            if len(self.pars) != 2:
                raise DistException('Normal distribution has 2 parameter.')
            self.pars['mean']
            self.pars['std']
            
        elif self.dtype == DistType.LOGNORMAL:
            if len(self.pars) != 2:
                raise DistException('LogNormal distribution has 2 parameter.') 
                print('fucking raise')   
            self.pars['meanlog']
            self.pars['stdlog']
            
        else:
            raise DistException('DistType not supported: {}'.format(self.dtype))

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
    ''' 
    Creates distribution of parameters for the demo network. 
    '''
    cnames = ("name", "mean", "std", "unit")
    data = dict()
        
    key = 'Vmax_b1'
    data[key] = _createDictFromKeysAndValues(cnames, 
        (key,  5.0, 0.5, "mole_per_s"))
    # add the meanlog and stdlog data calculated from normal distribution
    data[key]["meanlog"] = getMeanLog(data[key]["mean"], data[key]["std"])
    data[key]["sdlog"] = getSdLog(data[key]["mean"], data[key]["std"])
    
    key = 'Vmax_b2'
    data[key] = _createDictFromKeysAndValues(cnames, 
        (key,  2.0, 0.4, "mole_per_s"))
    # add the meanlog and stdlog data calculated from normal distribution
    data[key]["meanlog"] = getMeanLog(data[key]["mean"], data[key]["std"])
    data[key]["sdlog"] = getSdLog(data[key]["mean"], data[key]["std"])
    
    return data

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


    
                                    