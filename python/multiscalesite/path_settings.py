'''
Handling the locations for files in one place.
For working with the interface to the django application, use
    import django
    django.setup()

@author: Matthias Koenig
@date: 2015-05-06
'''

import os    
MULTISCALE_GALACTOSE = os.environ['MULTISCALE_GALACTOSE']

# here the temporary files are created
MULTISCALE_GALACTOSE_RESULTS = os.environ['MULTISCALE_GALACTOSE_RESULTS']
SIM_DIR = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'tmp_sim'])
SBML_DIR = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'tmp_sbml'])

COPASI_EXEC = "/".join([MULTISCALE_GALACTOSE_RESULTS, 'cpp/copasi/CopasiModelRunner/build/CopasiModelRunner'])
