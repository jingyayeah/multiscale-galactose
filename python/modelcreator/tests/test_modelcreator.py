'''
Running all the doctests.

Created on Jul 29, 2014

@author: mkoenig
'''

import unittest
import doctest

import modelcreator
from tests.tools.equation_test import TestEquation
from tests.tools.naming_test import TestNaming
from tests.events.eventdata_test import TestEventData
from tests.models.model_cell_test import TestCellModel
from tests.models.ModelFactory_test import TestModelFactory

class Test(unittest.TestCase):
    """Unit tests for modelcreator."""

    def test_doctests(self):
        """Run modelcreator doctests"""
        doctest.testmod(modelcreator)
    

if __name__ == "__main__":
    # run the doctests
    unittest.main()
    
    # run the unittest suite
    suite = unittest.TestLoader().loadTestsFromTestCase(TestEquation, 
                                                        TestNaming,
                                                        TestEventData,
                                                        TestCellModel,
                                                        TestModelFactory)
    
    unittest.TextTestRunner(verbosity=2).run(suite)