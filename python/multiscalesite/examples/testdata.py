"""

@author: mkoenig
@date: 2015-??-?? 
"""

import os
test_dir = os.path.dirname(os.path.abspath(__file__))

demo_model_id = 'Koenig_demo_v02'
demo_filepath = os.path.join(test_dir, 'demo', '{}.xml'.format(demo_model_id))

csv_filepath = os.path.join(test_dir, 'data', 'test.csv')
