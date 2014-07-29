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
        