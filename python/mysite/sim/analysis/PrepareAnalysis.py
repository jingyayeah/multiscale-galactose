'''


@author: Matthias Koenig
@date:   2014-06-06
'''

import os
import sys
import shutil
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'
from settings import MEDIA_ROOT

from sim.models import Task
from AnalysisTools import createParameterFileForTask


from sh import rsync
IPS = ('10.39.32.106', '10.39.32.189', '10.39.32.111')


def getTimecourseDirectory(task):
    return '/'.join([MEDIA_ROOT, 'timecourse', str(task)])

def rsyncTimecoursesForTask(task):
    directory = getTimecourseDirectory() + "/"
    for ip in IPS:
        pass
        #rsync -ravzX --delete mkoenig@ip:directory directory

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
    
    
    
    # TODO full rsync
    
    
    # copy timecourses to target folder
    
    tc_target_dir = '/'.join([directory, str(task)])
    
    # shutil.copy2(sbml_file, directory)
    shutil.copy2(tc_dir, tc_target_dir)
    
if __name__ == '__main__':
    
    task = Task.objects.get(pk=1)
    folder = "/home/mkoenig/multiscale-galactose-results/2014-06-10_" + str(task) 
    
    print task.pk, task.simulator
    print folder
    prepareDataForAnalysis(task, folder)
    
    
    
    
    
    
    