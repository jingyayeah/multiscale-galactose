"""
Managing file locations and paths.
For working with the interface to the django application, use
    import django
    django.setup()

@author: Matthias Koenig
@date: 2015-05-06
"""

import os    
MULTISCALE_GALACTOSE = os.environ['MULTISCALE_GALACTOSE']
MULTISCALE_GALACTOSE_RESULTS = os.environ['MULTISCALE_GALACTOSE_RESULTS']

SIM_DIR = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'tmp_sim'])
SBML_DIR = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'tmp_sbml'])


# COPASI_EXEC = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'cpp/copasi/CopasiModelRunner/build/CopasiModelRunner'])

# Computer in network participating in simulations
COMPUTERS = {'10.39.34.27': 'core',
             '10.39.32.189': 'sysbio1',
             '10.39.32.106': 'mint',
             '10.39.32.111': 'sysbio2',
             '10.39.32.236': 'zenbook',
             '192.168.1.100': 'home',
             '192.168.1.99': 'zenbook',
             '127.0.0.1': 'localhost'}
