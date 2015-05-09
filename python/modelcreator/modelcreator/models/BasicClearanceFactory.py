'''
BasicClearance example model.

@author:  Matthias Koenig
@date:    2014-07-28
'''

from modelcreator.events.event_factory import createPeakEventData
from modelcreator.models.model_cell import CellModel
from modelcreator.models.model_tissue import TissueModel

def createClearanceDilutionEventData(time_start, duration):
    '''
    Generate the event data for the dilution peaks.
    '''
    species = ["PP__s1M", "PP__rbcM", "PP__albM", "PP__sucM"]
    base = ('{} mM'.model_format(0.0), ) * len(species)
    peak = ('{} mM'.model_format(1.0/duration),) * len(species);
    events = createPeakEventData(species, base, peak, 
                                 time_start=time_start, duration=duration)
    return events


if __name__ == "__main__":

    # definition of cell model and tissue model
    Nc = 20
    version = 4
    cell_model = CellModel.createModel('clearance.BasicClearanceCell')
    tdict = TissueModel.createTissueDict(['SinusoidalUnit', 
                                          'clearance.BasicClearanceSinusoid']) 

    #---------------------------------------------------------------------------------
    # [1] core model
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='core', events=None)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()

    #---------------------------------------------------------------------------------
    # [2] multiple dilution indicator
    # ___|---|__ (in all periportal species)
    # The multiple dilution indicator peak comes when the system is 
    # in steady state after the applied initial condition changes:
    events = createClearanceDilutionEventData(time_start=1000.0, duration=0.5)
    tm2 = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='dilution', events=events)
    tm2.createModel()
    tm2.writeSBML()    
    tm2.storeInDatabase()