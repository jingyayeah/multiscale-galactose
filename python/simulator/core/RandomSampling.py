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

def createParametersBySampling(dist_data, N, sampling):
    if (sampling == "distribution"):
        samples = createSamplesByDistribution(dist_data, N);
    elif (sampling == "LHS"):
        samples = createSamplesByLHS(dist_data, N);
    elif (sampling == "mean"):
        samples = createSamplesByMean(dist_data, N);
    elif (sampling == "mixed"):
        samples1 = createSamplesByDistribution(dist_data, N/2);
        samples2 = createSamplesByLHS(dist_data, N/2);
        samples = samples1 + samples2
        
    # TODO: adapt flow of samples
    samples = adaptFlowInSamples(samples)
    return samples

def adaptFlowInSamples(samples):
    # flow is adapted due to scaling to full liver architecture
    # TODO: make this consistent
    f_flow = 0.47
    for s in samples:
        if (s.has_key("flow_sin")):
            name, value, unit = s["flow_sin"];
            s["flow_sin"] = (name, value*f_flow, unit)
    return samples


def createSamplesByDistribution(dist_data, N=10):
    '''
    Returns the parameter samples from the log-normal distributions.
    The generation of the database objects is performed in the SimulationFactory.
    '''
    samples = [];
    for kn in xrange(N):
        s = dict()
        for pid in dist_data.keys():
            dtmp = dist_data[pid]
            # m = means[kp]
            # std = stds[kp]
            # parameters are lognormal distributed 
            # mu = math.log(m**2 / math.sqrt(std**2+m**2));
            # sigma = math.sqrt(math.log(std**2/m**2 + 1));
            mu = dtmp['meanlog']
            sigma = dtmp['sdlog']
            # The fit parameter are for mum and mum/s, but parameters for the 
            # ode have to be provided in m and m/s.
            # TODO: fix this -> the parameter have to be fitted to the actual values, 
            # no transformation which will break generality
            value = npr.lognormal(mu, sigma) * 1E-6   
            s[pid] = ( pid, value, dtmp['unit'])
        
        samples.append(s)
    return samples

def createSamplesByMean(dist_data, N=1):
    ''' Returns the mean parameters for the given distribution data. '''
    samples = [];
    for kn in xrange(N):
        s = dict()
        for pid in dist_data.keys():
            dtmp = dist_data[pid]
            value = dtmp['mean'] 
            s[pid] = (pid, value, dtmp['unit'])
        samples.append(s)
    return samples


def createSamplesByLHS(dist_data, N=10):
    '''
    Returns the parameter samples via LHS sampling.
    The boundaries of the samples are defined via the given distributions for the normal state.
    The lower and upper bounds have to account for the ranges with nonzero probability.
    '''
    # Get the LHS boundaries for all parameter dimensions and get
    # the values (always sample down to zero, the upper sample boundary
    # depends on the mean and sd of the values
    pointsLHS = dict()
    for pid in dist_data.keys():
        dtmp = dist_data[pid]
        minLHS = dtmp['llb'];           # 0.01
        maxLHS = dtmp['uub'];           # 0.99
        pointValues = calculatePointsByLHS(N, minLHS, maxLHS)
        random.shuffle(pointValues)
        pointsLHS[pid] = pointValues
    
    # put the LHS dimensions together
    samples = []
    for ks in xrange(N):
        s = dict()
        for pid in dist_data.keys():
            pointValues = pointsLHS[pid]
            value = pointValues[ks]
            s[pid] = (pid, value, dtmp['unit'])
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


def createSamplesByManual(dist_data):
    ''' Manual parameter creation. Only sample L and flow_sin. '''
    samples = []
    # what parameters should be sampled
    flows = np.arange(0.0, 600E-6, 60E-6)
    lengths = np.arange(400E-6, 600E-6, 100E-6)
    for flow_sin in flows:
        for L in lengths: 
            s = []
            for pid in ("y_cell", "y_dis", "y_sin"):
                dtmp = dist_data[pid];
                s.append( (dtmp['name'], dtmp['mean'],dtmp['unit']) )
            s.append( ('flow_sin', flow_sin, 'm/s') )
            s.append( ('L', L, 'm') )                    
            samples.append(s)
    return samples


if __name__ == "__main__":
    # TODO: visualize the sampling for control
    # Use the general scripts for that.
    from Distributions import getMultipleIndicatorDistributions
    dist_data = getMultipleIndicatorDistributions();
    samples = createSamplesByManual(dist_data)
    for s in samples:
        print s
    
    print '-' * 40
    samples = createSamplesByDistribution(dist_data, N=5)
    for s in samples:
        print s
        
    print '-' * 40
    samples = createSamplesByLHS(dist_data, N=5)
    for s in samples:
        print s
        
    print '#' * 40    
    from Distributions import getDemoDistributions
    dist_data = getDemoDistributions()
    samples = createSamplesByDistribution(dist_data, N=10)
    for s in samples:
        print s
    