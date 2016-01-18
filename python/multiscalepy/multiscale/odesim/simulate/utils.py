from __future__ import print_function, division
import time


def time_it(func, *args, **kwargs):
    """ Time the call to the function. """
    time_start = time.time()
    res = func(*args, **kwargs)
    print('Time: {}'.format(time.time() - time_start))
    return res