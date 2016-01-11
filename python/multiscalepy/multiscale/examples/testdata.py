"""
Managing the test data.
"""

import os
test_dir = os.path.dirname(os.path.abspath(__file__))

galactose_singlecell_sbml = os.path.join(test_dir, 'models/galactose', 'galactose_29_annotated.xml')
demo_filepath = os.path.join(test_dir, 'models/demo', 'Koenig_demo_v09.xml')
csv_filepath = os.path.join(test_dir, 'data', 'test.csv')

