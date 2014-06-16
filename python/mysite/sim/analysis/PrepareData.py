'''
Created on Jun 11, 2014

@author: mkoenig
'''

import os
import sys
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import time
from sim.models import Task
from PrepareAnalysis import prepareDataForAnalysis

if __name__ == "__main__":
    date_str = time.strftime("%Y-%m-%d")
    task_pks = (1, )
    for pk in task_pks:
        task = Task.objects.get(pk=pk)
        directory = '/home/mkoenig/multiscale-galactose-results/' + date_str + '_' + str(task)
        print directory
        prepareDataForAnalysis(task, directory)
        
        