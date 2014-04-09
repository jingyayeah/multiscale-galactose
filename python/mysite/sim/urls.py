from django.conf.urls import patterns, url

from sim import views

urlpatterns = patterns('',
    
    # ex: /core/
    url(r'^cores/$', views.cores, name='cores'),
    url(r'^simulations/(?P<status>\w+)$', views.simulations, name='simulations'),
    url(r'^simulations/$', views.simulations, name='simulations'),
    url(r'^timecourses/$', views.timecourses, name='timecourses'),
    url(r'^simulation/(?P<simulation_id>\d+)$', views.simulation, name='simulation'),
    
    url(r'^model/(?P<model_id>\d+)/$', views.model, name='model'),
    # ex: /polls/5/results/
    url(r'^integrations/$', views.integrations, name='integrations'),
    # ex: /polls/5/vote/
    url(r'^parameters/(?P<pcol_id>\d+)/$', views.parameters, name='vote'),
    
    url(r'^models/$', views.index, name='models'),
    url(r'^tasks/$', views.tasks, name='tasks'),
    url(r'^task/(?P<task_id>\d+)$', views.task, name='task'),
    url(r'^plots/$', views.plots, name='plots'),
    url(r'^$', views.index, name='index'),
)