"""

@author: mkoenig
@date: 2015-??-?? 
"""

from __future__ import print_function
import unittest
import os
import roadrunner

test_dir = os.path.dirname(os.path.abspath(__file__))
test_filepath = os.path.join(test_dir, 'Koenig_demo_v02.xml')

class TestRoadRunnerToolsCase(unittest.TestCase):
    def test_selection_length(self):
        """ Are all floating species in selection, i.e. is length correct &
            is the number of time points correct?
        """
        r = roadrunner.RoadRunner(test_filepath)

        print(r.model.getFloatingSpeciesIds())
        print(r.selections)
        res = r.simulate(duration=20, steps=100, absolute=1E-8, relative=1E-8, lot=False)

        self.assertEqual(101, res.shape[0])
        self.assertEqual(len(r.model.getFloatingSpeciesIds())+1, res.shape[1])
        self.assertEqual(7, res.shape[1])

if __name__ == "__main__":
    unittest.main()

