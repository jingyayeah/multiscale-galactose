"""
Reactions and transporters of Galactose metabolism.
"""
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################

GK = ReactionTemplate(
    rid='GK',
    name='Glucokinase',
    equation='glc + atp => glc6p + adp []',
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
