from django.contrib import admin
from simulation.models import *

class CoreAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'ip', 'cpu', 'time')

class SBMLModelAdmin(admin.ModelAdmin):
    pass

class IntegrationAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__',  'tstart', 'tend', 'tsteps', 'abs_tol', 'rel_tol')

class ParameterAdmin(admin.ModelAdmin):
    list_display = ('pk', '__unicode__', 'name', 'value', 'unit')

class ParameterInline(admin.TabularInline):
    model = ParameterCollection.parameters.through
    extra = 5

class ParameterCollectionAdmin(admin.ModelAdmin):
    inlines = [
        ParameterInline,
    ]
    exclude = ('parameters',)
    list_display = ('pk', '__unicode__', 'count')

class TimecourseAdmin(admin.ModelAdmin):
    pass

class SimulationAdmin(admin.ModelAdmin):
    pass

class TaskAdmin(admin.ModelAdmin):
    pass

admin.site.register(Core, CoreAdmin)
admin.site.register(SBMLModel, SBMLModelAdmin)
admin.site.register(Integration, IntegrationAdmin)
admin.site.register(ParameterCollection, ParameterCollectionAdmin)
admin.site.register(Parameter, ParameterAdmin)
admin.site.register(Timecourse, TimecourseAdmin)
admin.site.register(Simulation, SimulationAdmin)
admin.site.register(Task, TaskAdmin)
