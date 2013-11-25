from django.conf.urls import patterns, url

from simulation import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    # ex: /polls/5/
    url(r'^model/(?P<model_id>\d+)/$', views.model, name='model'),
    # ex: /polls/5/results/
    url(r'^integration/(?P<integration_id>\d+)/$', views.integration, name='results'),
    # ex: /polls/5/vote/
    url(r'^parameters/(?P<pcol_id>\d+)/', views.parameters, name='vote'),
)