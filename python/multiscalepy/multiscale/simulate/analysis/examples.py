"""
Examples of distributions.
"""
from __future__ import print_function, division


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
        from multiscale.multiscale_settings import MULTISCALE_GALACTOSE

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
