'''


@author: Matthias Koenig
@date:   2014-06-06
'''

import os
import sys
import shutil
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

from sim.models import Task
from AnalysisTools import createParameterFileForTask

def prepareDataForAnalysis(task, directory):
    if not os.path.exists(directory):
        os.makedirs(directory)
        print 'created: ', directory
    
    # copy SBML
    sbml_file = str(task.sbml_model.file.path)
    shutil.copy2(sbml_file, directory)
    
    # create Parameter File
    createParameterFileForTask(task, directory)
    
    # collect all the timecourses on 10.39.34.27
    
    
    # copy timecourses to target folder
    
    # shutil.copy2(sbml_file, directory)
    
    
if __name__ == '__main__':
    
    task = Task.objects.get(pk=11)
    folder = "/home/mkoenig/multiscale-galactose-results/2014-06-06_T" + str(task.pk) 
    
    print task.pk, task.simulator
    print folder
    prepareDataForAnalysis(task, folder)
    
    
    
    
    
    
    