"""
Check the charge and formula balance of the model.
Run some simple FBA simulations.
"""
from __future__ import print_function, division
import os
import cobra
import libsbml
from sbmlutils import fbc

from multiscale.examples.models.demo import demo

def example(path):
    """
    Example FBA with demo model.

    :param path:
    :type path:
    :return:
    :rtype:
    """
    doc = libsbml.readSBMLFromFile(path)

    # add defaults
    fbc.add_default_flux_bounds(doc)

    import tempfile
    f = tempfile.NamedTemporaryFile('w', suffix='xml')
    libsbml.writeSBMLToFile(doc, f.name)
    f.flush()
    model = cobra.io.read_sbml_model(f.name)

    # mass/charge balance
    for r in model.reactions:
        mb = r.check_mass_balance()
        print(r.id, mb)


if __name__ == "__main__":
    example(path=demo.demo_sbml)
