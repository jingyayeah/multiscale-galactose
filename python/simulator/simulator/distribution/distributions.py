'''
Definition of parameter distributions.

Parameter distributions are optimally defined in csv files and loaded.
Parameters should be given in SI units (or at least in the units defined
in the SBML so that no additional conversions of units are necessary. 

@author: Matthias Koenig
@date: 2014-01-05
'''

import math
from sim.PathSettings import MULTISCALE_GALACTOSE

def createDictFromKeysAndValues(keys, values):
    ''' helper function '''
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

def getGalactoseDistributions():
    return readGalactoseDistributions()

def readGalactoseDistributions():
    '''
    Reads the fitted distributions (lognormal)
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
            data[tokens[0]] = createDictFromKeysAndValues(header, tokens) 
    return data


def getDemoDistributions():
    ''' 
    Creates distribution of parameters for the demo network. 
    '''
    cnames = ("name", "mean", "std", "unit")
    data = dict()
        
    key = 'Vmax_b1'
    data[key] = createDictFromKeysAndValues(cnames, 
        (key,  5.0, 0.5, "mole_per_s"))
    # add the meanlog and stdlog data calculated from normal distribution
    data[key]["meanlog"] = getMeanLog(data[key]["mean"], data[key]["std"])
    data[key]["sdlog"] = getSdLog(data[key]["mean"], data[key]["std"])
    
    key = 'Vmax_b2'
    data[key] = createDictFromKeysAndValues(cnames, 
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
    print '-' * 80
    data = getGalactoseDistributions()
    for key, value in data.iteritems():
        print key, ':', value
    print '-' * 80    


    
                                    