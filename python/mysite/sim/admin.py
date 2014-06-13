from django.contrib import admin
from sim.models import *

class CoreAdmin(admin.ModelAdmin):
    list_display = ('pk', 'ip', 'cpu', 'time', 'active')
    list_filter = ['time']

class SBMLModelAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'sbml_id', 'file')


class ParameterAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'name', 'value', 'unit', 'ptype')

class TimecourseAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'simulation', 'file')

class SimulationAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'task', 'status', 'time_create', 'time_assign', 'core')

class TaskAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'sbml_model', 'integration', 'subtask', 'simulator', 'priority', 'info')

admin.site.register(Core, CoreAdmin)
admin.site.register(SBMLModel, SBMLModelAdmin)
admin.site.register(Parameter, ParameterAdmin)
admin.site.register(Timecourse, TimecourseAdmin)
admin.site.register(Simulation, SimulationAdmin)
admin.site.register(Task, TaskAdmin)
