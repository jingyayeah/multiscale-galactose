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
    sin_species = [
        sinunit.SinusoidSpecies('S', 1.0, unit='mM', D=db.diffusion['S'], r=db.radius['S'], name="substance S"),
        sinunit.SinusoidSpecies('P', 0.0, unit='mM', D=db.diffusion['P'], r=db.radius['P'], name="product P"),
    ]

    # Create sinusoidal model
    model_dict = Preprocess.dict_from_modules(modules=['multiscale.examples.models.templates.units',
                                                       'multiscale.examples.models.templates.sinusoidal_unit'])
    core_model = CoreModel.from_dict(model_dict)
    core_model.mid = 'Sinusoid_Clearance'
    Nc = 5
    version = 'v2'
    core_model.version = 'Nc{}_{}'.format(Nc, version)

    # extends the core model
    f = sinunit.SinusoidalUnitFactory(Nc=Nc, sin_species=sin_species, core_model=core_model)
    f.core_model.info()

    core_model.create_sbml()
    sbml_path = os.path.join(target_dir, '{}.xml'.format(core_model.model_id))
    core_model.write_sbml(filepath=sbml_path)

    from sbmlutils.report import sbmlreport
    sbmlreport.create_sbml_report(sbml_path, out_dir=target_dir)


#################################################################################################
if __name__ == "__main__":
    create_model()
    create_sinusoidal_unit()
