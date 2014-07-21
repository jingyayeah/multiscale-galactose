'''
Clearance of a simple example substance for testing the
sinusoidal model.
Used for prototyping and to test the clearance of alternative
substances like coffeine.

TODO: handle constant species like ATP and ADP properly.

@author: Matthias Koenig
@date: 2014-07-21
'''

from BasicClearanceReactions import K_S1, K_S1M, T_S1, T_S1M

class BasicClearanceModel(object):
    id = 'BasicClearance'
    species = [
            # id, value, unit
            ('e__s1',  0.0, 'mM'),
            ('e__s1M',  0.0, 'mM'),
            ('c__s1',  0.0, 'mM'),
            ('c__s1M',  0.0, 'mM'),
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
            ('c__adp_tot', 'c__atp + c__adp', 'mM'),
            ('c__phos_tot', '3 dimensionless *c__atp + 2 dimensionless *c__adp + c__phos', 'mM'),
    ]
    reactions = (K_S1, K_S1M,
                 T_S1, T_S1M)

