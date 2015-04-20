#!/usr/bin/python
'''
Make the batch analysis of the data for multiple tasks.

@author: Matthias Koenig
@date: 2015-04-18
'''

import path_settings
from sbmlsim.models import Task
from PrepareAnalysis import prepareDataForAnalysis


#task_pks = (1, 2, ) 
task_pks = range(35, 43)

if __name__ == "__main__":
    print task_pks
    for pk in task_pks:
        print pk
        task = Task.objects.get(pk=pk)
        prepareDataForAnalysis(task)
        
        