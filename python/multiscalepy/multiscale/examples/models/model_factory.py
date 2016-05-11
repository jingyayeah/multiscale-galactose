"""
Create all the example models.
"""
from __future__ import print_function, division
import os
from sbmlutils.modelcreator import create_model
from multiscale.examples.testdata import test_dir


def create_demo():
    """ Create demo network. """
    directory = os.path.join(test_dir, 'models', 'demo')
    model_info = ['multiscale.modelcreator.models.demo']
    d = os.path.dirname(os.path.abspath(__file__))
    f_annotations = os.path.join(d, 'models', 'demo', 'demo_annotations.xlsx')

    create_model(directory, model_info, f_annotations=None, suffix='_no_annotations')
    return create_model(directory, model_info, f_annotations)


def create_test():
    """ Create test network. """
    directory = os.path.join(test_dir, 'models', 'test')
    model_info = ['multiscale.modelcreator.models.hepatocyte',
                  'multiscale.modelcreator.models.test']
    return create_model(directory, model_info)


def create_galactose():
    """ Create galactose network. """
    directory = os.path.join(test_dir, 'models', 'galactose')
    model_info = ['multiscale.modelcreator.models.hepatocyte',
                  'multiscale.modelcreator.models.galactose']

    d = os.path.dirname(os.path.abspath(__file__))
    f_annotations = os.path.join(d, 'models', 'galactose', 'galactose_annotations.xlsx')
    create_model(directory, model_info, f_annotations=None, suffix="_no_annotations")
    return create_model(directory, model_info, f_annotations)


def create_glucose():
    """ Create glucose network. """
    directory = os.path.join(test_dir, 'models', 'glucose')
    model_info = ['multiscale.modelcreator.models.glucose']

    d = os.path.dirname(os.path.abspath(__file__))
    f_annotations = os.path.join(d, 'models', 'glucose', 'glucose_annotations.xlsx')

    return create_model(directory, model_info, f_annotations)


def create_caffeine():
    """ Create caffeine network. """
    directory = os.path.join(test_dir, 'models', 'caffeine')
    model_info = ['multiscale.modelcreator.models.hepatocyte',
                  'multiscale.modelcreator.models.caffeine']

    d = os.path.dirname(os.path.abspath(__file__))
    f_annotations = os.path.join(d, 'models', 'caffeine', 'caffeine_annotations.xlsx')

    return create_model(directory, model_info, f_annotations)


def create_Sturis1991():
    directory = os.path.join(test_dir, 'models', 'Sturis1991')
    model_info = ['multiscale.modelcreator.models.Sturis1991']
    return create_model(directory, model_info, f_annotations=None)


def create_Sturis1991Delay():
    directory = os.path.join(test_dir, 'models', 'Sturis1991Delay')
    model_info = ['multiscale.modelcreator.models.Sturis1991Delay']
    return create_model(directory, model_info, f_annotations=None)


def create_Jones2013():
    """ Create PKPD example. """
    directory = os.path.join(test_dir, 'models', 'Jones2013')
    model_info = ['multiscale.modelcreator.models.Jones2013']

    # d = os.path.dirname(os.path.abspath(__file__))
    # f_annotations = os.path.join(d, 'models', 'caffeine', 'caffeine_annotations.xlsx')

    return create_model(directory, model_info, f_annotations=None)


def create_AssignmentTest():
    """ Create PKPD example. """
    directory = os.path.join(test_dir, 'models', 'AssignmentTest')
    model_info = ['multiscale.modelcreator.models.AssignmentTest']
    return create_model(directory, model_info, f_annotations=None)


def create_PKPD():
    """ Create PKPD example. """
    directory = os.path.join(test_dir, 'models', 'PKPD')
    model_info = ['multiscale.modelcreator.models.PKPD']
    return create_model(directory, model_info, f_annotations=None)


#########################################################################
if __name__ == "__main__":

    [cell_dict, cell_model] = create_demo()


    # [cell_dict, cell_model] = create_Sturis1991()
    # [cell_dict, cell_model] = create_Sturis1991Delay()

    # [cell_dict, cell_model] = create_Jones2013()
    # [cell_dict, cell_model] = create_AssignmentTest()
    # [cell_dict, cell_model] = create_PKPD()


    # [cell_dict, cell_model] = create_caffeine()
    # [cell_dict, cell_model] = create_test()
    # [cell_dict, cell_model] = create_galactose()
    # [cell_dict, cell_model] = create_glucose()
