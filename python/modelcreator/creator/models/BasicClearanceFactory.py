'''
BasicClearance example model.

@author:  Matthias Koenig
@date:    2014-07-28
'''

from creator.events.EventFactory import createPeakEventData

##########################################################################
# EventData
##########################################################################
def createDilutionEventData(time_start, duration):
    species = ["PP__s1M", "PP__rbcM", "PP__albM", "PP__sucM"]
    base = ('{} mM'.format(0.0), ) * len(species)
    peak = ('{} mM'.format(1.0/duration),) * len(species);
    events = createPeakEventData(species, base, peak, 
                                 time_start=time_start, duration=duration)
    return events


if __name__ == "__main__":
    from sim.PathSettings import SBML_DIR    
    from creator.CellModel import CellModel
    from creator.TissueModel import TissueModel

    # definition of cell model and tissue model
    cell_model = CellModel.createModel('BasicClearanceCell')
    tdict = TissueModel.createTissueDict(['SinusoidalUnit', 'BasicClearanceSinusoid']) 

    #---------------------------------------------------------------------------------
    # [1] core model
    tm = TissueModel(Nc=1, version=2, tissue_dict=tdict, 
                     cell_model=cell_model, simId='core', events=None)
    tm.createModel()
    tm.writeSBML()    
    tm.storeInDatabase()

    #---------------------------------------------------------------------------------
    # [2] multiple dilution indicator
    # ___|---|__ (in all periportal species)
    # The multiple dilution indicator peak comes when the system is 
    # in steady state after the applied initial condition changes:
    events = createDilutionEventData(time_start=1000.0, duration=0.5)
    tm2 = TissueModel(Nc=1, version=2, tissue_dict=tdict, 
                     cell_model=cell_model, simId='dilution', events=events)
    tm2.createModel()
    tm2.writeSBML()    
    tm2.storeInDatabase()