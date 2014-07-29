'''
Reactions and transporters of basic clearance model.

Created on Jul 1, 2014
@author: mkoenig
'''

from modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################
K_S1 = ReactionTemplate(
    'c__KS1',
    'S1 kinase [c__]',
    'c__s1 + c__atp <-> c__s1p + c__adp',
    pars = [
            ('KS1_P',      0.02,    'mole'),
            ('KS1_kcat',     8.7,    'per_s'),
            ('KS1_keq',     50,       '-'),
            ('KS1_k_s1p',  1.5,     'mM'),
            ('KS1_k_adp',   0.8,     'mM'),
            ('KS1_k_s1',    0.97,    'mM'),
            ('KS1_k_atp',   0.034,   'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__KS1_Vmax', 'scale_f * KS1_P * KS1_kcat', 'mole_per_s'),
            ('c__KS1_dm', '( (1 dimensionless +(c__s1+c__s1M)/KS1_k_s1)*(1 dimensionless +c__atp/KS1_k_atp) +(1 dimensionless+c__s1p/KS1_k_s1p)*(1 dimensionless+c__adp/KS1_k_adp) -1 dimensionless)', '-'),
    ],
    formula = ('c__KS1_Vmax/(KS1_k_s1*KS1_k_atp) * (c__s1*c__atp - c__s1p*c__adp/KS1_keq)/c__KS1_dm', 'mole_per_s')
)

#############################################################################################
K_S1M = ReactionTemplate(
    'c__KS1M',
    'S1 kinase M [c__]',
    'c__s1M + c__atp -> c__s1p + c__adp',
    pars = [],
    rules = [],
    formula = ('c__KS1_Vmax/(KS1_k_s1*KS1_k_atp) * (c__s1M*c__atp)/c__KS1_dm', 'mole_per_s')
)

#############################################################################################
#    TRANSPORTERS
#############################################################################################
T_S1 = ReactionTemplate(
    'c__T_S1',
    's1 transport [c__]',
    'e__s1 <-> c__s1',
    pars = [
            ('T_f',    1E6,   'mole_per_s'),
            ('T_k_s1', 85.5,  'mM'),
            
    ],
    rules = [ # id, rule, unit
            ('c__T_Vmax', 'T_f * scale_f', 'mole_per_s'),
            ('c__T_dm', '(1 dimensionless + (e__s1+e__s1M)/T_k_s1 + (c__s1+c__s1M)/T_k_s1)', '-'),
    ],
    formula = ('c__T_Vmax/T_k_s1 * (e__s1 - c__s1)/c__T_dm', 'mole_per_s')
)
T_S1M = ReactionTemplate(
    'c__T_S1M',
    's1M transport M [c__]',
    'e__s1M <-> c__s1M',
    pars = [],
    rules = [],
    formula = ('c__T_Vmax/T_k_s1 * (e__s1M - c__s1M)/c__T_dm', 'mole_per_s')
)
#############################################################################################