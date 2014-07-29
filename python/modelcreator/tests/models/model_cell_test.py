'''
Created on Jul 29, 2014

@author: mkoenig
'''

import unittest
from modelcreator.models.model_cell import CellModel

class TestCellModel(unittest.TestCase):
    '''Unit tests for modelcreator.'''

    def test_clearance(self):
        """Test cell model."""
        cell_model = CellModel.createModel('modelcreator.models.clearance.BasicClearanceCell')
        cell_model.info()
        
        self.assertEqual(cell_model.mid, 'BasicClearance')
    
    def test_galactose(self):
        """Test cell model."""
        cell_model = CellModel.createModel('modelcreator.models.galactose.GalactoseCell')
        cell_model.info()
        
        self.assertEqual(cell_model.mid, 'Galactose')

if __name__ == "__main__":
    unittest.main()