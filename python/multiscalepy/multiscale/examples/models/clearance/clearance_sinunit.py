"""
Sinusoidal Unit information
"""
from __future__ import print_function, division
from sbmlutils.modelcreator.factory import sinunit
from sbmlutils.modelcreator import CoreModel
from sbmlutils.modelcreator import db





#####################################################################################
if __name__ == "__main__":

    sin_species = [
        sinunit.SinusoidSpecies('gal', 1.0, unit='mM', D=db.diffusion['gal'], r=db.radius['gal']),
        sinunit.SinusoidSpecies('suc', 1.0, unit='mM', D=db.diffusion['suc'], r=db.radius['suc']),
    ]

    # Create the sinusoidal model
    core_model = CoreModel()
    core_model.mid = 'Sinusoid_Test'
    core_model.version = 1
    f = sinunit.SinusoidalUnitFactory(Nc=5, sin_species=sin_species, core_model=core_model)
    print(f.mid)
    print(f.core_model)
    f.core_model.info()

    core_model.create_sbml()

