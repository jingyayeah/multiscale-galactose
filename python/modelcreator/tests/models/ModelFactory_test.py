'''
Created on Jul 29, 2014

@author: mkoenig
'''
import unittest
from modelcreator.models.model_cell import CellModel
from modelcreator.models.model_tissue import TissueModel

class TestModelFactory(unittest.TestCase):
    '''Unit tests for modelcreator.'''

    def test_clearance(self):
        """Test BasicClearance model."""
        cell_model = CellModel.createModel('modelcreator.models.clearance.BasicClearanceCell')
        tdict = TissueModel.createTissueDict(['modelcreator.models.SinusoidalUnit', 
                                          'modelcreator.models.clearance.BasicClearanceSinusoid']) 
        Nc = 1
        version = 2
    
        tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='core', events=None)
        tm.createModel()
        self.assertEqual(tm.Nc, Nc)
        self.assertEqual(tm.version, version)
        self.assertEqual(tm.simId, 'core')

if __name__ == "__main__":
    unittest.main()