from django.contrib import admin
from simapp.models import Core, CompModel, Parameter
from simapp.models import Result, Simulation, Task

class CoreAdmin(admin.ModelAdmin):
    list_display = ('pk', 'ip', 'cpu', 'time', 'active')
    list_filter = ['time']

class CompModelAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'model_id', 'model_format', 'file')

class ParameterAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'key', 'value', 'unit', 'parameter_type')

class ResultAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'simulation', 'file')

class SimulationAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'task', 'status', 'time_create', 'time_assign', 'core')

class TaskAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'model', 'method', 'priority', 'info')

admin.site.register(Core, CoreAdmin)
admin.site.register(CompModel, CompModelAdmin)
admin.site.register(Parameter, ParameterAdmin)
admin.site.register(Result, ResultAdmin)
admin.site.register(Simulation, SimulationAdmin)
admin.site.register(Task, TaskAdmin)
