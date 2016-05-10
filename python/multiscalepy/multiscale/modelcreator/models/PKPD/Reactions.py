"""
PKPD reactions.

Flux between tissue compartments.
"""
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################

AR2AD = ReactionTemplate(
    rid='AR2AD',
    name='arterial blood -> adipose',
    equation='Car => Cad []',
    localization=None,
    rules=[],
    formula=('Qad * Car', 'mg_per_h')
)

AD2VE = ReactionTemplate(
    rid='AD2VE',
    name='adipose -> venous blood',
    equation='Cad => Cve []',
    localization=None,
    rules=[],
    formula=('Qad*Cad/Kpad*BP', 'mg_per_h')
)



