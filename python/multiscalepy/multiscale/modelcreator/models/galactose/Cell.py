"""
Galactose model for inclusion into sinusoidal unit.
The metabolic models are specified in a generic format which is than
included in the tissue scale model.

Generic generation of the species depending on the compartment they
are localized in.
e__x : extracellular compartment (Disse)
h__x : hepatocyte compartment (total internal cell volume)
c__x : cytosolic compartment (fraction of hepatocyte which is cytosol)


TODO: put the units in the single cell definition

"""
from Reactions import *

##############################################################
mid = 'galactose'
version = 1
units = dict()
species = []
pars = []
names = dict()
assignments = []
rules = []
reactions = []

##############################################################
# Species
##############################################################
species.extend([
    # id, value, unit
    ('e__gal',             0.00012, 'mM'),
    ('e__galM',            0.0, 'mM'),
    ('e__h2oM',            0.0, 'mM'),

    ('h__h2oM',            0.0,     'mM'),
    ('c__gal',             0.00012, 'mM'),
    ('c__galM',            0.0,     'mM'),
    ('c__glc1p',           0.012,   'mM'),
    ('c__glc1pM',          0.0,     'mM'),
    ('c__glc6p',           0.12,    'mM'),
    ('c__glc6pM',          0.0,     'mM'),
    ('c__gal1p',           0.001,   'mM'),
    ('c__gal1pM',          0.0,     'mM'),
    ('c__udpglc',          0.34,    'mM'),
    ('c__udpglcM',         0.0,     'mM'),
    ('c__udpgal',          0.11,    'mM'),
    ('c__udpgalM',         0.0,     'mM'),
    ('c__galtol',          0.001,   'mM'),
    ('c__galtolM',         0.0,     'mM'),
    
    ('c__atp',              2.7,    'mM'),
    ('c__adp',              1.2,    'mM'),
    ('c__utp',              0.27,   'mM'),
    ('c__udp',              0.09,   'mM'),
    ('c__phos',             5.0,    'mM'),
    ('c__ppi',              0.008,  'mM'),
    ('c__nadp',             0.1,    'mM'),
    ('c__nadph',            0.1,    'mM'),
])
names.update({
    'rbcM': 'red blood cells M*',
    'suc': 'sucrose',
    'alb': 'albumin',
    'h2oM': 'water M*',
    'glc': 'D-glucose',
    'gal': 'D-galactose',
    'galM': 'D-galactose M*',
    'glc1p': 'D-glucose 1-phophate',
    'glc1pM': 'D-glucose 1-phophate M*',
    'glc6p': 'D-glucose 6-phosphate',
    'glc6pM': 'D-glucose 6-phosphate M*',
    'gal1p': 'D-galactose 1-phosphate',
    'gal1pM': 'D-galactose 1-phosphate M*',
    'udpglc': 'UDP-D-glucose',
    'udpglcM': 'UDP-D-glucose M*',
    'udpgal': 'UDP-D-galactose',
    'udpgalM': 'UDP-D-galactose M*',
    'galtol': 'D-galactitol',
    'galtolM': 'D-galactitol M*',
    'atp': 'ATP',
    'adp': 'ADP',
    'utp': 'UTP',
    'udp': 'UDP',
    'phos': 'phosphate',
    'ppi': 'pyrophosphate',
    'nadp': 'NADP',
    'nadph': 'NADPH',
})

##############################################################
# Parameters
##############################################################
pars.extend([
    # id, value, unit, constant
    ('scale_f',   0.31,   'per_m3',    True),
    ('REF_P',     1.0,      'mM',   True),
    ('deficiency',  0,      '-',    True),
])

##############################################################
# Assignments
##############################################################
assignments.extend([
    # id, assignment, unit
])

##############################################################
# Rules
##############################################################
rules.extend([
    # id, rule, unit
    ('c__scale', 'scale_f * Vol_cell', '-'),
            
    ('e__gal_tot', 'e__gal + e__galM', 'mM'),
    ('c__gal_tot', 'c__gal + c__galM', 'mM'),
    ('c__glc1p_tot', 'c__glc1p + c__glc1pM', 'mM'),
    ('c__glc6p_tot', 'c__glc6p + c__glc6pM', 'mM'),
    ('c__gal1p_tot', 'c__gal1p + c__gal1pM', 'mM'),
    ('c__udpglc_tot', 'c__udpglc + c__udpglcM', 'mM'),
    ('c__udpgal_tot', 'c__udpgal + c__udpgalM', 'mM'),
    ('c__galtol_tot', 'c__galtol + c__galtolM', 'mM'),
            
    ('c__nadp_bal', 'c__nadp + c__nadph', 'mM'),
    ('c__adp_bal', 'c__atp + c__adp', 'mM'),
    ('c__udp_bal', 'c__utp + c__udp + c__udpglc + c__udpgal + c__udpglcM + c__udpgalM', 'mM'),
    ('c__phos_bal', '3 dimensionless *c__atp + 2 dimensionless *c__adp + 3 dimensionless *c__utp + 2 dimensionless *c__udp' +
                    '+ c__phos + 2 dimensionless *c__ppi + c__glc1p + c__glc6p + c__gal1p + 2 dimensionless*c__udpglc + 2 dimensionless *c__udpgal' +
                    '+ c__glc1pM + c__glc6pM + c__gal1pM + 2 dimensionless*c__udpglcM + 2 dimensionless *c__udpgalM', 'mM'),
])

##############################################################
# Reactions
##############################################################
reactions.extend([
    GALK, GALKM,
    IMP, IMPM,
    ATPS,
    ALDR, ALDRM,
    NADPR,
    GALT, GALTM1, GALTM2, GALTM3,
    GALE, GALEM,
    UGP, UGPM,
    UGALP, UGALPM,
    PPASE,
    NDKU,
    PGM1, PGM1M,
    GLY, GLYM,
    GTFGAL, GTFGALM,
    GTFGLC, GTFGLCM,
    H2OTM, GLUT2_GAL, GLUT2_GALM
])

