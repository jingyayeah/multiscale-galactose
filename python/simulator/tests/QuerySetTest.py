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
    print [t.priority for t in tasks]
    
    # sort by priority
    
    # use value of the related tables
    # problems with multiplicity
    # ? could be count() a solution ?
    tasks = Task.objects.filter(simulation__status=UNASSIGNED).distinct('pk', 'priority').order_by('-priority')
    print tasks
    
    print tasks.distinct()
    
    # also the select for update
    
    # put it in a view? probably best? assign simulation view
    
    print '*'*20
    Nsim=1
    tasks = Task.objects.all()[0:Nsim]
    print tasks
    
    