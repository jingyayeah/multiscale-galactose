"""
Unittests
"""
from __future__ import print_function

import unittest
import roadrunner
from sbmlutils import validation
import clearance


class ModelTestCase(unittest.TestCase):
    def test_validate_sbml(self):
        """ Validate the SBML. """
        vres = validation.validate_sbml(clearance.sbml_path, ucheck=True)
        self.assertEqual(vres["numCCErr"], 0)
        self.assertEqual(vres["numCCWarn"], 0)

    def test_roadrunner_selections(self):
        rr = roadrunner.RoadRunner(clearance.sbml_path)
        self.assertTrue(len(rr.selections) > 1)

    def test_fixed_step_simulation(self):
        rr = roadrunner.RoadRunner(clearance.sbml_path)

        tend = 10.0
        steps = 100
        s = rr.simulate(start=0, end=tend, steps=steps)

        # test end point reached
        self.assertEqual(s[-1, 0], 10)
        # test correct number of steps
        self.assertEqual(len(s['time']), steps+1)


if __name__ == '__main__':
    unittest.main()
