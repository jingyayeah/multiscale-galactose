import os
import sys
root = os.path.join(os.path.dirname(__file__), '..')
sys.path.insert(0, root)
sys.path.append('/usr/local/lib/python2.7/site-packages/libsbml')
sys.path.append('/usr/local/lib/python2.7/site-packages/libsedml')
sys.path.append('/home/mkoenig/multiscale-galactose/python')
sys.path.append('/home/mkoenig/multiscale-galactose/python/mysite')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
