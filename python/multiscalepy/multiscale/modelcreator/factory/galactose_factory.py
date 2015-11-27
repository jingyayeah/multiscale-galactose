"""
Create the SinusoidalUnit models for galactose metabolism.
The different model variants are driven by different events.
"""
from __future__ import print_function

from multiscale.multiscale_settings import sbml_path
from multiscale.modelcreator.factory.model_tissue import TissueModel
import multiscale.multiscalesite.simapp.db.api as db_api
from multiscale.modelcreator.events.eventdata import EventData
from multiscale.modelcreator.factory.model_cell import CellModel



"""
def tissue_model():
     # definition of cell model and tissue model
    Nc = 1
    Nf = 1
    version = 129
    cell_model = CellModel.create_model('multiscale.modelcreator.models.galactose.GalactoseCell')
    tissue_dict = TissueModel.createTissueDict(['multiscale.modelcreator.models.SinusoidalUnit',
                                                'multiscale.modelcreator.models.galactose.GalactoseSinusoid'])

    # ---------------------------------------------------------------------------------
    # [1] core model
    # Model without events. Basic model.
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='core', events=None)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model

    # ---------------------------------------------------------------------------------
    # [2A] multiple dilution indicator
    #    _
    # __| |__ (short rectangular peak in all periportal species)
    # The multiple dilution indicator peak is applied after the system has
    # reached steady state (<1000s) from initial non galactose conditions.
    events = EventData.rect_dilution_peak()
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='dilution', events=events)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model, events

    # [2B] multiple dilution indicator (Gauss peak)
    events = EventData.gauss_dilution_peak()
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='dilution_gauss', events=events)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model, events

    # ---------------------------------------------------------------------------------
    # [3] galactose challenge
    # Continous galactose challenge periportal applied (galactose pp__gal) after
    # system has reached steady state. Simulation continued until new steady state
    # under challenge conditions is reached.
    #    ________
    # __|
    events = EventData.galactose_challenge(tc_start=2000.0)
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='galchallenge', events=events)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model, events

    # ---------------------------------------------------------------------------------
    # [4] galactose step
    # Step-wise increase in the galactose concentration until new steady state
    # concentrations are reached in the system.
    #        _
    #      _| |
    #    _|   |
    # __|     |___
    events = EventData.galactose_step_increase()
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='galstep', events=events)
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
"""

def galactose_model():
    print("Create galactose model")
    cell_dict = CellModel.createCellDict(['multiscale.modelcreator.models.hepatocyte',
                                         'multiscale.modelcreator.models.galactose'])
    # init model
    cell_model = CellModel(model_id="galactose_09",
                           cell_dict=cell_dict,
                           events=None)

    # annotations

    cell_model.create_sbml()
    file_path = sbml_path(cell_model.model_id)
    cell_model.write_sbml(file_path)
    # add model to database
    db_api.create_model(file_path,
                        model_format=db_api.CompModelFormat.SBML)

    return [cell_dict, cell_model]


def demo_model():
    print("Create demo model")
    cell_dict = CellModel.createCellDict(['multiscale.modelcreator.models.demo'])
    # init model
    cell_model = CellModel(model_id="demo_01",
                           cell_dict=cell_dict,
                           events=None)
    # annotations
    # TODO:

    cell_model.create_sbml()
    file_path = sbml_path(cell_model.model_id)
    cell_model.write_sbml(file_path)
    # add model to database
    db_api.create_model(file_path,
                        model_format=db_api.CompModelFormat.SBML)

    return [cell_dict, cell_model]

if __name__ == "__main__":
    # [cell_dict, cell_model] = galactose_model()
    [cell_dict, cell_model] = demo_model()
    

