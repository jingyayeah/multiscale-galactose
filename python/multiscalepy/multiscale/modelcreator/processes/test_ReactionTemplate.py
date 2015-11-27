"""
Test the ReactionTemplate
"""
import unittest
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate


class TestReactionTemplate(unittest.TestCase):
    """ Unit tests for ReactionTemplate. """

    def test_creation(self):
        """ Test Equation.
            bA: A_ext => A; (scale_f*(Vmax_bA/Km_A)*(A_ext - A))/(1 dimensionless + A_ext/Km_A + A/Km_A);
        """
        rt = ReactionTemplate(
            'bA',
            'bA (A import)',
            'A_ext => A []',
            localization='membrane',
            compartments=['cell, extern'],
            pars=[],
            rules=[],
            formula=('scale_f*(Vmax_bA/Km_A)*(A_ext - A))/(1 dimensionless + A_ext/Km_A + A/Km_A', 'mole_per_s')
        )
        self.assertIsNotNone(rt)

if __name__ == "__main__":
    unittest.main()
