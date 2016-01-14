"""
Managing the test data.
"""

import os
test_dir = os.path.dirname(os.path.abspath(__file__))

################################################################
# Models
################################################################

# demo -----------------------
demo_id = 'Koenig_demo_v09'
demo_sbml = os.path.join(test_dir, 'models/demo', '{}.xml'.format(demo_id))

# galactose ------------------
galactose_id = 'galactose_29_annotated'
galactose_singlecell_sbml = os.path.join(test_dir, 'models/galactose', '{}.xml'.format(galactose_id))
galactose_tissue_sbml = os.path.join(test_dir, 'models/galactose', 'Galactose_v128_Nc20_dilution.xml')

# test -----------------------
test_id = 'test_6'
test_sbml = os.path.join(test_dir, 'models/test', '{}.xml'.format(demo_id))

# van_der_pol ---------------
vdp_id = "van_der_pol"
vdp_sbml = os.path.join(test_dir, 'models/van_der_pol', '{}.xml'.format(vdp_id))


################################################################
# Data
################################################################
csv_filepath = os.path.join(test_dir, 'data', 'test.csv')

