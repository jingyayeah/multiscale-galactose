
from __future__ import print_function, division
import os
import hepatocyte, sinusoidal_unit

from sbmlutils.modelcreator import modelcreator

base_dir = os.path.dirname(os.path.abspath(__file__))
sbml_hepatocyte = os.path.join(base_dir, 'results', '{}_{}.xml'.format(hepatocyte.mid, hepatocyte.version))
sbml_sinusoidal_unit = os.path.join(base_dir, 'results', '{}_{}.xml'.format(sinusoidal_unit.mid, sinusoidal_unit.version))


def create_templates():
    """ Create template models. """
    modelcreator.create_model(target_dir=os.path.join(base_dir, 'results'),
                              modules=['multiscale.examples.models.templates.units',
                                       'multiscale.examples.models.templates.hepatocyte'])

    modelcreator.create_model(target_dir=os.path.join(base_dir, 'results'),
                              modules=['multiscale.examples.models.templates.units',
                                       'multiscale.examples.models.templates.sinusoidal_unit'])

#################################################################################################
if __name__ == "__main__":
    create_templates()
