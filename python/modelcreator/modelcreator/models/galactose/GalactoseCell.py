'''
Galactose model for inclusion into sinusoidal unit.
The metabolic models are specified in a generic format which is than
included in the tissue scale model.

Generic generation of the species depending on the compartment they
are localized in. 
e__x : extracellular compartment (Disse)
h__x : hepatocyte compartment (total internal cell volume)
c__x : cytosolic compartment (fraction of hepatocyte which is cytosol)



Created on Jun 24, 2014
@author: mkoenig
'''
from GalactoseReactions import *

##############################################################
mid = 'Galactose'
species = [
            # id, value, unit
            ('e__gal',  0.00012, 'mM'),
            ('e__galM', 0.0, 'mM'),
            ('e__h2oM', 0.0, 'mM'),
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
]
pars = [# id, value, unit, constant            
            ('scale_f',   0.41,   'per_m3',    True),
            ('REF_P',     1.0,      'mM',   True),
            ('deficiency',  0,      '-',    True),
]  
assignments = [# id, assignment, unit       
               ]

rules = [# id, rule, unit
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
]
reactions = (GALK, GALKM,
                 IMP, IMPM,
                 ATPS, 
                 ALDR, ALDRM,
                 NADPR,
                 GALT, GALTM1, GALTM2, GALTM3,
                 GALE, GALEM,
                 UGP, UGPM,
                 UGALP,UGALPM,
                 PPASE,
                 NDKU,
                 PGM1, PGM1M, 
                 GLY, GLYM,
                 GTFGAL, GTFGALM,
                 GTFGLC, GTFGLCM,
                 H2OTM, GLUT2_GAL, GLUT2_GALM)
    
# metabolic events
deficiencies_units = {
                 'GALK_kcat':'per_s',
                 'GALK_k_gal':'mM',
                 'GALK_k_atp':'mM',
                 'GALT_vm': 'dimensionless',
                 'GALT_k_gal1p': 'mM', 
                 'GALT_k_udpglc': 'mM',
                 'GALE_kcat': 'per_s',
                 'GALE_k_udpglc':'mM',
}
deficiencies = {
        0 : {# 'GALK_kcat':8.7, 'GALK_k_gal':0.97, 'GALK_k_atp':0.034,
             # 'GALT_vm':  804,  'GALT_k_gal1p':1.25, 'GALT_k_udpglc':0.95,
             # 'GALE_kcat': 36,  'GALE_k_udpglc':0.069
             },  
        1 : {'GALK_kcat':2.0, 'GALK_k_gal':7.7, 'GALK_k_atp':0.130},  
        2 : {'GALK_kcat':3.9, 'GALK_k_gal':0.43, 'GALK_k_atp':0.110}, 
        3 : {'GALK_kcat':5.9, 'GALK_k_gal':0.66, 'GALK_k_atp':0.026},  
        4 : {'GALK_kcat':0.4, 'GALK_k_gal':1.1, 'GALK_k_atp':0.005},  
        5 : {'GALK_kcat':1.1, 'GALK_k_gal':13.0, 'GALK_k_atp':0.089},  
        6 : {'GALK_kcat':1.8, 'GALK_k_gal':1.70, 'GALK_k_atp':0.039},  
        7 : {'GALK_kcat':6.7, 'GALK_k_gal':1.90, 'GALK_k_atp':0.035},  
        8 : {'GALK_kcat':0.9, 'GALK_k_gal':0.14, 'GALK_k_atp':0.0039}, 
        9 : {'GALT_vm':  396,  'GALT_k_gal1p':1.89, 'GALT_k_udpglc':0.58},
       10 : {'GALT_vm':  253,  'GALT_k_gal1p':2.34, 'GALT_k_udpglc':0.69},
       11 : {'GALT_vm':  297,  'GALT_k_gal1p':1.12, 'GALT_k_udpglc':0.76},
       12 : {'GALT_vm':  45,  'GALT_k_gal1p':1.98, 'GALT_k_udpglc':1.23},
       13 : {'GALT_vm':  306,  'GALT_k_gal1p':2.14, 'GALT_k_udpglc':0.48},
       14 : {'GALT_vm':  385,  'GALT_k_gal1p':2.68, 'GALT_k_udpglc':0.95}, 
       15 : {'GALE_kcat': 32,  'GALE_k_udpglc':0.082}, 
       16 : {'GALE_kcat': 0.046,  'GALE_k_udpglc':0.093},
       17 : {'GALE_kcat': 1.1,  'GALE_k_udpglc':0.160},
       18 : {'GALE_kcat': 5.0,  'GALE_k_udpglc':0.140},
       19 : {'GALE_kcat': 11,  'GALE_k_udpglc':0.097},
       20 : {'GALE_kcat': 5.1,  'GALE_k_udpglc':0.066},
       21 : {'GALE_kcat': 5.8,  'GALE_k_udpglc':0.035},
       22 : {'GALE_kcat': 30,  'GALE_k_udpglc':0.078},
       23 : {'GALE_kcat': 15,  'GALE_k_udpglc':0.099}      
}