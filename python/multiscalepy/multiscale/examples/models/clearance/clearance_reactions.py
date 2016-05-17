"""
Clearance example for model coupling.

Substance S is transformed by the liver into P which than can be exported.
"""
from sbmlutils.modelcreator.processes.ReactionTemplate import ReactionTemplate
import sbmlutils.modelcreator.modelcreator as mc

#############################################################################################
#    REACTIONS
#############################################################################################

# S import
ST = ReactionTemplate(
    rid='ST',
    name='S transporter',
    equation='S_ext <-> S []',
    compartment='pm',
    pars=[
        mc.Parameter('ST_keq', 1, 'dimensionless'),
        mc.Parameter('ST_k_S', 0.1, 'mM'),
        mc.Parameter('ST_Vmax', 10, 'mole_per_s'),
    ],
    rules=[],
    formula=('f_cl * (ST_Vmax/ST_k_S) * (S_ext - S/ST_keq) / ' +
                '(1 dimensionless + S_ext/ST_k_S + S/ST_k_S)', 'mole_per_s')
)

S2P = ReactionTemplate(
    rid='S2P',
    name='S2P (S => P)',
    equation='S => P []',
    compartment='c',
    pars=[
        mc.Parameter('S2P_k_S', 0.1, 'mM'),
        mc.Parameter('S2P_Vmax', 8.4, 'mole_per_s'),
    ],
    formula=('f_cl * S2P_Vmax * S/(S2P_k_S + S)', 'mole_per_s')
)

# P import
PT = ReactionTemplate(
    rid='PT',
    name='P transporter',
    equation='P_ext <-> P []',
    compartment='pm',
    pars=[
        mc.Parameter('PT_keq', 1, 'dimensionless'),
        mc.Parameter('PT_k_P', 0.1, 'mM'),
        mc.Parameter('PT_Vmax', 10, 'mole_per_s'),
    ],
    rules=[],
    formula=('f_cl * (PT_Vmax/PT_k_P) * (P_ext - P/PT_keq) / ' +
                '(1 dimensionless + P_ext/PT_k_P + P/PT_k_P)', 'mole_per_s')
)