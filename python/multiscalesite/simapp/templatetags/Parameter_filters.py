"""

@author: Matthias Koenig
@date: 2014-04-14
"""

from django import template
from django.http.response import HttpResponse

from simapp.reports.task_report import createParameterFileForTask

register = template.Library()


@register.filter
def Parameter_file(task):
    folder = "/home/mkoenig/multiscale-galactose-results/"
    createParameterFileForTask(folder, task)
    return HttpResponse("Parameter file written")
