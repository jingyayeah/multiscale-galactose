"""
Test model_cell.
"""

import unittest
from modelcreator.models.model_cell import CellModel

class TestCellModel(unittest.TestCase):

    def test_clearance(self):
        cell_model = CellModel.createModel('modelcreator.models.clearance.BasicClearanceCell')
        cell_model.info()
        self.assertEqual(cell_model.mid, 'BasicClearance')
    
    def test_galactose(self):
        cell_model = CellModel.createModel('modelcreator.models.galactose.GalactoseCell')
        cell_model.info()
        
        self.assertEqual(cell_model.mid, 'Galactose')

if __name__ == "__main__":
    unittest.main()
