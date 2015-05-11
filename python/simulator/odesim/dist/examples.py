"""
Create example distributions


@author: 'mkoenig'
@date: 2015-05-11
"""

from simapp.models import ParameterType
from odesim.dist.samples import SampleParameter
from odesim.dist.distributions import Distribution, DistributionType, DistributionParameterType


class Example(object):
    @staticmethod
    def read_distributions(file_path):
        """ Read distributions from given file in standard file format.
        :param file_path:
        :return:
        """
        raise NotImplemented


class GalactoseFlow(Example):
    """ Galactose Flow model. """

    @classmethod
    def get_distributions(cls):
        return cls._read_fitted_galactose_distributions()

    @staticmethod
    def _read_fitted_galactose_distributions():
        """ Reads the fitted distributions (lognormal).
            Distributions were fitted based on histograms and distribution_data in R and
            than stored in standard format.
        """
        # TODO: Fix. This is not generating the distributions, but just reading the old file format.
        from project_settings import MULTISCALE_GALACTOSE

        file_path = MULTISCALE_GALACTOSE + '/results/distributions/distribution_fit_data.csv'
        with open(file_path) as f:
            data = dict()
            header = []
            for k, line in enumerate(f.readlines()):
                if k == 0:
                    tokens = [t.strip() for t in line.split(',')]
                    header = tokens[1:]
                    continue

                tokens = [t.strip() for t in line.split(',')]
                tokens = tokens[1:]
                data[tokens[0]] = GalactoseFlow._create_dict(header, tokens)
        return data

    @staticmethod
    def _create_dict(keys, values):
        """ Helper function for creating the dictionary from given keys and values."""
        # TODO: refactor
        d = dict()
        for k in range(len(keys)):
            key = keys[k]
            value = values[k]
            if value == 'NA':
                value = None
            if value and (key not in ['name', 'unit', 'scale_unit']):
                value = float(value)
            d[key] = value
        return d


class Demo(Example):
    @classmethod
    def get_distributions(cls):
        """ Example distributions for demo network.
            Definition of two lognormal distributions for Vmax_b1 and Vmax_b2.
        """
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

########################################################################################################################

if __name__ == "__main__":
    from odesim.dist import sampling

    print('-' * 80)
    distribution_data = GalactoseFlow.get_distributions()
    for key, value in distribution_data.iteritems():
        print(key, ':', value)
    print('-' * 80)

    print('-' * 80)
    distributions = Demo.get_distributions()
    for d in distributions:
        print(d)

    # Do some samples
    samples = sampling.sample_from_distribution(distributions, n_samples=10)
    for s in samples:
        print(s)
    print('-' * 80)
