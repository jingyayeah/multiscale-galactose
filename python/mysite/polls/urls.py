'''
Created on Nov 18, 2013

@author: mkoenig
'''
from django.conf.urls import patterns, url

from polls import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index')
)