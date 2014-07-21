'''
Clearance of a simple example substance for testing the
sinusoidal model.

@author: Matthias Koenig
@date: 2014-07-21
'''

class BasicClearanceModel(object):
    id = 'BasicClearance'
    species = [
            # id, value, unit
            ('e__s1',  0.0, 'mM'),
            ('c__s1',  0.0, 'mM'),
            ('c__s1p', 0.0, 'mM'),
            ('c__atp',              2.7,    'mM'),
            ('c__adp',              1.2,    'mM'),
            ('c__phos',             5.0,    'mM'),
    ]
    pars = [# id, value, unit, constant            
            ('scale_f',   10E-15,   '-',    True),
    ]  
    assignments = []
    rules = [# id, rule, unit
            ('c__nadp_tot', 'c__nadp + c__nadph', 'mM'),
            ('c__adp_tot', 'c__atp + c__adp', 'mM'),
            ('c__udp_tot', 'c__utp + c__udp + c__udpglc + c__udpgal', 'mM'),
            ('c__phos_tot', '3 dimensionless *c__atp + 2 dimensionless *c__adp + 3 dimensionless *c__utp + 2 dimensionless *c__udp' +
              '+ c__phos + 2 dimensionless *c__ppi + c__glc1p + c__glc6p + c__gal1p + 2 dimensionless*c__udpglc + 2 dimensionless *c__udpgal', 'mM'),
    ]
    reactions = (GALK, GALKM,
                 IMP, 
                 ATPS, 
                 ALDR, 
                 NADPR,
                 GALT,
                 GALE,
                 UGP,
                 UGALP,
                 PPASE,
                 NDKU,
                 PGM1,
                 GLY,
                 GTFGAL,
                 GTFGLC,
                 H2OTM,
                 GLUT2_GAL,
                 GLUT2_GALM)