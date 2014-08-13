#!/usr/bin/python
'''
Make the batch analysis of the data for multiple tasks.

@author: Matthias Koenig
@date: 2014-08-13
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

from sim.models import Task
from PrepareAnalysis import prepareDataForAnalysis

task_pks = range(29, 46) 

if __name__ == "__main__":
    print task_pks
    for pk in task_pks:
        print pk
        task = Task.objects.get(pk=pk)
        prepareDataForAnalysis(task)
        
        