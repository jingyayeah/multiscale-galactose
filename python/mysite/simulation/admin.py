from django.contrib import admin
from simulation.models import *

class SBMLModelAdmin(admin.ModelAdmin):
    pass

class IntegrationAdmin(admin.ModelAdmin):
    pass

class ParameterAdmin(admin.ModelAdmin):
    pass

class ParameterSetAdmin(admin.ModelAdmin):
    pass

class TimecourseAdmin(admin.ModelAdmin):
    pass

class SimulationAdmin(admin.ModelAdmin):
    pass

class TaskAdmin(admin.ModelAdmin):
    pass


admin.site.register(SBMLModel, SBMLModelAdmin)
admin.site.register(Integration, IntegrationAdmin)
admin.site.register(Parameter, ParameterAdmin)
admin.site.register(ParameterSet, ParameterSetAdmin)
admin.site.register(Timecourse, TimecourseAdmin)
admin.site.register(Simulation, SimulationAdmin)
admin.site.register(Task, TaskAdmin)
