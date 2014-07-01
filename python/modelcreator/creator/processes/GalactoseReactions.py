'''
Definition of the Galactose Reactions.

Created on Jul 1, 2014
@author: mkoenig
'''

from creator.tools.Equation import Equation
from ReactionTemplate import ReactionTemplate

comps = ('c__', 'e__')
########################################################
IMP = ReactionTemplate(
    'c__IMP',
    'Inositol monophosphatase [c__]',
    'c__gal1p => c__gal + c__phos',
    pars = [# id, value, unit
            ('IMP_f', 0.05, '-'),
            ('IMP_k_gal1p', 0.35, 'mM'),
            ('c__IMP_P', 1.0, 'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__IMP_Vmax', 'IMP_f * c__GALK_Vmax * c__IMP_P/REF_P', 'mole_per_s'),
    ],
    # formula, unit
    formula = ('c__IMP_Vmax/IMP_k_gal1p * c__gal1p/(1 + c__gal1p/IMP_k_gal1p)', 'mole_per_s')
)
########################################################
H2OTM = ReactionTemplate(
    'c__H2OM',
    'H2O M transport [c__]',
    'e__h2oM <-> c__h2oM',
    pars = [
            ('H2OT_f', 10.0, 'mole/s'),
            ('H2OT_k',  1.0, 'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__H2OT_Vmax', 'H2OT_f * scale', 'mole_per_s'),
    ],
    formula = ('c__H2OT_Vmax/H2OT_k/Nf * (e__h2oM - c__h2oM)', 'mole_per_s')
)
########################################################

