"""
Definition of general information, like latest model.
"""
from __future__ import print_function, division
import os
import Cell
from sbmlutils import modelcreator


current_dir = os.path.dirname(os.path.abspath(__file__))
models_dir = os.path.join('..', current_dir)
galactose_singlecell_sbml = os.path.join(current_dir, 'results', '{}_{}.xml'.format(Cell.mid, Cell.version))


def create_galactose():
    """
    Create galactose single cell model.
    """
    name = 'galactose'
    base_dir = os.path.join(models_dir, name)
    target_dir = os.path.join(base_dir, 'results')
    modules = ['multiscale.examples.models.templates.hepatocyte',
               'multiscale.examples.models.galactose.Cell']

    # create without annotations
    modelcreator.create_model(modules=modules,
                              target_dir=target_dir,
                              annotations=None,
                              suffix="_no_annotations",
                              create_report=False)
    # create with annotations
    return modelcreator.create_model(modules=modules,
                                     target_dir=target_dir,
                                     annotations=os.path.join(base_dir, '{}_annotations.xlsx'.format(name)))


if __name__ == "__main__":
    create_galactose()
