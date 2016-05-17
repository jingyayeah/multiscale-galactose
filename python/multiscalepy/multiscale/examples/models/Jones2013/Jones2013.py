"""
Jones2013 PKPD model.
"""

from __future__ import print_function, division
import os
from sbmlutils.modelcreator import modelcreator
import Jones2013_cell as model

base_dir = os.path.dirname(os.path.abspath(__file__))
target_dir = os.path.join(base_dir, 'results')
sbml_path = os.path.join(target_dir, '{}_{}.xml'.format(model.mid, model.version))


def create_model():
    """ Create caffeine models. """
    modelcreator.create_model(modules=['multiscale.examples.models.Jones2013.Jones2013_cell'],
                              target_dir=target_dir)


#################################################################################################
if __name__ == "__main__":
    create_model()
