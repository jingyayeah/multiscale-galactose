"""
Model factory for the BasicClearance example model.
"""


from modelcreator.models.model_cell import CellModel
from modelcreator.models.model_tissue import TissueModel


def createClearanceDilutionEventData(time_start, duration):
    """ Generate the event data for the dilution peaks. """
    species = ["PP__s1M", "PP__rbcM", "PP__albM", "PP__sucM"]
    base = ('{} mM'.format(0.0), ) * len(species)
    peak = ('{} mM'.format(1.0/duration),) * len(species)
    events = createPeakEventData(species, base, peak, 
                                 time_start=time_start, duration=duration)
    return events


def core_model():
    pass

if __name__ == "__main__":
    import django
    django.setup()
    import simapp.db.api as db_api

    # definition of cell model and tissue model
    Nc, Nf = 20, 1
    Nc, Nf = 1, 1

    version = 5
    cell_model = CellModel.createModel('clearance.BasicClearanceCell')
    tissue_dict = TissueModel.createTissueDict(['SinusoidalUnit', 'clearance.BasicClearanceSinusoid'])

    # ---------------------------------------------------------------------------------
    # [1] core model
    # ---------------------------------------------------------------------------------
    tm = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                     cell_model=cell_model, simId='core', events=None)
    tm.createModel()
    sbml_path = tm.writeSBML()
    model = db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)

    # ---------------------------------------------------------------------------------
    # [2] multiple dilution indicator
    # ---------------------------------------------------------------------------------
    # ___|---|__ (in all periportal species)
    # The multiple dilution indicator peak comes when the system is 
    # in steady state after the applied initial condition changes:
    from modelcreator.events.eventdata import EventData
    events = EventData.rect_dilution_peak()
    tm2 = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                      cell_model=cell_model, simId='dilution', events=events)
    tm2.createModel()
    sbml_path = tm2.writeSBML()
    model2 = db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
