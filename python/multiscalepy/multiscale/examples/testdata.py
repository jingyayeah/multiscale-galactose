"""
Managing the test data.
"""

import os
test_dir = os.path.dirname(os.path.abspath(__file__))

demo_id = 'Koenig_demo_v09'
galactose_id = 'galactose_29_annotated'
demo_sbml = os.path.join(test_dir, 'models/demo', '{}.xml'.format(demo_id))
galactose_singlecell_sbml = os.path.join(test_dir, 'models/galactose', '{}.xml'.format(galactose_id))
galactose_tissue_sbml = os.path.join(test_dir, 'models/galactose', 'Galactose_v128_Nc20_dilution.xml')


csv_filepath = os.path.join(test_dir, 'data', 'test.csv')

