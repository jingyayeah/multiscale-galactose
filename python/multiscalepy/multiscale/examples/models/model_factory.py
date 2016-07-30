"""
Create all the example models.
"""
from __future__ import print_function, division
import os
from sbmlutils import modelcreator

models_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)))
model_module = 'multiscale.examples.models'

# TODO: Create the Tissue & PKPD models

"""
def tissue_model():
     # definition of cell model and tissue model
    Nc = 1
    Nf = 1
    version = 129
    cell_model = CellModel.create_model('multiscale.modelcreator.models.galactose.GalactoseCell')
    tissue_dict = TissueModel.createTissueDict(['multiscale.modelcreator.models.SinusoidalUnit',
                                                'multiscale.modelcreator.models.galactose.GalactoseSinusoid'])

    # ---------------------------------------------------------------------------------
    # [1] core model
    # Model without events. Basic model.
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='core', events=None)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model

    # ---------------------------------------------------------------------------------
    # [2A] multiple dilution indicator
    #    _
    # __| |__ (short rectangular peak in all periportal species)
    # The multiple dilution indicator peak is applied after the system has
    # reached steady state (<1000s) from initial non galactose conditions.
    events = EventData.rect_dilution_peak()
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='dilution', events=events)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model, events

    # [2B] multiple dilution indicator (Gauss peak)
    events = EventData.gauss_dilution_peak()
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='dilution_gauss', events=events)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model, events

    # ---------------------------------------------------------------------------------
    # [3] galactose challenge
    # Continous galactose challenge periportal applied (galactose pp__gal) after
    # system has reached steady state. Simulation continued until new steady state
    # under challenge conditions is reached.
    #    ________
    # __|
    events = EventData.galactose_challenge(tc_start=2000.0)
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='galchallenge', events=events)
    tissue_model.createModel()
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
    del tissue_model, events

    # ---------------------------------------------------------------------------------
    # [4] galactose step
    # Step-wise increase in the galactose concentration until new steady state
    # concentrations are reached in the system.
    #        _
    #      _| |
    #    _|   |
    # __|     |___
    events = EventData.galactose_step_increase()
    tissue_model = TissueModel(Nc=Nc, Nf=Nf, version=version, tissue_dict=tissue_dict,
                               cell_model=cell_model, sim_id='galstep', events=events)
    sbml_path = tissue_model.writeSBML()
    db_api.create_model(sbml_path, model_format=db_api.CompModelFormat.SBML)
"""

#############################################################################################




def create_Jones2013():
    """ Create PKPD example. """
    name = 'Jones2013'
    return modelcreator.create_model(target_dir=os.path.join(models_dir, name, 'results'),
                                     model_info=['{}.{}'.format(model_module, name)])

def create_Jones2013Reactions():
    """ Create PKPD example. """
    name = 'Jones2013Reactions'
    return modelcreator.create_model(target_dir=os.path.join(models_dir, name, 'results'),
                                     model_info=['{}.{}'.format(model_module, name)])

def create_Sturis1991():
    """ Glucose-Insulin model. """
    name = 'Sturis1991'
    return modelcreator.create_model(target_dir=os.path.join(models_dir, name, 'results'),
                                     model_info=['{}.{}'.format(model_module, name)])

def create_Engelborghs2001():
    """ Glucose-Insulin model with delay. """
    name = 'Engelborghs2001'
    return modelcreator.create_model(target_dir=os.path.join(models_dir, name, 'results'),
                                     model_info=['{}.{}'.format(model_module, name)])

def create_glucose():
    """ Create glucose network. """
    name = 'glucose'
    return modelcreator.create_model(target_dir=os.path.join(models_dir, name, 'results'),
                                     model_info=['{}.{}'.format(model_module, name)],
                                     f_annotations=os.path.join(models_dir, name, 'glucose_annotations.xlsx'))

def create_galactose():
    """ Create galactose network. """
    name = 'galactose'
    base_dir = os.path.join(models_dir, name)
    target_dir = os.path.join(base_dir, 'results')
    model_info = ['{}.{}'.format(model_module, 'hepatocyte'),
                  '{}.{}'.format(model_module, name)]
    # create without annotations
    modelcreator.create_model(target_dir=target_dir,
                 model_info=model_info,
                 f_annotations=None,
                 suffix="_no_annotations")
    # create with annotations
    return modelcreator.create_model(target_dir=target_dir,
                                     model_info=model_info,
                                     f_annotations=os.path.join(base_dir, '{}_annotations.xlsx'.format(name)))

def create_caffeine():
    """ Create caffeine network. """
    name = 'caffeine'
    base_dir = os.path.join(models_dir, name)
    return modelcreator.create_model(target_dir=os.path.join(base_dir, 'results'),
                                     model_info=['{}.{}'.format(model_module, 'hepatocyte'),
                                                 '{}.{}'.format(model_module, name)],
                                     f_annotations=os.path.join(base_dir, 'caffeine_annotations.xlsx'))

#########################################################################
if __name__ == "__main__":
    # ------------------------------------------
    # Test models
    # ------------------------------------------
    '''
    from multiscale.examples.models.demo import demo
    [cell_dict, cell_model] = demo.create_demo()
    '''

    '''
    # ------------------------------------------
    # PKPD models
    # ------------------------------------------
    [cell_dict, cell_model] = create_Jones2013()
    [cell_dict, cell_model] = create_Jones2013Reactions()

    # ------------------------------------------
    # Glucose-Insulin system
    # ------------------------------------------
    [cell_dict, cell_model] = create_Sturis1991()
    [cell_dict, cell_model] = create_Engelborghs2001()
    [cell_dict, cell_model] = create_glucose()
    '''

    # ------------------------------------------
    # Liver clearance
    # ------------------------------------------
    [cell_dict, cell_model] = create_caffeine()
    [cell_dict, cell_model] = create_galactose()

