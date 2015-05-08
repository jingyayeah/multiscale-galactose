'''
Created on May 12, 2014
@author: mkoenig
'''


from django import template
from django.http.response import HttpResponse

from simapp.analysis.ParameterFiles import createParameterFileForTask

register = template.Library()

@register.filter
def Parameter_file(task):
    folder = "/home/mkoenig/multiscale-galactose-results/"
    createParameterFileForTask(folder, task)
    print 'Parameter file generated'
    return HttpResponse("Parameter file written")
    
    
     
