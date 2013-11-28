from django.conf.urls import patterns, url

from sim import views

urlpatterns = patterns('',
    
    # ex: /core/
    url(r'^cores/$', views.cores, name='cores'),
    url(r'^simulations/$', views.simulations, name='simulations'),
    
    url(r'^model/(?P<model_id>\d+)/$', views.model, name='model'),
    # ex: /polls/5/results/
    url(r'^integration/(?P<integration_id>\d+)/$', views.integration, name='results'),
    # ex: /polls/5/vote/
    url(r'^parameters/(?P<pcol_id>\d+)/$', views.parameters, name='vote'),
    
    url(r'^$', views.index, name='index'),
)