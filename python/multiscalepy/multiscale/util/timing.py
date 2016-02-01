"""
Helper functions for timing of things.
"""
from __future__ import print_function, division

from functools import wraps
import time


class time_it(object):
    """
    Function decorator to time execution.

    decorator usage:
        @time_it()
        @time_it(message="Test")
        def test_func(n=1000):
            return n
        test_func(*args, **kwargs)

    """

    def __init__(self, message=""):
        """
        If there are decorator arguments, the function
        to be decorated is not passed to the constructor!
        """
        self.message = message

    def __call__(self, f):
        """
        If there are decorator arguments, __call__() is only called
        once, as part of the decoration process! You can only give
        it a single argument, which is the function object.
        """
        @wraps(f)
        def wrapped_f(*args, **kwargs):
            time_start = time.time()
            res = f(*args, **kwargs)
            print('Time<{}> {}: {} [s]'.format(f.__name__, self.message, time.time() - time_start))
            return res
        return wrapped_f


def singleton(cls):
    """
    Define a class with a singleton instance.
    """
    instances = {}
    def getinstance():
        if cls not in instances:
            instances[cls] = cls()
        return instances[cls]
    return getinstance


if __name__ == "__main__":
    @time_it()
    def test_func(n=1000):
        return n

    test_func()
