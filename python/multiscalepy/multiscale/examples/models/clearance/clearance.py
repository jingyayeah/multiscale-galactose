"""
Simple test model for the clearance of hepatic substances.
"""

from __future__ import print_function, division
import os
from sbmlutils.modelcreator import modelcreator
import clearance_cell

name = 'clearance'
base_dir = os.path.dirname(os.path.abspath(__file__))
target_dir = os.path.join(base_dir, 'results')
sbml_path = os.path.join(target_dir, '{}_{}.xml'.format(clearance_cell.mid, clearance_cell.version))


def create_model():
    """ Create model. """
    return modelcreator.create_model(modules=['multiscale.examples.models.templates.units',
                                              'multiscale.examples.models.templates.hepatocyte',
                                              'multiscale.examples.models.clearance.clearance_cell'],
                                     target_dir=target_dir)


#################################################################################################
if __name__ == "__main__":
    create_model()
