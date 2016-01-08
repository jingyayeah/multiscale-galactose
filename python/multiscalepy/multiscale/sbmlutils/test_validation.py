from __future__ import print_function, division
import unittest

import os
import tempfile
from validation import validate_sbml

from multiscale.examples.testdata import test_dir

class TestValidation(unittest.TestCase):

    def test_validate_demo(self):
        f_sbml = os.path.join(test_dir, 'annotation', 'demo_9.xml')
        results = validate_sbml(f_sbml)
        self.assertEqual(0, results["numCCErr"])
        self.assertEqual(0, results["numCCWarn"])

    def test_validate_galactose(self):
        f_sbml = os.path.join(test_dir, 'annotation', 'galactose_29.xml')
        results = validate_sbml(f_sbml)
        self.assertEqual(0, results["numCCErr"])
        self.assertEqual(0, results["numCCWarn"])


if __name__ == '__main__':
    unittest.main()
