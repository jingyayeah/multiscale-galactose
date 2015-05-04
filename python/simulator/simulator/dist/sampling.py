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


@author:   Matthias Koenig
@date:     2015-01-05
'''
import random
import numpy.random as npr

from sbmlsim.models import GLOBAL_PARAMETER
from samples import Sample, SampleParameter

def createParametersBySampling(dist_data, N, sampling, keys=None):
    '''
    Master function which switches between methods to create
    the samples. This function should be called from 
    other modules.
    '''
    if (sampling == "distribution"):
        samples = _createSamplesByDistribution(dist_data, N, keys);
    elif (sampling == "LHS"):
        samples = _createSamplesByLHS(dist_data, N, keys);
    elif (sampling == "mean"):
        samples = _createSamplesByMean(dist_data, N, keys);
    elif (sampling == "mixed"):
        samples1 = _createSamplesByDistribution(dist_data, N/2, keys);
        samples2 = _createSamplesByLHS(dist_data, N/2, keys);
        samples = samples1 + samples2
    return samples

def _createSamplesByDistribution(dist_data, N, keys=None):
    '''
    Returns the parameter samples from the log-normal distributions.
    All parameters defined in the distributions are sampled.
    If keys are provided, only the subset existing in keys is sampled.
    The generation of the database objects is performed in the SimulationFactory.
    '''
    samples = [];
    for _ in xrange(N):
        s = Sample()
        for pid in dist_data.keys():
            if keys and (pid not in keys):
                continue
            dtmp = dist_data[pid]            
            mu = dtmp['meanlog']
            sigma = dtmp['sdlog']
            # all values are in 'unit'
            value = npr.lognormal(mu, sigma)
            sp = SampleParameter(pid, value, 
                                 unit=dtmp['unit'], ptype=GLOBAL_PARAMETER) 
            s.add_parameter(sp)
        samples.append(s)
    return samples

def _createSamplesByMean(dist_data, N=1, keys=None):
    ''' 
    Returns mean parameters for the given distribution data. 
    '''
    samples = [];
    for _ in xrange(N):
        s = Sample()
        for pid in dist_data.keys():
            if keys and (pid not in keys):
                continue
            dtmp = dist_data[pid]
            value = dtmp['mean'] 
            s.add_parameter(SampleParameter(pid, value, 
                                            unit=dtmp['unit'], ptype=GLOBAL_PARAMETER))
        samples.append(s)
    return samples


def _createSamplesByLHS(dist_data, N, keys=None):
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
        if keys and (pid not in keys):
            continue
        dtmp = dist_data[pid]
        minLHS = dtmp['llb'];           # 0.01
        maxLHS = dtmp['uub'];           # 0.99
        pointValues = calculatePointsByLHS(N, minLHS, maxLHS)
        random.shuffle(pointValues)
        pointsLHS[pid] = pointValues
    
    # put the LHS dimensions together
    samples = []
    for ks in xrange(N):
        s = Sample()
        for pid in dist_data.keys():
            if keys and (pid not in keys):
                continue
            pointValues = pointsLHS[pid]
            value = pointValues[ks]
            s.add_parameter(SampleParameter(pid, value, 
                                         dtmp['unit'], GLOBAL_PARAMETER))
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





##########################################################################################

if __name__ == "__main__":

    from distributions import getGalactoseDistributions
    dist_data = getGalactoseDistributions()
    
    print '-' * 40
    samples = _createSamplesByDistribution(dist_data, N=5)
    for s in samples:
        print s
    
    print '-' * 40
    samples = _createSamplesByMean(dist_data, N=5)
    for s in samples:
        print s
        
    print '-' * 40
    samples = _createSamplesByLHS(dist_data, N=5)
    for s in samples:
        print s
        
    print '#' * 40    
    from distributions import getDemoDistributions
    dist_data = getDemoDistributions()
    samples = _createSamplesByDistribution(dist_data, N=10)
    for s in samples:
        print s
    