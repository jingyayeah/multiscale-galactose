"""
Reactions and transporters of hepatic caffeine metabolism.

Caffeine is metabolized in the liver into three primary metabolites:
    paraxanthine (84%),
    theobromine (12%),
    and theophylline (4%).

"""
from sbmlutils.modelcreator.processes.ReactionTemplate import ReactionTemplate
import sbmlutils.modelcreator.modelcreator as mc

#############################################################################################
#    REACTIONS
#############################################################################################

# Caffeine Import
CAFT = ReactionTemplate(
    rid='CAFT',
    name='caffeine transporter',
    equation='caf_ext <-> caf []',
    # C8H10N4O2 (0) <-> C8H10N4O2 (0)
    compartment='pm',
    pars=[
        mc.Parameter('CAFT_keq', 1, '-'),
        mc.Parameter('CAFT_k_caf', 0.1, 'mM'),
        mc.Parameter('CAFT_Vmax', 10, 'mole_per_s'),
    ],
    formula=('f_caf * (CAFT_Vmax/CAFT_k_caf) * (caf_ext - caf/CAFT_keq) / ' +
                '(1 dimensionless + caf_ext/CAFT_k_caf + caf/CAFT_k_caf)', 'mole_per_s')
)

PXT = ReactionTemplate(
    rid='PXT',
    name='paraxanthine transporter',
    equation='px <-> px_ext []',
    # C7H8N4O2 (0) <-> C7H8N4O2 (0)
    compartment='pm',
    pars=[
        mc.Parameter('PXT_keq', 1, 'dimensionless'),
        mc.Parameter('PXT_k_px', 0.1, 'mM'),
        mc.Parameter('PXT_Vmax', 2, 'mole_per_s'),
    ],
    formula=('f_caf * (PXT_Vmax/PXT_k_px) * (px - px_ext/PXT_keq) / ' +
                '(1 dimensionless + px_ext/PXT_k_px + px/PXT_k_px)', 'mole_per_s')
)

TBT = ReactionTemplate(
    rid='TBT',
    name='theobromine transporter',
    equation='tb <-> tb_ext []',
    # C7H8N4O2 (0) <-> C7H8N4O2 (0)
    compartment='pm',
    pars=[
        mc.Parameter('TBT_keq', 1, 'dimensionless'),
        mc.Parameter('TBT_k_tb', 0.1, 'mM'),
        mc.Parameter('TBT_Vmax', 2, 'mole_per_s'),
    ],
    formula=('f_caf * (TBT_Vmax/TBT_k_tb) * (tb - tb_ext/TBT_keq)/(1 dimensionless + tb_ext/TBT_k_tb + tb/TBT_k_tb)', 'mole_per_s')
)

TPT = ReactionTemplate(
    rid='TPT',
    name='theophylline transporter',
    equation='tp <-> tp_ext []',
    # C7H8N4O2 (0) <-> C7H8N4O2 (0)
    compartment='pm',
    pars=[
        mc.Parameter('TPT_keq', 1, 'dimensionless'),
        mc.Parameter('TPT_k_tp', 0.1, 'mM'),
        mc.Parameter('TPT_Vmax', 2, 'mole_per_s'),
    ],
    formula=('f_caf * (TPT_Vmax/TPT_k_tp) * (tp - tp_ext/TPT_keq) / ' +
                '(1 dimensionless + tp_ext/TPT_k_tp + tp/TPT_k_tp)', 'mole_per_s')
)

CAF2PX = ReactionTemplate(
    rid='CAF2PX',
    name='CAF2PX',
    equation='caf => px []',
    # ?
    compartment='c',
    pars=[
        mc.Parameter('CAF2PX_k_caf', 0.1, 'mM'),
        mc.Parameter('CAF2PX_Vmax', 8.4, 'mole_per_s'),
    ],
    formula=('f_caf * CAF2PX_Vmax * caf/(CAF2PX_k_caf + caf)', 'mole_per_s')
)

CAF2TB = ReactionTemplate(
    rid='CAF2TB',
    name='CAF2TB',
    equation='caf => tb []',
    # ?
    compartment='c',
    pars=[
        mc.Parameter('CAF2TB_k_caf', 0.1, 'mM'),
        mc.Parameter('CAF2TB_Vmax', 1.2, 'mole_per_s'),
    ],
    formula=('f_caf * CAF2TB_Vmax * caf/(CAF2TB_k_caf + caf)', 'mole_per_s')
)

CAF2TP = ReactionTemplate(
    rid='CAF2TP',
    name='CAF2TP',
    equation='caf => tp []',
    # ?
    compartment='c',
    pars=[
        mc.Parameter('CAF2TP_k_caf', 0.1, 'mM'),
        mc.Parameter('CAF2TP_Vmax', 0.4, 'mole_per_s'),
    ],
    formula=('f_caf * CAF2TP_Vmax * caf/(CAF2TP_k_caf + caf)', 'mole_per_s')
)
