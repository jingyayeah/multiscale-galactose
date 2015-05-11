"""
Create example distributions


@author: 'mkoenig'
@date: 2015-05-11
"""

def getGalactoseDistributions():
    return _readGalactoseDistributions()


def getDemoDistributions():
    from simapp.models import ParameterType

    ''' Example distributions for demo network. '''
    d1 = Distribution(DistributionType.LOGNORMAL, {
        DistributionParameterType.MEAN: SampleParameter('Vmax_b1', 5.0, 'mole_per_s',
                                           ParameterType.GLOBAL_PARAMETER),
        DistributionParameterType.STD: SampleParameter('Vmax_b1', 0.5, 'mole_per_s',
                                          ParameterType.GLOBAL_PARAMETER),
    })

    d2 = Distribution(DistributionType.LOGNORMAL, {
        DistributionParameterType.MEAN: SampleParameter('Vmax_b2', 2.0, 'mole_per_s',
                                           ParameterType.GLOBAL_PARAMETER),
        DistributionParameterType.STD: SampleParameter('Vmax_b2', 0.4, 'mole_per_s',
                                          ParameterType.GLOBAL_PARAMETER)
    })
    return d1, d2


def _readDemoDistributions():
    pass

def _readGalactoseDistributions():
    """ Reads the fitted distributions (lognormal) """
    from project_settings import MULTISCALE_GALACTOSE

    file_name = MULTISCALE_GALACTOSE + '/results/distributions/distribution_fit_data.csv'
    with open(file_name) as f:
        data = dict()
        header = []
        for k, line in enumerate(f.readlines()):
            if k == 0:
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
        if value and (key not in ['name', 'unit', 'scale_unit']):
            value = float(value)
            # value = values[k]
        d[key] = value
    return d




################################################################################

# TODO: put all these in the test_examples.

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

    if __name__ == "__main__":
    from distributions import getDemoDistributions

    print('-' * 40)
    dists = getDemoDistributions()
    samples = sample_from_distribution(dists, n_samples=10)
    for s in samples:
        print(s)

    '''
    TODO: redo the galactose distributions
    from distributions import getGalactoseDistributions
    dist_data = getGalactoseDistributions()

    print('-' * 40)
    samples = _createSamplesByDistribution(dist_data, N=5)
    for s in samples:
        print(s)

    print('-' * 40)
    samples = _createSamplesByMean(dist_data, N=5)
    for s in samples:
        print(s)
    '''

#     print '-' * 40
#     samples = _createSamplesByLHS(dist_data, N=5)
#     for s in samples:
#         print s
