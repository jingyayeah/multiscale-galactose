"""
Reactions and transporters of Galactose metabolism.

TODO: the modfiers can be deduced from the equations.
COMPARTMENTS: are not needed, but handled via comp

"""
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################

GLUT2 = ReactionTemplate(
    rid='GLUT2',
    name='GLUT2 glucose transporter',
    equation='glc_ext -> glc []',
    localization='pm',
    compartments=[],
    pars=[
        ('GLUT2_keq', 1, 'dimensionless'),
        ('GLUT2_km', 42, 'mM'),
        ('GLUT2_Vmax', 420, 'mol_per_s'),
    ],
    rules=[],
    formula=('scale_gly * (GLUT2_Vmax/GLUT2_km) * (glc_ext - glc/GLUT2_keq)/(1 dimensionless + glc_ext/GLUT2_km + glc/GLUT2_km)', 'mol_per_s')
)

GK = ReactionTemplate(
    rid='GK',
    name='Glucokinase',
    equation='glc + atp => glc6p + adp [glc1p, fru6p]',
    localization='cyto',
    compartments=[],
    pars=[
        ('GK_n_gkrp', 2, 'dimensionless'),
        ('GK_km_glc1', 15, 'mM'),
        ('GK_km_fru6p', 0.010, 'mM'),
        ('GK_b', 0.7, 'dimensionless'),
        ('GK_n', 1.6, 'dimensionless'),
        ('GK_km_glc', 7.5, 'mM'),
        ('GK_km_atp', 0.26, 'mM'),
        ('GK_Vmax', 25.2, 'mol_per_s'),
    ],
    rules=[
        ('GK_gc_free', '(glc^GK_n_gkrp / (glc^GK_n_gkrp + GK_km_glc1^GK_n_gkrp) ) * (1 dimensionless - GK_b*fru6p/(fru6p + GK_km_fru6p))', 'dimensionless'),
    ],
    formula=('scale_gly * GK_Vmax * GK_gc_free * (atp/(GK_km_atp + atp)) * (glc^GK_n/(glc^GK_n + GK_km_glc^GK_n))', 'mol_per_s')
)
