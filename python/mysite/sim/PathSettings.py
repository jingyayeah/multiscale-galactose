'''
Simulation settings, namely folders

Created on Jul 3, 2014
@author: mkoenig
'''

import sys
import os
import logging

sys.path.append('/home/mkoenig/multiscale-galactose/python')

# has to be overwritten
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

if not os.environ.has_key('MULTISCALE_GALACTOSE'):
    os.environ['MULTISCALE_GALACTOSE'] = '/home/mkoenig/multiscale-galactose'
if not os.environ.has_key('MULTISCALE_GALACTOSE_RESULTS'):
    os.environ['MULTISCALE_GALACTOSE_RESULTS'] = '/home/mkoenig/multiscale-galactose-results'
if not os.environ.has_key('SBML_DIR'):
    os.environ['SBML_DIR'] = os.environ['MULTISCALE_GALACTOSE_RESULTS'] + '/tmp_sbml'

print os.environ['DJANGO_SETTINGS_MODULE']
logging.debug('Settings loaded')


MULTISCALE_GALACTOSE = os.environ['MULTISCALE_GALACTOSE']
MULTISCALE_GALACTOSE_RESULTS = os.environ['MULTISCALE_GALACTOSE_RESULTS']
SBML_DIR = os.environ['SBML_DIR']