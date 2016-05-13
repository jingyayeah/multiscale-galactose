
from __future__ import print_function, division
import os
import hepatocyte

from sbmlutils.modelcreator import modelcreator

base_dir = os.path.dirname(os.path.abspath(__file__))
sbml_path = os.path.join(base_dir, 'results', '{}_{}.xml'.format(hepatocyte.mid, hepatocyte.version))


def create_model():
    """ Create model. """
    return modelcreator.create_model(target_dir=os.path.join(base_dir, 'results'),
                                     model_info=['multiscale.examples.models.templates.hepatocyte'])


#################################################################################################
if __name__ == "__main__":
    create_model()
