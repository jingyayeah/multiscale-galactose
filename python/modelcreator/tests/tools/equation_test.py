'''
Created on Jul 29, 2014

@author: mkoenig
'''

import unittest
from modelcreator.tools.equation import Equation, REV_SEP

class TestEquation(unittest.TestCase):
    '''Unit tests for modelcreator.'''

    def test_equation_1(self):
        """Test Equation."""
        eq_string = 'c__gal1p => c__gal + c__phos'
        eq = Equation(eq_string)
        self.assertEqual(eq.toString(), eq_string)

    def test_equation_2(self):
        """Test Equation."""
        eq_string = 'e__h2oM <-> c__h2oM'
        eq = Equation(eq_string)
        self.assertTrue(eq.reversible)
        
        test_res = eq_string.replace('<->', REV_SEP)
        self.assertEqual(eq.toString(), test_res)
        
    def test_equation_double_stoichiometry(self):
        """Test Equation."""
        eq_string = '3.0 atp + 2.0 phos + ki <-> 16.98 tet'
        eq = Equation(eq_string)
        self.assertTrue(eq.reversible)
        
        test_res = eq_string.replace('<->', REV_SEP)
        self.assertEqual(eq.toString(), test_res)

    def test_equation_modifier(self):
        """Test Equation."""
        eq_string = 'c__gal1p => c__gal + c__phos [c__udp, c__utp]'
        eq = Equation(eq_string)
        self.assertEqual(eq.toString(modifiers=True), eq_string)


if __name__ == "__main__":
    unittest.main()