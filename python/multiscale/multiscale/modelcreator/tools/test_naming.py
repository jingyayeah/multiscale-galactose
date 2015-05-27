"""
Test naming.
"""

import unittest
from multiscale.modelcreator.tools.naming import *

class TestNaming(unittest.TestCase):
    """ Unit tests for naming. """

    def test_sinusoid_id(self):
        self.assertEqual(getSinusoidId(21), 'S21')
        self.assertEqual(getSinusoidId(2), 'S02')
    
    def test_disse_id(self):
        self.assertEqual(getDisseId(21), 'D21')
        self.assertEqual(getDisseId(2), 'D02')

    def test_hepatocyte_id(self):
        self.assertEqual(getHepatocyteId(21), 'H21')
        self.assertEqual(getHepatocyteId(2), 'H02')
        
    def test_localized_species_id(self):
        self.assertEqual(getPPSpeciesId('s1'), 'PP__s1')
        self.assertEqual(getPVSpeciesId('s1'), 'PV__s1')
        self.assertEqual(getSinusoidSpeciesId('s1', 3), 'S03__s1')
        self.assertEqual(getDisseSpeciesId('s1', 3), 'D03__s1')
        self.assertEqual(getHepatocyteSpeciesId('s1', 3), 'H03__s1')

if __name__ == "__main__":
    unittest.main()
