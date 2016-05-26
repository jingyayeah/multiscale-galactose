"""
Simple test model for the clearance of hepatic substances.
"""

from __future__ import print_function, division
import os
from sbmlutils.modelcreator import modelcreator
from sbmlutils.modelcreator.factory import sinunit
from sbmlutils.modelcreator import CoreModel, Preprocess
from sbmlutils.modelcreator import db

import clearance_cell

name = 'clearance'
base_dir = os.path.dirname(os.path.abspath(__file__))
target_dir = os.path.join(base_dir, 'results')

sbml_cell = os.path.join(target_dir, '{}_{}.xml'.format(clearance_cell.mid, clearance_cell.version))


def create_model():
    ######################################
    # single cell clearance model
    ######################################
    modelcreator.create_model(modules=['multiscale.examples.models.templates.units',
                                       'multiscale.examples.models.templates.hepatocyte',
                                       'multiscale.examples.models.clearance.clearance_cell'],
                              target_dir=target_dir)


def create_sinusoidal_unit():
    ######################################
    # sinusoidal unit transport model
    ######################################
    Nc = 5
    version = 'v4'

    sin_species = [
        sinunit.SinusoidSpecies('S', 1.0, unit='mM', D=db.diffusion['S'], r=db.radius['S'], name="substance S"),
        sinunit.SinusoidSpecies('P', 0.0, unit='mM', D=db.diffusion['P'], r=db.radius['P'], name="product P"),
    ]

    # Create sinusoidal flow and pressure models
    pressure_dict = Preprocess.dict_from_modules(modules=['multiscale.examples.models.templates.units',
                                                       'multiscale.examples.models.templates.sinusoidal_unit',
                                                       'multiscale.examples.models.templates.sinusoidal_pressure'])

    flow_dict = Preprocess.dict_from_modules(modules=['multiscale.examples.models.templates.units',
                                                          'multiscale.examples.models.templates.sinusoidal_unit',
                                                          'multiscale.examples.models.templates.sinusoidal_flow'])
    info_dict = {sinunit.SinusoidalUnitFactory.TYPE_PRESSURE: pressure_dict,
                 sinunit.SinusoidalUnitFactory.TYPE_FLOW: flow_dict}

    # info_dict = {sinunit.SinusoidalUnitFactory.TYPE_FLOW: flow_dict}
    # info_dict = {sinunit.SinusoidalUnitFactory.TYPE_PRESSURE: pressure_dict}

    for model_type, model_dict in info_dict.iteritems():


        s_model = CoreModel.from_dict(model_dict)
        s_model.version = 'Nc{}_{}'.format(Nc, version)

        # extend core model with sinusoidal unit information
        f = sinunit.SinusoidalUnitFactory(Nc=Nc, sin_species=sin_species, core_model=s_model, model_type=model_type)
        f.core_model.info()

        s_model.create_sbml()

        sbml_path = os.path.join(target_dir, '{}.xml'.format(s_model.model_id))
        s_model.write_sbml(filepath=sbml_path)

        from sbmlutils.report import sbmlreport
        sbmlreport.create_sbml_report(sbml_path, out_dir=target_dir)


#################################################################################################
if __name__ == "__main__":
    create_model()
    create_sinusoidal_unit()
