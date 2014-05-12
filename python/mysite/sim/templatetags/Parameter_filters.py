'''
Created on May 12, 2014
@author: mkoenig
'''

from sim.analysis.AnalysisTools import createParameterFileForTask
from django import template
from django.http.response import HttpResponse
register = template.Library()

@register.filter
def Parameter_file(task):
    folder = "/home/mkoenig/multiscale-galactose-results/"
    createParameterFileForTask(folder, task)
    print 'Parameter file generated'
    return HttpResponse("Parameter file written")
    
    
     
