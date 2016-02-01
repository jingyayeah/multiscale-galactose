
from __future__ import print_function, division
import unittest
from timing import time_it


class TimingTestCase(unittest.TestCase):

    def test_time_it_decorator(self):

        @time_it()
        def test_func(n=1000):
            return n

        self.assertEqual(test_func(1000), 1000)
        self.assertEqual(test_func(n=595), 595)
        self.assertEqual(test_func(13), 13)

if __name__ == '__main__':
    unittest.main()
