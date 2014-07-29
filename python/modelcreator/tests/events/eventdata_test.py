'''
Created on Jul 29, 2014

@author: mkoenig
'''

import unittest
from modelcreator.events.eventdata import EventData

class TestEventData(unittest.TestCase):
    '''Unit tests for modelcreator.'''

    def test_eventdata(self):
        """Test naming."""
        eid = 'test'
        name = 'E01'
        trigger = 'time == 0'
        assignments = []
        e = EventData(eid, name, trigger, assignments)
        
        self.assertEqual(e.eid, eid)
        self.assertEqual(e.name, name)
        self.assertEqual(e.trigger, trigger)
        self.assertEqual(e.assignments, assignments)
    
if __name__ == "__main__":
    unittest.main()