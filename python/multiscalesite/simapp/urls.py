from django.conf.urls import patterns, url

from simapp import views
from simapp.sbml import sbml_report

urlpatterns = patterns('',
    url(r'^models/$', views.models, name='models'),
    url(r'^cores/$', views.cores, name='cores'),
    url(r'^simulations/(?P<status>\w+)$', views.simulations, name='simulations'),
    url(r'^simulations/$', views.simulations, name='simulations'),
    url(r'^simulation/(?P<simulation_id>\d+)$', views.simulation, name='simulation'),
    
    url(r'^report/(?P<model_pk>\d+)$', sbml_report.report, name='report'),
    
    url(r'^methods/$', views.methods, name='methods'),
    url(r'^results/$', views.results, name='results'),

    url(r'^tasks/$', views.tasks, name='tasks'),
    url(r'^task/(?P<task_id>\d+)$', views.task, name='task'),
    url(r'^task/T(?P<task_id>\d+)$', views.task_parameters, name='task_parameters'),
    # url(r'^plots/$', views.plots, name='plots'),
    url(r'^about/$', views.about, name='about'),
    url(r'^$', views.models, name='index'),
)