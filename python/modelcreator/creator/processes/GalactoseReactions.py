'''
Reactions of Galactose metabolism based on ReactionTemplate.

Created on Jul 1, 2014
@author: mkoenig
'''

from ReactionTemplate import ReactionTemplate
comps = ('c__', 'e__')

#############################################################################################
GALK = ReactionTemplate(
    'c__GALK',
    'Galactokinase [c__]',
    'c__gal + c__atp <-> c__gal1p + c__adp',
    pars = [
            ('GALK_PA',      0.02,    'mole'),
            ('GALK_keq',     50,       '-'),
            ('GALK_k_gal1p', 1.5,     'mM'),
            ('GALK_k_adp',   0.8,     'mM'),
            ('GALK_ki_gal1p', 5.3,    'mM'),
            ('GALK_kcat',     8.7,    'per_s'),
            ('GALK_k_gal',   0.97,    'mM'),
            ('GALK_k_atp',   0.034,   'mM'),
            ('c__GALK_P',    1.0,     'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__GALK_Vmax', 'scale * GALK_PA * GALK_kcat * c__GALK_P/REF_P', 'mole_per_s'),
            ('c__GALK_dm', '((1 +(c__gal+c__galM)/GALK_k_gal)*(1+c__atp/GALK_k_atp) +(1+c__gal1p/GALK_k_gal1p)*(1+c__adp/GALK_k_adp) -1)', '-'),
    ],
    formula = ('c__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+c__gal1p/GALK_ki_gal1p) * (c__gal*c__atp -c__gal1p*c__adp/GALK_keq)/c__GALK_dm', 'mole_per_s')
)

#############################################################################################
GALKM = ReactionTemplate(
    'c__GALKM',
    'Galactokinase M [c__]',
    'c__galM + c__atp -> c__gal1p + c__adp',
    pars = [],
    rules = [],
    formula = ('c__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+c__gal1p/GALK_ki_gal1p) * c__galM * c__atp/c__GALK_dm', 'mole_per_s')
)
#############################################################################################
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
#############################################################################################
H2OTM = ReactionTemplate(
    'c__H2OM',
    'H2O M transport [c__]',
    'e__h2oM <-> c__h2oM',
    pars = [
            ('H2OT_f', 10.0, 'mole_per_s'),
            ('H2OT_k',  1.0, 'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__H2OT_Vmax', 'H2OT_f * scale', 'mole_per_s'),
    ],
    formula = ('c__H2OT_Vmax/H2OT_k/Nf * (e__h2oM - c__h2oM)', 'mole_per_s')
)
#############################################################################################
ATPS = ReactionTemplate(
    'c__ATPS',
    'ATP synthase [c__]',
    'c__adp + c__phos <-> c__atp',
    pars = [
            ('ATPS_f', 100.0,  '-'),
            ('ATPS_keq', 0.58, 'per_mM'),
            ('ATPS_k_adp', 0.1, 'mM'),
            ('ATPS_k_atp', 0.5, 'mM'),
            ('ATPS_k_phos', 0.1, 'mM'),
            ('c__ATPS_P', 1, 'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__ATPS_Vmax', 'ATPS_f* c__GALK_Vmax * c__ATPS_P/REF_P', 'mole_per_s'),
    ],
    formula = ('c__ATPS_Vmax/(ATPS_k_adp*ATPS_k_phos) *(c__adp*c__phos-c__atp/ATPS_keq)/((1+c__adp/ATPS_k_adp)*(1+c__phos/ATPS_k_phos) + c__atp/ATPS_k_atp)', 'mole_per_s')
)
#############################################################################################
ALDR = ReactionTemplate(
    'c__ALDR',
    'Aldose reductase [c__]',
    'c__gal + c__nadph <-> c__galtol + c__nadp',
    pars = [
            ('ALDR_f',        1E6,   '-'),
            ('ALDR_keq',       4.0, '-'),
            ('ALDR_k_gal',    40.0, 'mM'),
            ('ALDR_k_galtol', 40.0, 'mM'),
            ('ALDR_k_nadp',   0.1,  'mM'),
            ('ALDR_k_nadph',  0.1,  'mM'),
            ('c__ALDR_P',        1.0,  'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__ALDR_Vmax', 'ALDR_f * c__GALK_Vmax * c__ALDR_P/REF_P', 'mole_per_s'),
    ],
    formula = ('c__ALDR_Vmax/(ALDR_k_gal*ALDR_k_nadp) *(c__gal*c__nadph - c__galtol*c__nadp/ALDR_keq)/((1+c__gal/ALDR_k_gal)*(1+c__nadph/ALDR_k_nadph) +(1+c__galtol/ALDR_k_galtol)*(1+c__nadp/ALDR_k_nadp) -1)', 'mole_per_s')
)
#############################################################################################
NADPR = ReactionTemplate(
    'c__NADPR',
    'NADP Reductase [c__]',
    'c__nadp <-> c__nadph',
    pars = [
            ('NADPR_f',      1E-10,   '-'),
            ('NADPR_keq',    1,       '-'),
            ('NADPR_k_nadp',   0.015,   'mM'),
            ('NADPR_ki_nadph', 0.010,   'mM'),
            ('c__NADPR_P',     1.0,     'mM'),
    ],
    rules = [ # id, rule, unit
            ('c__NADPR_Vmax', 'NADPR_f * c__ALDR_Vmax * c__NADPR_P/REF_P', 'mole_per_s'),
    ],
    formula = ('c__NADPR_Vmax/NADPR_k_nadp *(c__nadp - c__nadph/NADPR_keq)/(1 +c__nadp/NADPR_k_nadp +c__nadph/NADPR_ki_nadph)', 'mole_per_s')
)

