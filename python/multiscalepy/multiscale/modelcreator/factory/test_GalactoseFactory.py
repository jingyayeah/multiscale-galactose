"""
Tests the creation of the galactose models.
"""

import unittest

# from multiscale.modelcreator.models.model_tissue import TissueModel

from multiscale.modelcreator.factory.model_cell import CellModel


class TestGalactoseFactory(unittest.TestCase):

    def test_galactose_core(self):
        Nc = 1
        Nf = 1
        version = 'test'
        cell_model = CellModel.create_model('multiscale.modelcreator.models.galactose.GalactoseCell')
        tissue_dict = TissueModel.createTissueDict(['multiscale.modelcreator.models.SinusoidalUnit',
                                          'multiscale.modelcreator.models.galactose.GalactoseSinusoid'])

        tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                                   cell_model=cell_model, sim_id='test', events=None)
        tissue_model.createModel()
    
        self.assertEqual(tissue_model.version, version)
        self.assertEqual(tissue_model.simId, 'test')

if __name__ == "__main__":
    unittest.main()
