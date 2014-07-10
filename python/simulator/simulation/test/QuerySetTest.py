'''
Created on Jul 10, 2014

@author: mkoenig
'''

import sim.PathSettings
from sim.models import Task, Simulation, UNASSIGNED



if __name__ == "__main__":
    print 'Test QuerySet'
    tasks = Task.objects.all()
    print tasks
    
    # sort by priority
    
    
    
    