"""
Reactions and transporters of hepatic caffeine metabolism.

Caffeine is metabolized in the liver into three primary metabolites:
    paraxanthine (84%),
    theobromine (12%),
    and theophylline (4%).

"""
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################

# Caffeine Import
CAFT = ReactionTemplate(
    rid='CAFT',
    name='caffeine transporter',
    equation='caf_ext <-> caf []',
    # C8H10N4O2 (0) <-> C8H10N4O2 (0)
    localization='pm',
    pars=[
        ('CAFT_keq', 1, 'dimensionless'),
        ('CAFT_k_caf', 0.1, 'mM'),
        ('CAFT_Vmax', 10, 'mole_per_s'),
    ],
    rules=[],
    formula=('f_caf * (CAFT_Vmax/CAFT_k_caf) * (caf_ext - caf/CAFT_keq) / ' +
                '(1 dimensionless + caf_ext/CAFT_k_caf + caf/CAFT_k_caf)', 'mole_per_s')
)

PXT = ReactionTemplate(
    rid='PXT',
    name='paraxanthine transporter',
    equation='px <-> px_ext []',
    # C7H8N4O2 (0) <-> C7H8N4O2 (0)
    localization='pm',
    pars=[
        ('PXT_keq', 1, 'dimensionless'),
        ('PXT_k_px', 0.1, 'mM'),
        ('PXT_Vmax', 2, 'mole_per_s'),
    ],
    rules=[],
    formula=('f_caf * (PXT_Vmax/PXT_k_px) * (px - px_ext/PXT_keq) / ' +
                '(1 dimensionless + px_ext/PXT_k_px + px/PXT_k_px)', 'mole_per_s')
)

TBT = ReactionTemplate(
    rid='TBT',
    name='theobromine transporter',
    equation='tb <-> tb_ext []',
    # C7H8N4O2 (0) <-> C7H8N4O2 (0)
    localization='pm',
    pars=[
        ('TBT_keq', 1, 'dimensionless'),
        ('TBT_k_tb', 0.1, 'mM'),
        ('TBT_Vmax', 2, 'mole_per_s'),
    ],
    rules=[],
    formula=('f_caf * (TBT_Vmax/TBT_k_tb) * (tb - tb_ext/TBT_keq)/(1 dimensionless + tb_ext/TBT_k_tb + tb/TBT_k_tb)', 'mole_per_s')
)

TPT = ReactionTemplate(
    rid='TPT',
    name='theophylline transporter',
    equation='tp <-> tp_ext []',
    # C7H8N4O2 (0) <-> C7H8N4O2 (0)
    localization='pm',
    pars=[
        ('TPT_keq', 1, 'dimensionless'),
        ('TPT_k_tp', 0.1, 'mM'),
        ('TPT_Vmax', 2, 'mole_per_s'),
    ],
    rules=[],
    formula=('f_caf * (TPT_Vmax/TPT_k_tp) * (tp - tp_ext/TPT_keq) / ' +
                '(1 dimensionless + tp_ext/TPT_k_tp + tp/TPT_k_tp)', 'mole_per_s')
)

CAF2PX = ReactionTemplate(
    rid='CAF2PX',
    name='CAF2PX',
    equation='caf => px []',
    # ?
    localization='c',
    pars=[
        ('CAF2PX_k_caf', 0.1, 'mM'),
        ('CAF2PX_Vmax', 8.4, 'mole_per_s'),
    ],
    formula=('f_caf * CAF2PX_Vmax * caf/(CAF2PX_k_caf + caf)', 'mole_per_s')
)

CAF2TB = ReactionTemplate(
    rid='CAF2TB',
    name='CAF2TB',
    equation='caf => tb []',
    # ?
    localization='c',
    pars=[
        ('CAF2TB_k_caf', 0.1, 'mM'),
        ('CAF2TB_Vmax', 1.2, 'mole_per_s'),
    ],
    formula=('f_caf * CAF2TB_Vmax * caf/(CAF2TB_k_caf + caf)', 'mole_per_s')
)

CAF2TP = ReactionTemplate(
    rid='CAF2TP',
    name='CAF2TP',
    equation='caf => tp []',
    # ?
    localization='c',
    pars=[
        ('CAF2TP_k_caf', 0.1, 'mM'),
        ('CAF2TP_Vmax', 0.4, 'mole_per_s'),
    ],
    formula=('f_caf * CAF2TP_Vmax * caf/(CAF2TP_k_caf + caf)', 'mole_per_s')
)
