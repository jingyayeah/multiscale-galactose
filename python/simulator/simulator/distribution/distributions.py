'''
Definition of parameter distributions.
Parameter distributions are optimally defined in csv files and loaded.

@author: Matthias Koenig
@date: 2014-12-12
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

#===============================================================================
# def defineGalactoseDistributions():
#     '''
#     Galactose model.
#     Samples N values from lognormal distribution defined by the 
#     given means and standard deviations.
#     Definition of the standard parameters from log_normal distributions 
#     Needed for sampling from given distribution and for getting the ranges in 
#     which to sample randomly or via LHS.
#     
#     name    mean    std    unit    meanlog    meanlog_error    sdlog    sdlog_error    scale_fac    scale_unit    llb    lb    ub    uub
#     L    L    0.0005    0.000125    m    6.1842957875    NA    0.2462206771    NA    1000000    mum    0.0002735545    0.0003235323    0.0007272663    0.0008601362
#     y_sin    y_sin    0.0000044    0.00000045    m    1.4652733102    0.0102747149    0.1017144881    0.0072653206    1000000    mum    3.41661408543785E-006    3.66184773491691E-006    5.11705334498679E-006    5.48433909485203E-006
#     y_dis    y_dis    0.0000012    0.0000004    m    0.129641299    NA    0.324592846    NA    1000000    mum    0.000000535    6.67466270534705E-007    1.94167114835897E-006    2.42239610445859E-006
#     y_cell    y_cell    0.00000758    0.00000125    m    1.9769003149    0.0140416505    0.1390052478    0.0099289463    1000000    mum    5.22537074964775E-006    5.74458130584441E-006    9.07518350534687E-006    9.97692451113398E-006
#     flow_sin    flow_sin    0.00027    0.000058    m/s    5.4572075437    0.0267357281    0.6178209697    0.0189050147    1000000    mum/s    5.56978220298076E-005    8.48582723663428E-005    0.0006477032    0.0009868066
#     '''
#     cnames = ("name", "mean", "std", "unit", "meanlog", "meanlog_error", "sdlog", "sdlog_error", "scale_fac", "scale_unit", 'llb', 'lb', 'ub', 'uub')
#     data = dict()
#     data['L'] = createDictFromKeysAndValues(cnames, 
#     ("L",     5.00e-04, 1.25e-04, "m", 6.1842958, "NA", 0.2462207, "NA", 1e+06, "mum", 0.0002735545,   0.0003235323,  0.0007272663, 0.0008601362))
#     data['y_sin'] = createDictFromKeysAndValues(cnames,
#     ("y_sin", 4.40e-06, 4.50e-07, "m", 1.4652733, 0.01027471, 0.1017145, 0.007265321, 1e+06, "mum", 3.41661408543785E-6, 3.66184773491691E-006, 5.11705334498679E-006, 5.48433909485203E-006))
#     data['y_dis'] = createDictFromKeysAndValues(cnames,
#     ("y_dis", 1.20e-06, 4.00e-07,  "m", 0.1296413, "NA", 0.3245928, "NA", 1e+06, "mum", 0.000000535, 6.67466270534705E-007, 1.94167114835897E-006, 2.42239610445859E-006))
#     data['y_cell'] = createDictFromKeysAndValues(cnames, 
#     ("y_cell", 7.58e-06, 1.25e-06,  "m", 1.9769003, 0.01404165, 0.1390052, 0.009928946, 1e+06, "mum", 5.22537074964775E-006, 5.74458130584441E-006, 9.07518350534687E-006, 9.97692451113398E-006))
#     data['flow_sin'] = createDictFromKeysAndValues(cnames,
#     ("flow_sin", 2.70e-04, 5.80e-05, "m/s", 5.4572075, 0.02673573, 0.6178210, 0.018905015, 1e+06, "mum/s", 5.56978220298076E-005, 8.48582723663428E-005, 0.0006477032, 0.0009868066))
# 
#     return data;
#===============================================================================


def getDemoDistributions():
    ''' Creates a distribution of the demo parameters '''
    cnames = ("name", "mean", "std", "unit")
    data = dict()
    
    # TODO: fix this problems due to fitting of parameters (no conversions)
    fac = 1E6
    
    key = 'Vmax_b1'
    data[key] = createDictFromKeysAndValues(cnames, 
        (key,  5.0*fac, 0.5*fac, "mole_per_s"))
    # add the meanlog and stdlog data calculated from normal distribution
    data[key]["meanlog"] = getMeanLog(data[key]["mean"], data[key]["std"])
    data[key]["sdlog"] = getSdLog(data[key]["mean"], data[key]["std"])
    
    key = 'Vmax_b2'
    data[key] = createDictFromKeysAndValues(cnames, 
        (key,  2.0*fac, 0.4*fac, "mole_per_s"))
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
    data = getGalactoseDistributions()
    for key, value in data.iteritems():
        print key, ':', value
    
    print '-' * 80
    data = readGalactoseDistributions()
    for key, value in data.iteritems():
        print key, ':', value
    
                                    