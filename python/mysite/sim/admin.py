from django.contrib import admin
from sim.models import *

class CoreAdmin(admin.ModelAdmin):
    list_display = ('pk', 'computer', 'ip', 'cpu', 'time')
    list_filter = ['time']

class SBMLModelAdmin(admin.ModelAdmin):
    pass

class IntegrationAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__',  'tstart', 'tend', 'tsteps', 'abs_tol', 'rel_tol')

class ParameterAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'name', 'value', 'unit')


class TimecourseAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'simulation', 'file')

class SimulationAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'task', 'status', 'time_create', 'file')

class TaskAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'sbml_model', 'integration')

admin.site.register(Core, CoreAdmin)
admin.site.register(SBMLModel, SBMLModelAdmin)
admin.site.register(Integration, IntegrationAdmin)
admin.site.register(Parameter, ParameterAdmin)
admin.site.register(Timecourse, TimecourseAdmin)
admin.site.register(Simulation, SimulationAdmin)
admin.site.register(Task, TaskAdmin)
