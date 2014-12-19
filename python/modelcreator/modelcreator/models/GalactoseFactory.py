'''
Create the various SinusoidalUnit models of galactose metabolism,
 i.e. models driven by different timecourse events.
 
TODO: handle the SBML information via dictionaries instead of lists, 
      information is than not depending on the length of list (more flexible).
    
@author:  Matthias Koenig
@date:    2014-07-28
'''

from modelcreator.models.model_cell import CellModel
from modelcreator.models.model_tissue import TissueModel
    
from modelcreator.events.event_factory import createGalactoseChallengeEventData,\
    createRectEventData, createGaussEventData
from modelcreator.events.event_factory import createGalactoseStepEventData


if __name__ == "__main__":
    
    # definition of cell model and tissue model
    Nc = 20
    version = 79
    cell_model = CellModel.createModel('galactose.GalactoseCell')
    tdict = TissueModel.createTissueDict(['SinusoidalUnit', 
                                          'galactose.GalactoseSinusoid']) 

    #---------------------------------------------------------------------------------
    # [1] core model
    # Model without events. Basic model.
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='core', events=None)
    tm.createModel()
    tm.writeSBML()   
    tm.storeInDatabase()
    del tm
    
    #---------------------------------------------------------------------------------
    # [2A] multiple dilution indicator
    #    _
    # __| |__ (short rectangular peak in all periportal species)
    # The multiple dilution indicator peak is applied after the system has
    # reached steady state (<1000s) from initial non galactose conditions.
    events = createRectEventData()
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='dilution', events=events)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
    del tm, events
    
    # [2B] multiple dilution indicator (Gauss peak)
    events = createGaussEventData()
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='dilution_gauss', events=events)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
    del tm, events
    
    #---------------------------------------------------------------------------------
    # [3] galactose challenge 
    # Continous galactose challenge periportal applied (galactose pp__gal) after
    # system has reached steady state. Simulation continued until new steady state
    # under challenge conditions is reached.
    #    ________
    # __|
    events = createGalactoseChallengeEventData(tc_start=2000.0)
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='galchallenge', events=events)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
    del tm, events
    
    #---------------------------------------------------------------------------------
    # [4] galactose step 
    # Step-wise increase in the galactose concentration until new steady state 
    # concentrations are reached in the system.
    #        _
    #      _| |
    #    _|   |
    # __|     |___
    events = createGalactoseStepEventData()
    tm = TissueModel(Nc=Nc, version=version, tissue_dict=tdict, 
                     cell_model=cell_model, simId='galstep', events=events)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()
