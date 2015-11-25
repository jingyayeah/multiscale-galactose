"""
Create the single cell models for the galactose metabolism.

Single cell SBML models should be the basis for the coupling with the tissue
models.

TODO: define the version number in the cell models & tissue models
    the complete models are combinations of the individual cell model and tissue models.
"""

from multiscale.modelcreator.models.model_cell import CellModel
from multiscale.modelcreator.models.model_tissue import TissueModel

from multiscale.modelcreator.events.eventdata import EventData
import multiscale.multiscalesite.simapp.db.api as db_api

if __name__ == "__main__":
    # definition of cell model and tissue model
    version = 129
    cell_model = CellModel.create_model('multiscale.modelcreator.models.galactose.GalactoseCell')

    tissue_dict = TissueModel.createTissueDict(['multiscale.modelcreator.models.SingleCell',
                                                'multiscale.modelcreator.models.galactose.GalactoseSinusoid'])

    # ---------------------------------------------------------------------------------
    # [1] core model
    # Single cell model without events
    tissue_model = TissueModel(version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='core', events=None)

    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model
