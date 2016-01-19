"""
Tests for ModelFactory.
"""
import unittest

# from multiscale.modelcreator.models.model_tissue import TissueModel

from multiscale.modelcreator.factory.model_cell import CellModel


class TestModelFactory(unittest.TestCase):

    def test_clearance(self):
        """Test BasicClearance model."""
        # TODO: fix/simplify the path issues

        cell_model = CellModel.create_model('multiscale.modelcreator.models.clearance.BasicClearanceCell')
        tissue_dict = TissueModel.createTissueDict(['multiscale.modelcreator.models.SinusoidalUnit',
                                                   'multiscale.modelcreator.models.clearance.BasicClearanceSinusoid'])
        Nc, Nf = 1, 1

        version = 1
        tm = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                         cell_model=cell_model, sim_id='core', events=None)
        tm.createModel()
        self.assertEqual(tm.Nc, Nc)
        self.assertEqual(tm.version, version)
        self.assertEqual(tm.simId, 'core')

if __name__ == "__main__":
    unittest.main()
