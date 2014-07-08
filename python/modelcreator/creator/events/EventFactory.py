'''
Creating the simulation event data.
The EventData is used to generate the SBML events for the model.

Created on Jul 2, 2014
@author: mkoenig
'''

class EventData():
    def __init__(self, eid, name, trigger, assignments):
        self.eid = eid
        self.name = name
        self.trigger = trigger
        self.assignments = assignments
    
    def info(self):
        print '-' * 20
        print self.eid
        print self.name
        print self.trigger
        print self.assignments
        
        
def createDilutionEventData(tp_start = 10.0, duration = 0.5):
    species = ["PP__galM", "PP__rbcM", "PP__alb", "PP__h2oM", "PP__suc"]
    
    tp_end = tp_start + duration
    p_height = 1.0/duration;
    ed1 = EventData("EDIL_0", "pre Dilution Peak [PP]",
                   createTriggerFromTime(0.0), createAssignments(species, 0.0))
    ed2 = EventData("EDIL_1", "Dilution Peak [PP]",
                   createTriggerFromTime(tp_start), createAssignments(species, p_height))
    ed3 = EventData("EDIL_2", "post Dilution Peak [PP]",
                   createTriggerFromTime(tp_end), createAssignments(species, 0.0))

    return [ed1, ed2, ed3]

def createGalactoseChallengeEventData(tc_start = 100.0, peak_var='gal_challenge'):
    ed = EventData("EDIL_0", "galactose challenge",
                   createTriggerFromTime(tc_start), {'PP__gal': peak_var})
    return [ed]

def createTriggerFromTime(t):
    return '(time >= {})'.format(t)

def createAssignments(species, value):
    values = [str(item)+' mM' for item in (value,)*len(species)]
    return dict(zip(species, values) )

#####################################################################
if __name__ == '__main__':
    elist = createDilutionEventData()
    for edata in elist:
        edata.info()
    
    elist = createDilutionEventData(tp_start=100.0, duration=10.0)
    for edata in elist:
        edata.info()
    
    
    