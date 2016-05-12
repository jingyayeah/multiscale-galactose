"""
General settings for demo network
"""
from sbmlutils import modelcreator

import os
import Cell

base_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)))
demo_sbml = os.path.join(base_dir, 'results', '{}_{}.xml'.format(Cell.mid, Cell.version))
model_module = 'multiscale.examples.models'


def create_demo():
    """ Create demo network. """
    target_dir = os.path.join(base_dir, 'results')
    f_annotations = os.path.join(base_dir, 'demo_annotations.xlsx')

    # python model info
    model_info = ['{}.demo'.format(model_module)]

    modelcreator.create_model(target_dir, model_info, f_annotations=None, suffix='_no_annotations')
    return modelcreator.create_model(target_dir, model_info, f_annotations)


if __name__ == "__main__":
    create_demo()
