"""
Check the charge and formula balance of the model.
"""
from __future__ import print_function, division
from sbmlutils import fbc
from galactose import galactose_singlecell_sbml

if __name__ == "__main__":
    fbc.check_balance(galactose_singlecell_sbml)
    model = fbc.load_cobra_model(galactose_singlecell_sbml)

