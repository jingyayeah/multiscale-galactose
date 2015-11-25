"""
Performing metabolic control analysis with a simple model.
"""
from __future__ import print_function
import pandas as pd
import numpy as np
from pandas import DataFrame

import roadrunner
roadrunner.Config.setValue(roadrunner.Config.LOADSBMLOPTIONS_CONSERVED_MOIETIES, True)


# equidistant time course for 20 [s]
rr = roadrunner.RoadRunner("mca.xml")
s = rr.simulate(0, 40, 100, plot=True)

rr.getSteadyStateValues()

# Scaled control coefficient with respect to a global parameter.
# ! This should give a numerical value, but is nan ???
print('CC:', rr.getCC('bA', 'Vmax_bA'))


# The n by n matrix of scaled flux control coefficients 
# where n is the number of reactions.
print('** Scaled Flux Control Coefficients **')
C_J = DataFrame(rr.getScaledFluxControlCoefficientMatrix(), \
                index=rr.model.getReactionIds(), \
                columns=rr.model.getReactionIds())
print(C_J)

# The m by n matrix of scaled concentration control coefficients where m is the number
# of floating species and n the number of reactions.
print('** Scaled Concentration Control Coefficients **')
C_S = DataFrame(rr.getScaledConcentrationControlCoefficientMatrix(), \
                index=rr.model.getFloatingSpeciesIds(), \
                columns=rr.model.getReactionIds())
print(C_S)

# Flux control coefficients have to sum to 1
print('** Summation theorem flux control (=1) **')
print(np.sum(C_J, axis=1))
print(abs(np.sum(C_J, axis=1)-1) < 1E-6)
# ! The three transporters do not sum up to 1 ???

# Concentration control coefficients have to sum to 0
print('** Summation theorem concentration control (=0) **')
print(np.sum(C_S, axis=1))
print(np.sum(C_S, axis=1) < 1E-6)
