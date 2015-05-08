'''
Created on Jul 10, 2014

@author: mkoenig
'''

import django
django.setup()

from simapp.models import Task

def set_priority_for_task(tid, priority):
    task = Task.objects.get(pk=tid)
    print task, task.pk, task.priority
    task.priority = priority
    task.save()
    

if __name__ == "__main__":
    tid = 3
    set_priority_for_task(tid, priority=30)
    
    
    
    