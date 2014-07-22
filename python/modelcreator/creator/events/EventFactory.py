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
        
        
        
def createDilutionEventData(time_start, duration):
    species = ["PP__galM", "PP__rbcM", "PP__alb", "PP__h2oM", "PP__suc"]
    # all species have the same peak height based on the duration
    base = ('{} mM'.format(0.0), ) * len(species)
    peak = ('{} mM'.format(1.0/duration),) * len(species);
    return createPeakEventData(species, base, peak, time_start=time_start, duration=duration)
        
        
def createPeakEventData(species, base, peak, time_start, duration):
    ''' 
    Creates a dilution peak in the given species beginning at the
    start time and with the provided duration.
    '''
    time_end = time_start + duration
    ed1 = EventData("EDIL_0", "pre peak [PP]",
                   createTriggerFromTime(0.0), createAssignmentsDict(species, base))
    ed2 = EventData("EDIL_1", "peak [PP]",
                   createTriggerFromTime(time_start), createAssignmentsDict(species, peak))
    ed3 = EventData("EDIL_2", "post peak [PP]",
                   createTriggerFromTime(time_end), createAssignmentsDict(species, base))

    return [ed1, ed2, ed3]

def createGalactoseChallengeEventData(tc_start = 100.0, peak_var='gal_challenge'):
    ed = EventData("EDIL_0", "galactose challenge",
                   createTriggerFromTime(tc_start), {'PP__gal': peak_var})
    return [ed]

def createGalactoseStepEventData():
    ''' Stepwise increase in PP__gal over time.'''
    event_data = []
    duration = 1000.0;
    for k in range(0,21):
        time = 0.0 + k*duration;
        gal = 0.0 + k*0.5
        ed = EventData('ESTEP_{}'.format(k), "galactose step",
                   createTriggerFromTime(time), {'PP__gal': '{} mM'.format(gal)})
        event_data.append(ed)
    return event_data


def createTriggerFromTime(t):
    return '(time >= {})'.format(t)

def createAssignmentsDict(species, values):
    return dict(zip(species, values) )

#####################################################################
if __name__ == '__main__':
    elist = createDilutionEventData()
    for edata in elist:
        edata.info()
    
    elist = createDilutionEventData(tp_start=100.0, duration=10.0)
    for edata in elist:
        edata.info()
    
    elist = createGalactoseStepEventData()
    for edata in elist:
        edata.info()
    
    
    
    