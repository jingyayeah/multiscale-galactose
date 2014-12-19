'''
Functions for creating simulation events.
Event information is stored as EventData.

Necessary to create trigger events to guarantee proper integration
even when using variable step sizes.

@author: Matthias Koenig
@date: 2014-07-29
'''

from eventdata import EventData     
        
                
def createRectEventData():
    ''' 
    Creates a dilution peak in the given species beginning at the
    start time and with the provided duration.
    '''
    ed1 = EventData("EDIL_0", "pre peak [PP]",
                   createTriggerFromTime(0.0), {'peak_status': '0 dimensionless',
                                                'peak_type': '0 dimensionless'})
    ed2 = EventData("EDIL_1", "peak [PP]",
                   createTriggerFromTime("t_peak"), {'peak_status': '1 dimensionless',
                                                     'peak_type': '0 dimensionless'})
    ed3 = EventData("EDIL_2", "post peak [PP]",
                   createTriggerFromTime("t_peak_end"), {'peak_status': '0 dimensionless',
                                                         'peak_type': '0 dimensionless'})
    return [ed1, ed2, ed3]


def createGaussEventData():
    ''' 
    Creates gauss dilution peak.
    '''
    ed1 = EventData("EDIL_0", "pre peak [PP]",
                   createTriggerFromTime(0.0), {'peak_status': '0 dimensionless',
                                                'peak_type': '1 dimensionless'})
    ed2 = EventData("EDIL_1", "peak [PP]",
                   createTriggerFromTime("mu_peak-3 dimensionless*sigma_peak"), {'peak_status': '1 dimensionless',
                                                                                 'peak_type': '1 dimensionless'})
    ed3 = EventData("EDIL_2", "post peak [PP]",
                   createTriggerFromTime("mu_peak+3 dimensionless*sigma_peak"), {'peak_status': '0 dimensionless',
                                                                                 'peak_type': '1 dimensionless'})
    return [ed1, ed2, ed3]

def createGalactoseChallengeEventData(tc_start, base_value=0.0, peak_variable='gal_challenge'):
    ed1 = EventData("ECHA_0", "pre challenge [PP]",
                   createTriggerFromTime(0.0), {'PP__gal': '{} mM'.format(base_value)})
    
    ed2 = EventData("ECHA_1", "galactose challenge",
                   createTriggerFromTime(tc_start), {'PP__gal': peak_variable})
    return [ed1, ed2]

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
    elist = createRectEventData()
    print '\n* Rectangular peak *'
    for edata in elist:
        edata.info()
        
    elist = createGaussEventData()
    print '\n* Gauss peak *'
    for edata in elist:
        edata.info()
    exit()
    
    elist = createGalactoseChallengeEventData(tc_start=10, base_value=0.0)
    print '\n* Galactose Challenge *'
    for edata in elist:
        edata.info()
    
    elist = createGalactoseStepEventData()
    print '\n* Galactose Step *'
    for edata in elist:
        edata.info()
    
    
    
    