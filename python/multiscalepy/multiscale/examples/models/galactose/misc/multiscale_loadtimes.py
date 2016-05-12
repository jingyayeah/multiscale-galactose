"""
Testing of load times for model.

See issue: https://github.com/sys-bio/roadrunner/issues/260
"""
from __future__ import print_function, division
import roadrunner
print(roadrunner.__version__)
import time


def time_it(func, *args, **kwargs):
    """ Time the call to the function. """
    time_start = time.time()
    res = func(*args, **kwargs)
    print('Time: {}'.format(time.time() - time_start))
    return res


def hash_for_file(filepath, hash_type='MD5', blocksize=65536):
    """ Calculate the md5_hash for a file.

        Calculating a hash for a file is always useful when you need to check if two files
        are identical, or to make sure that the contents of a file were not changed, and to
        check the integrity of a file when it is transmitted over a network.
        he most used algorithms to hash a file are MD5 and SHA-1. They are used because they
        are fast and they provide a good way to identify different files.
        [http://www.pythoncentral.io/hashing-files-with-python/]
    """
    import hashlib

    hasher = None
    if hash_type == 'MD5':
        hasher = hashlib.md5()
    elif hash_type == 'SHA1':
        hasher == hashlib.sha1()
    with open(filepath, 'rb') as f:
        buf = f.read(blocksize)
        while len(buf) > 0:
            hasher.update(buf)
            buf = f.read(blocksize)
    return hasher.hexdigest()


def test_load_times(sbml_path):
    """ Test the load times for the SBML model.

    :param sbml_path:
    :type sbml_path:
    :return:
    :rtype:
    """
    print('*** First loading ***')
    # r = rt.load_model(test_sbml)
    r = time_it(roadrunner.RoadRunner, test_sbml)

    print('*** Reloading ***')
    r = time_it(roadrunner.RoadRunner, test_sbml)

    print('*** Hash calculation MD5 ***')
    time_it(hash_for_file, test_sbml)

####################################################################################################
if __name__ == "__main__":
    test_load_times(sbml_path='../results/Galactose_v128_Nc20_dilution.xml')




