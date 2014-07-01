'''
The important part is to be able to put various metabolic models
in the sinusoidal model geometry.
Cell models consist of reactions and transporters.
As well as species.  

Created on Jun 24, 2014
@author: mkoenig
'''

from creator.processes.GalactoseReactions import IMP, H2OTM

class GalactoseModel(object):
    species = [
            # id, value, unit
            ('e__gal',  0.00012, 'mM'),
            ('e__galM', 0.0, 'mM'),
            ('e__h2oM', 0.0, 'mM'),
            ('c__gal',             0.00012, 'mM'),
            ('c__galM',            0.0,     'mM'),
            ('c__h2oM',            0.0,     'mM'),
            ('c__glc1p',           0.012,   'mM'),
            ('c__glc6p',           0.12,    'mM'),
            ('c__gal1p',           0.001,   'mM'),
            ('c__udpglc',          0.34,    'mM'),
            ('c__udpgal',          0.11,    'mM'),
            ('c__galtol',          0.001,   'mM'),
    
            ('c__atp',              2.7,    'mM'),
            ('c__adp',              1.2,    'mM'),
            ('c__utp',              0.27,   'mM'),
            ('c__udp',              0.09,   'mM'),
            ('c__phos',             5.0,    'mM'),
            ('c__ppi',              0.008,  'mM'),
            ('c__nadp',             0.1,    'mM'),
            ('c__nadph',            0.1,    'mM'),
    ]
    pars = [
            # id, value, unit, constant
            ('scale_f',   10E-15,   '-',    True),
            ('REF_P',     1.0,      'mM',   True),
            ('deficiency',  0,      '-',    True),
    ]  
    assignments = [
            # id, assignment, unit
            ('scale', 'scale_f', '-'),               
    ]
    rules = [
            # id, rule, unit
            ('c__nadp_tot', 'c__nadp + c__nadph', 'mM'),
            ('c__adp_tot', 'c__atp + c__adp', 'mM'),
            ('c__udp_tot', 'c__utp + c__udp + c__udpglc + c__udpgal', 'mM'),
            ('c__phos_tot', '3*c__atp + 2*c__adp + 3*c__utp + 2*c__udp + c__phos + 2*c__ppi + c__glc1p + c__glc6p + c__gal1p + 2* c__udpglc + 2*c__udpgal', 'mM'),
    ]
    
    # collect the reactions
    reactions = (IMP, H2OTM)

