"""
Sinusoidal Unit information
"""
from __future__ import print_function, division
from sbmlutils.modelcreator.factory import sinunit
from sbmlutils.modelcreator import CoreModel, Preprocess
from sbmlutils.modelcreator import db


#####################################################################################
if __name__ == "__main__":
    import os

    sin_species = [
        sinunit.SinusoidSpecies('S', 1.0, unit='mM', D=db.diffusion['S'], r=db.radius['S'], name="substance S"),
        sinunit.SinusoidSpecies('P', 1.0, unit='mM', D=db.diffusion['P'], r=db.radius['P'], name="product P"),
    ]

    # Create the sinusoidal model
    model_dict = Preprocess.dict_from_modules(modules=['multiscale.examples.models.templates.units',
                                                       'multiscale.examples.models.templates.sinusoidal_unit'])
    core_model = CoreModel.from_dict(model_dict)
    core_model.mid = 'Sinusoid_Clearance'
    core_model.version = 2

    # extends the core model
    f = sinunit.SinusoidalUnitFactory(Nc=5, sin_species=sin_species, core_model=core_model)
    f.core_model.info()

    core_model.create_sbml()
    target_dir = os.path.join('.', 'results')
    sbml_path = os.path.join(target_dir, '{}.xml'.format(core_model.model_id))
    core_model.write_sbml(filepath=sbml_path)

    from sbmlutils.report import sbmlreport
    sbmlreport.create_sbml_report(sbml_path, out_dir=target_dir)
