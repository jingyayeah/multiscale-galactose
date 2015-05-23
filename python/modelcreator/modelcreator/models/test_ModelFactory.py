"""
Tests for ModelFactory.
"""
import unittest
from modelcreator.models.model_cell import CellModel
from modelcreator.models.model_tissue import TissueModel

class TestModelFactory(unittest.TestCase):

    def test_clearance(self):
        """Test BasicClearance model."""
        cell_model = CellModel.createModel('modelcreator.models.clearance.BasicClearanceCell')
        tissue_dict = TissueModel.createTissueDict(['modelcreator.models.SinusoidalUnit',
                                                   'modelcreator.models.clearance.BasicClearanceSinusoid'])
        Nc, Nf = 1, 1

        version = 1
        tm = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                         cell_model=cell_model, simId='core', events=None)
        tm.createModel()
        self.assertEqual(tm.Nc, Nc)
        self.assertEqual(tm.version, version)
        self.assertEqual(tm.simId, 'core')

if __name__ == "__main__":
    unittest.main()
