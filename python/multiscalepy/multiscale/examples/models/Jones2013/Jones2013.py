"""
Jones2013 PKPD model.
"""

from __future__ import print_function, division
import os
from sbmlutils.modelcreator import modelcreator

base_dir = os.path.dirname(os.path.abspath(__file__))
target_dir = os.path.join(base_dir, 'results')


def create_model():
    """ Create SBML models. """
    modelcreator.create_model(modules=['multiscale.examples.models.Jones2013.Jones2013_model'],
                              target_dir=target_dir)

    # simplified pkpd model
    modelcreator.create_model(modules=['multiscale.examples.models.Jones2013.pkpd_model'],
                              target_dir=target_dir)


#################################################################################################
if __name__ == "__main__":
    create_model()
