"""
Sinusoidal flow model.

Additional information to the structural sinusoidal unit model
to implement flow.
"""
import sbmlutils.modelcreator.modelcreator as mc
from sbmlutils.modelcreator import templates

mid = 'sinusoidal_flow'
version = 1

parameters = [
    mc.Parameter('flow_sin', 229E-6, 'm_per_s', name='sinusoidal flow velocity'),
]

rules = [
    mc.Rule('Q_sinunit', 'pi*y_sin^2*flow_sin', 'm3_per_s', name='volume flow sinusoid'),
]



