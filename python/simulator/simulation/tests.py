'''
Created on May 3, 2015

@author: mkoenig
'''
import unittest

if __name__ == '__main__':
    testsuite = unittest.TestLoader().discover('.', pattern="*_test.py")
    unittest.TextTestRunner(verbosity=1).run(testsuite)