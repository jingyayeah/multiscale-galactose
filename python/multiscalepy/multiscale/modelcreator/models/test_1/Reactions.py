"""
Reactions and transporters of Galactose metabolism.
"""
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################

GLUT2_GAL = ReactionTemplate(
    'e__GLUT2_GAL',
    'galactose transport [e__]',
    'e__gal <-> c__gal []',
    # C6H1206 (0) <-> C6H1206 (0)
    localization='pm',
    compartments=['cyto__', 'ext__'],
    pars=[
            ('GLUT2_Vmax',    1E-13,   'mole_per_s'),
            ('GLUT2_k_gal', 1.0, 'mM'),
            ('GLUT2_keq', 1.0, '-'),
    ],
    rules=[
    ],
    formula=('GLUT2_Vmax/GLUT2_k_gal * (e__gal - c__gal/GLUT2_keq)/(1 dimensionless + c__gal/GLUT2_k_gal + e__gal/GLUT2_k_gal) ', 'mole_per_s')
)


