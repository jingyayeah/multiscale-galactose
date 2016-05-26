"""
Definition of general information, like latest model.
"""
from __future__ import print_function, division
import os
import galactose_cell

name = 'galactose'
base_dir = os.path.dirname(os.path.abspath(__file__))
target_dir = os.path.join(base_dir, 'results')

galactose_singlecell_sbml = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                         'results',
                                         '{}_{}.xml'.format(galactose_cell.mid, galactose_cell.version))
