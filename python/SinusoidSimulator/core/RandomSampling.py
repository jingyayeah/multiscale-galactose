'''
Sampling of parameter distributions and generation of random 
samples for parameters (via LHS).

## Latin Hypercube sampling ##
# This 'multi-start' approach facilitates a broad coverage of the
# parameter search space in order to find the global optimum.
# Latin hypercube sampling [17] of the initial parameter guesses
# can be used to guarantee that each parameter estimation run
# starts in a different region in the high-dimensional parameter
# space. This method prohibits that randomly selected starting
# points are accidentally close to each other. Therefore, Latin
# hypercube sampling provides a better coverage of the space.
#
# Resampling ( https://en.wikipedia.org/wiki/Resampling_%28statistics%29 )
# Estimating the precision of sample statistics (medians, variances, percentiles) 
# by using subsets of available data (jackknifing) or drawing randomly with 
# replacement from a set of data points (bootstrapping).
# Validating models by using random subsets (bootstrapping, cross validation)
# approximate permutation test, Monte Carlo permutation tests or random permutation tests


Created on May 4, 2014
@author: Matthias Koenig
'''
import random
import numpy as np
import numpy.random as npr

def createDictFromKeysAndValues(keys, values):
    d = dict()
    for k in range(len(keys)):
        d[keys[k]] = values[k]
    return d

'''
    Samples N values from lognormal distribution defined by the 
    given means and standard deviations.
    Definition of the standard parameters from log_normal distributions 
    Needed for sampling from given distribution and for getting the ranges in 
    which to sample randomly or via LHS.
    TODO: load the data from table
    
    name    mean    std    unit    meanlog    meanlog_error    sdlog    sdlog_error    scale_fac    scale_unit    llb    lb    ub    uub
L    L    0.0005    0.000125    m    6.1842957875    NA    0.2462206771    NA    1000000    mum    0.0002735545    0.0003235323    0.0007272663    0.0008601362
y_sin    y_sin    0.0000044    0.00000045    m    1.4652733102    0.0102747149    0.1017144881    0.0072653206    1000000    mum    3.41661408543785E-006    3.66184773491691E-006    5.11705334498679E-006    5.48433909485203E-006
y_dis    y_dis    0.0000012    0.0000004    m    0.129641299    NA    0.324592846    NA    1000000    mum    0.000000535    6.67466270534705E-007    1.94167114835897E-006    2.42239610445859E-006
y_cell    y_cell    0.00000758    0.00000125    m    1.9769003149    0.0140416505    0.1390052478    0.0099289463    1000000    mum    5.22537074964775E-006    5.74458130584441E-006    9.07518350534687E-006    9.97692451113398E-006
flow_sin    flow_sin    0.00027    0.000058    m/s    5.4572075437    0.0267357281    0.6178209697    0.0189050147    1000000    mum/s    5.56978220298076E-005    8.48582723663428E-005    0.0006477032    0.0009868066

'''
cnames = ("name", "mean", "std", "unit", "meanlog", "meanlog_error", "sdlog", "sdlog_error", "scale_fac", "scale_unit", 'llb', 'lb', 'ub', 'uub')
data = dict()
data['L'] = createDictFromKeysAndValues(cnames, 
    ("L",     5.00e-04, 1.25e-04, "m", 6.1842958, "NA", 0.2462207, "NA", 1e+06, "mum", 0.0002735545,   0.0003235323,  0.0007272663, 0.0008601362))
data['y_sin'] = createDictFromKeysAndValues(cnames,
    ("y_sin", 4.40e-06, 4.50e-07, "m", 1.4652733, 0.01027471, 0.1017145, 0.007265321, 1e+06, "mum", 3.41661408543785E-6, 3.66184773491691E-006, 5.11705334498679E-006, 5.48433909485203E-006))
data['y_dis'] = createDictFromKeysAndValues(cnames,
    ("y_dis", 1.20e-06, 4.00e-07,  "m", 0.1296413, "NA", 0.3245928, "NA", 1e+06, "mum", 0.000000535, 6.67466270534705E-007, 1.94167114835897E-006, 2.42239610445859E-006))
data['y_cell'] = createDictFromKeysAndValues(cnames, 
    ("y_cell", 7.58e-06, 1.25e-06,  "m", 1.9769003, 0.01404165, 0.1390052, 0.009928946, 1e+06, "mum", 5.22537074964775E-006, 5.74458130584441E-006, 9.07518350534687E-006, 9.97692451113398E-006))
data['flow_sin'] = createDictFromKeysAndValues(cnames,
    ("flow_sin", 2.70e-04, 5.80e-05, "m/s", 5.4572075, 0.02673573, 0.6178210, 0.018905015, 1e+06, "mum/s", 5.56978220298076E-005, 8.48582723663428E-005, 0.0006477032, 0.0009868066))


def createSamplesByDistribution(N=10):
    '''
    Returns the parameter samples from the log-normal distributions.
    The generation of the database objects is performed in the SimulationFactory.
    '''
    samples = [];
    for kn in xrange(N):
        s = []
        for pid in data.keys():
            dtmp = data[pid]
            # m = means[kp]
            # std = stds[kp]
            # parameters are lognormal distributed 
            # mu = math.log(m**2 / math.sqrt(std**2+m**2));
            # sigma = math.sqrt(math.log(std**2/m**2 + 1));
            mu = dtmp['meanlog']
            sigma = dtmp['sdlog']
            # The fit parameter are for mum and mum/s, but parameters for the 
            # ode have to be provided in m and m/s.
            value = npr.lognormal(mu, sigma) * 1E-6   
            s.append( ( pid, value, dtmp['unit']) )
        
        samples.append(s)
    return samples

def createSamplesByLHS(N=10, ):
    '''
    Returns the parameter samples via LHS sampling.
    The boundaries of the samples are defined via the given distributions for the normal state.
    The lower and upper bounds have to account for the ranges with nonzero probability.
    '''
    # Get the LHS boundaries for all parameter dimensions and get
    # the values (always sample down to zero, the upper sample boundary
    # depends on the mean and sd of the values
    pointsLHS = dict()
    for pid in data.keys():
        dtmp = data[pid]
        minLHS = dtmp['llb'];           # 0.01
        maxLHS = dtmp['uub'];           # 0.99
        pointValues = calculatePointsByLHS(N, minLHS, maxLHS)
        random.shuffle(pointValues)
        pointsLHS[pid] = pointValues
    
    # put the LHS dimensions together
    samples = []
    for ks in xrange(N):
        s = []
        for pid in data.keys():
            pointValues = pointsLHS[pid]
            value = pointValues[ks]
            s.append( ( pid, value, dtmp['unit']) )
        samples.append(s)
    
    return samples



def calculatePointsByLHS(N, variableMax, variableMin):
    '''
        This is the 1D solution.
        Necessary to have the
        ! PointValues are in the order of the segments, which has to be taken into account 
        when generating the multi-dimensional LHS. 
    
        In Monte Carlo simulation, we want the entire distribution to be used evenly. 
        We usually use a large number of samples to reduce actual randomness, 
        but the latin hypercube sampling permits us to get the ideal randomness 
        without so much of a calculation.
        https://mathieu.fenniak.net/latin-hypercube-sampling/
        
        Latin hypercube sampling is capable of reducing the number of runs necessary 
        to stablize a Monte Carlo simulation by a huge factor. Some simulations may take 
        up to 30% fewer calculations to create a smooth distribution of outputs. 
        The process is quick, simple, and easy to implement. It helps ensure that the Monte Carlo simulation 
        is run over the entire length of the variable distributions, 
        taking even unlikely extremities into account as one would desire.
    '''
    segmentSize = 1/float(N)
    pointValues = []
    for i in range(N):
        # Get the random point
        segmentMin = float(i) * segmentSize
        # segmentMax = float(i+1) * segmentSize
        point = segmentMin + (random.random() * segmentSize)
        
        # Transform to the variable range
        pointValue = variableMin + point *(variableMax - variableMin)
        pointValues.append(pointValue)
    return pointValues

def createSamplesByManual():
    '''
    Manual parameter creation. Only sample L and flow_sin.
    '''
    samples = []
    # what parameters should be sampled
    flows = np.arange(0.0, 600E-6, 60E-6)
    lengths = np.arange(400E-6, 600E-6, 100E-6)
    for flow_sin in flows:
        for L in lengths: 
            s = []
            for pid in ("y_cell", "y_dis", "y_sin"):
                dtmp = data[pid];
                s.append( (dtmp['name'], dtmp['mean'],dtmp['unit']) )
            s.append( ('flow_sin', flow_sin, 'm/s') )
            s.append( ('L', L, 'm') )
                    
            samples.append(s)
    return samples


if __name__ == "__main__":
    # TODO: visualize the sampling for control
    # Use the general scripts for that.
    samples = createSamplesByManual()
    for s in samples:
        print s
    
    print '-' * 40
    samples = createSamplesByDistribution(N=5)
    for s in samples:
        print s
        
    print '-' * 40
    samples = createSamplesByLHS(N=5)
    for s in samples:
        print s    
    