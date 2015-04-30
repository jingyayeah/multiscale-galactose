'''
Simulation settings, namely folders

Created on Jul 3, 2014
@author: mkoenig
'''

import os
    
MULTISCALE_GALACTOSE = os.environ['MULTISCALE_GALACTOSE']
MULTISCALE_GALACTOSE_RESULTS = os.environ['MULTISCALE_GALACTOSE_RESULTS']

SIM_DIR = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'tmp_sim'])
SBML_DIR = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'tmp_sbml'])

COPASI_EXEC = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'cpp/copasi/CopasiModelRunner/build/CopasiModelRunner'])
