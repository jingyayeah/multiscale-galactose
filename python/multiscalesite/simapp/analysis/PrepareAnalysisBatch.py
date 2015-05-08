#!/usr/bin/python
'''
Prepares the data for a batch of simulations.

@author: Matthias Koenig
@date: 2015-04-18
'''

import project_settings
# TODO: better via the setup call

from simapp.models import Task
from PrepareAnalysis import prepareDataForAnalysis


#task_pks = (1, 2, ) 
task_pks = range(35, 43)

if __name__ == "__main__":
    print task_pks
    for pk in task_pks:
        print pk
        task = Task.objects.get(pk=pk)
        prepareDataForAnalysis(task)
        
        