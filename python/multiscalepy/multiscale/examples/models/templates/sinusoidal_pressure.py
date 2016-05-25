"""
Sinusoidal pressure model.

Pressure based model for comparison.
"""
import sbmlutils.modelcreator.modelcreator as mc
from sbmlutils.modelcreator import templates

mid = 'sinusoidal_pressure'
version = 1

parameters = [
    # flow
    mc.Parameter('Pa', 1333.22, 'Pa', name='pressure periportal'),  # 1mmHg = 133.322
    mc.Parameter('Pb', 266.64,  'Pa', name='pressure perivenious'),
    mc.Parameter('nu_f', 10.0, '-', name='viscosity factor for sinusoidal resistance'),
    mc.Parameter('nu_plasma', 0.0018, 'Pa_s', name='plasma viscosity'),
]

rules = [
    mc.Rule('P0', '0.5 dimensionless * (Pa+Pb)', 'Pa', name='resulting oncotic pressure P0 = Poc-Pot'),
    mc.Rule('nu', 'nu_f * nu_plasma', 'Pa_s', name='hepatic viscosity'),
    mc.Rule('W', '8 dimensionless * nu/(pi*y_sin^4)', 'Pa_s_per_m4', name='specific hydraulic resistance capillary'),
    mc.Rule('w', '4 dimensionless *nu*y_end/(pi^2* r_fen^4*y_sin*N_fen)', 'Pa_s_per_m2', name='specific hydraulic resistance of all pores'),
    mc.Rule('lambda', 'sqrt(w/W)', 'm', name='lambda reistance'),

    # pressure flow
    mc.Rule('flow_sin', 'PP_Q/A_sin', 'm_per_s', name='periportal flow velocity'),
    mc.Rule('Q_sinunit', 'PP_Q', 'm3_per_s', name='volume flow sinusoid'),
]

