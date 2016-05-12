"""
Definition of general information, like latest model.
"""
from __future__ import print_function, division
import os
import Cell
galactose_singlecell_sbml = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                         'results',
                                         '{}_{}.xml'.format(Cell.mid, Cell.version))