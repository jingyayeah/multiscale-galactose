"""
Reactions and transporters of Demo metabolism.
"""

from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################
# bA: A_ext => A; (scale_f*(Vmax_bA/Km_A)*(A_ext - A))/(1 dimensionless + A_ext/Km_A + A/Km_A);
bA = ReactionTemplate(
    'bA',
    'bA (A import)',
    'A_ext => A []',
    localization='membrane',
    compartments=['cell, extern'],
    pars=[],
    rules=[],
    formula=('scale_f*(Vmax_bA/Km_A)*(A_ext - A)/ (1 dimensionless + A_ext/Km_A + A/Km_A)', 'mole_per_s')
)


# bB: B => B_ext; (scale_f*(Vmax_bB/Km_B)*(B - B_ext))/(1 dimensionless + B_ext/Km_B + B/Km_B);
bB = ReactionTemplate(
    'bB',
    'bB (B export)',
    'B => B_ext []',
    localization='membrane',
    compartments=['cell, extern'],
    pars=[],
    rules=[],
    formula=('(scale_f*(Vmax_bB/Km_B)*(B - B_ext))/(1 dimensionless + B_ext/Km_B + B/Km_B)', 'mole_per_s')
)

# bC: C => C_ext; (scale_f*(Vmax_bC/Km_C)*(C - C_ext))/(1 dimensionless + C_ext/Km_C + C/Km_C);
bC = ReactionTemplate(
    'bC',
    'bC (C export)',
    'C => C_ext []',
    localization='membrane',
    compartments=['cell, extern'],
    pars=[],
    rules=[],
    formula=('(scale_f*(Vmax_bC/Km_C)*(C - C_ext))/(1 dimensionless + C_ext/Km_C + C/Km_C)', 'mole_per_s')
)

# v1: A -> B; (scale_f*Vmax_v1)/Km_A*(A - 1 dimensionless/Keq_v1*B);
v1 = ReactionTemplate(
    'v1',
    'v1 (A -> B)',
    'A -> B []',
    localization='cell',
    compartments=['cell'],
    pars=[],
    rules=[],
    formula=('(scale_f*Vmax_v1)/Km_A*(A - 1 dimensionless/Keq_v1*B)', 'mole_per_s')
)

# v2: A -> C; (scale_f*Vmax_v2)/Km_A*A;
v2 = ReactionTemplate(
    'v2',
    'v2 (A -> C)',
    'A -> C []',
    localization='cell',
    compartments=['cell'],
    pars=[],
    rules=[],
    formula=('(scale_f*Vmax_v2)/Km_A*A', 'mole_per_s')
)

# v3: C -> A; (scale_f*Vmax_v3)/Km_A*C;
v3 = ReactionTemplate(
    'v3',
    'v3 (C -> A)',
    'C -> A []',
    localization='cell',
    compartments=['cell'],
    pars=[],
    rules=[],
    formula=('(scale_f*Vmax_v3)/Km_A*C', 'mole_per_s')
)

# v4: C -> B; (scale_f*Vmax_v4)/Km_A*(C - 1 dimensionless/Keq_v4*B);
v4 = ReactionTemplate(
    'v4',
    'v4 (C -> B)',
    'C -> B []',
    localization='cell',
    compartments=['cell'],
    pars=[],
    rules=[],
    formula=('(scale_f*Vmax_v4)/Km_A*(C - 1 dimensionless/Keq_v4*B)', 'mole_per_s')
)
