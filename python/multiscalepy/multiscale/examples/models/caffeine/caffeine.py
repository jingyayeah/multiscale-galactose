"""
Model of hepatic caffeine clearance.
"""
# TODO: include microsome compartment

from __future__ import print_function, division
import os
from sbmlutils.modelcreator import modelcreator
from caffeine_cell import mid, version

name = 'caffeine'
base_dir = os.path.dirname(os.path.abspath(__file__))
target_dir = os.path.join(base_dir, 'results')
sbml_path = os.path.join(target_dir, '{}_{}.xml'.format(mid, version))


def create_model():
    """ Create model. """
    return modelcreator.create_model(modules=['multiscale.examples.models.templates.hepatocyte',
                                              'multiscale.examples.models.caffeine.caffeine_cell'],
                                     target_dir=target_dir)


#################################################################################################
if __name__ == "__main__":
    create_model()
