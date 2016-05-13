"""
Simple test model for the clearance of hepatic substances.
"""

from __future__ import print_function, division
import os
import Cell

from sbmlutils.modelcreator import modelcreator

name = 'clearance'
model_module = 'multiscale.examples.models'
base_dir = os.path.dirname(os.path.abspath(__file__))
sbml_path = os.path.join(base_dir, 'results', '{}_{}.xml'.format(Cell.mid, Cell.version))


def create_model():
    """ Create model. """
    return modelcreator.create_model(target_dir=os.path.join(base_dir, 'results'),
                                     model_info=['{}.{}'.format(model_module, 'hepatocyte'),
                                                 '{}.{}'.format(model_module, name)],
                                     f_annotations=None)


#################################################################################################
if __name__ == "__main__":
    create_model()
