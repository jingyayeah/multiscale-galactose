'''
Create the various SinusoidalUnit models of galactose metabolism,
 i.e. models driven by different timecourse events.
    
@author:  Matthias Koenig
@date:    2014-07-28
'''

from modelcreator.models.model_cell import CellModel
from modelcreator.models.model_tissue import TissueModel
    
from modelcreator.events.event_factory import createDilutionEventData, createGalactoseChallengeEventData
from modelcreator.events.event_factory import createGalactoseStepEventData


if __name__ == "__main__":
    
    # definition of cell model and tissue model
    Nc = 20
    version = 18
    cell_model = CellModel.createModel('galactose.GalactoseCell')
    tdict = TissueModel.createTissueDict(['SinusoidalUnit', 
                                          'galactose.GalactoseSinusoid']) 

    #---------------------------------------------------------------------------------
    # [1] core model
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='core', events=None)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
    del tm

    #---------------------------------------------------------------------------------
    # [2] multiple dilution indicator
    # ___|---|__ (in all periportal species)
    # The multiple dilution indicator peak comes when the system is 
    # in steady state after the applied initial condition changes:
    events = createDilutionEventData(time_start=1000.0, duration=0.5)
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='dilution', events=events)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
    del tm, events
    
    #---------------------------------------------------------------------------------
    # [3] galactose challenge (with various galactose)
    # __|------
    events = createGalactoseChallengeEventData(tc_start=100.0)
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='galactose-challenge', events=events)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
    del tm, events
    
    #---------------------------------------------------------------------------------
    # [4] galactose step (with various galactose)
    # __|------
    events = createGalactoseStepEventData()
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='galactose-step', events=events)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
