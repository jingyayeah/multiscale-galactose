"""
Reactions and transporters of Galactose metabolism.

TODO: the modfiers can be deduced from the equations.
COMPARTMENTS: are not needed, but handled via comp

"""
from multiscale.modelcreator.processes.ReactionTemplate import ReactionTemplate

#############################################################################################
#    REACTIONS
#############################################################################################
GLUT2 = ReactionTemplate(
    rid='GLUT2',
    name='GLUT2 glucose transporter',
    equation='glc_ext <-> glc []',
    localization='pm',
    compartments=[],
    pars=[
        ('GLUT2_keq', 1, 'dimensionless'),
        ('GLUT2_km', 42, 'mM'),
        ('GLUT2_Vmax', 420, 'mol_per_s'),
    ],
    rules=[],
    formula=('scale_gly * (GLUT2_Vmax/GLUT2_km) * (glc_ext - glc/GLUT2_keq)/(1 dimensionless + glc_ext/GLUT2_km + glc/GLUT2_km)', 'mol_per_s')
)

GK = ReactionTemplate(
    rid='GK',
    name='Glucokinase',
    equation='glc + atp => glc6p + adp [glc1p, fru6p]',
    localization='cyto',
    compartments=[],
    pars=[
        ('GK_n_gkrp', 2, 'dimensionless'),
        ('GK_km_glc1', 15, 'mM'),
        ('GK_km_fru6p', 0.010, 'mM'),
        ('GK_b', 0.7, 'dimensionless'),
        ('GK_n', 1.6, 'dimensionless'),
        ('GK_km_glc', 7.5, 'mM'),
        ('GK_km_atp', 0.26, 'mM'),
        ('GK_Vmax', 25.2, 'mol_per_s'),
    ],
    rules=[
        ('GK_gc_free', '(glc^GK_n_gkrp / (glc^GK_n_gkrp + GK_km_glc1^GK_n_gkrp) ) * (1 dimensionless - GK_b*fru6p/(fru6p + GK_km_fru6p))', 'dimensionless'),
    ],
    formula=('scale_gly * GK_Vmax * GK_gc_free * (atp/(GK_km_atp + atp)) * (glc^GK_n/(glc^GK_n + GK_km_glc^GK_n))', 'mol_per_s')
)

G6PASE = ReactionTemplate(
    rid='G6PASE',
    name='D-Glucose-6-phosphate Phosphatase',
    equation='glc6p + h2o => glc + phos []',
    localization='cyto',
    pars=[
        ('G6PASE_km_glc6p', 2, 'mM'),
        ('G6PASE_Vmax', 18.9, 'mol_per_s'),
    ],
    formula=('scale_gly * G6PASE_Vmax * (glc6p / (G6PASE_km_glc6p + glc6p))', 'mol_per_s')
)

GPI = ReactionTemplate(
    rid='GPI',
    name='D-Glucose-6-phosphate Isomerase',
    equation='glc6p <-> fru6p []',
    localization='cyto',
    pars=[
        ('GPI_keq', 0.517060817492925, 'dimensionless'),
        ('GPI_km_glc6p', 0.182, 'mM'),
        ('GPI_km_fru6p', 0.071, 'mM'),
        ('GPI_Vmax', 420, 'mol_per_s'),
    ],
    formula=('scale_gly * (GPI_Vmax/GPI_km_glc6p) * (glc6p - fru6p/GPI_keq) / (1 dimensionless + glc6p/GPI_km_glc6p + fru6p/GPI_km_fru6p)', 'mol_per_s')
)

G16PI = ReactionTemplate(
    rid='G16PI',
    name='Glucose 1-phosphate 1,6-phosphomutase',
    equation='glc1p <-> glc6p []',
    localization='cyto',
    pars=[
        ('G16PI_keq', 15.717554082151441, 'dimensionless'),
        ('G16PI_km_glc6p', 0.67, 'mM'),
        ('G16PI_km_glc1p', 0.045, 'mM'),
        ('G16PI_Vmax', 100, 'mol_per_s'),
    ],
    formula=('scale_glyglc * (G16PI_Vmax/G16PI_km_glc1p) * (glc1p - glc6p/G16PI_keq) / (1 dimensionless + glc1p/G16PI_km_glc1p + glc6p/G16PI_km_glc6p)', 'mol_per_s')
)

UPGASE = ReactionTemplate(
    rid='UPGASE',
    name='UTP:Glucose-1-phosphate uridylyltransferase',
    equation='utp + glc1p <-> udpglc + pp []',
    localization='cyto',
    pars=[
        ('UPGASE_keq', 0.312237619153088, 'dimensionless'),
        ('UPGASE_km_utp', 0.563, 'mM'),
        ('UPGASE_km_glc1p', 0.172, 'mM'),
        ('UPGASE_km_udpglc', 0.049, 'mM'),
        ('UPGASE_km_pp', 0.166, 'mM'),
        ('UPGASE_Vmax', 80, 'mol_per_s'),
    ],
    formula=('scale_glyglc * UPGASE_Vmax/(UPGASE_km_utp*UPGASE_km_glc1p) * (utp*glc1p - udpglc*pp/UPGASE_keq) / ( (1 dimensionless + utp/UPGASE_km_utp)*(1 dimensionless + glc1p/UPGASE_km_glc1p) + (1 dimensionless + udpglc/UPGASE_km_udpglc)*(1 dimensionless + pp/UPGASE_km_pp) - 1 dimensionless)', 'mol_per_s')
)

PPASE = ReactionTemplate(
    rid='PPASE',
    name='Pyrophosphate phosphohydrolase',
    equation='pp + h2o => 2 phos []',
    localization='cyto',
    pars=[
        ('PPASE_km_pp', 0.005, 'mM'),
        ('PPASE_Vmax', 2.4, 'mol_per_s'),
    ],
    formula=('scale_glyglc * PPASE_Vmax * pp/(pp + PPASE_km_pp)', 'mol_per_s')
)

GS = ReactionTemplate(
    rid='GS',
    name='Glycogen synthase',
    equation='udpglc => udp + glyglc []',
    localization='cyto',
    pars=[
        ('GS_C', 500, 'mM'),
        ('GS_k1_max', 0.2, 'dimensionless'),
        ('GS_k1_nat', 0.224, 'mM2'),
        ('GS_k2_nat', 0.1504, 'mM'),
        ('GS_k1_phospho', 3.003, 'mM2'),
        ('GS_k2_phospho', 0.09029, 'mM'),
        ('GS_Vmax', 13.2, 'mol_per_s'),
    ],
    rules=[
        ('GS_storage_factor', '(1 dimensionless + GS_k1_max) * (GS_C - glyglc)/( (GS_C - glyglc) + GS_k1_max * GS_C)', 'dimensionless'),
        ('GS_k_udpglc_native', 'GS_k1_nat / (glc6p + GS_k2_nat)', 'mM'),
        ('GS_k_udpglc_phospho', 'GS_k1_phospho / (glc6p + GS_k2_phospho)', 'mM'),
        ('GS_native', 'scale_glyglc * GS_Vmax * GS_storage_factor * udpglc / (GS_k_udpglc_native + udpglc)', 'mol_per_s'),
        ('GS_phospho', 'scale_glyglc * GS_Vmax * GS_storage_factor * udpglc / (GS_k_udpglc_phospho + udpglc)', 'mol_per_s'),
    ],
    formula=('(1 dimensionless -gamma)*GS_native + gamma*GS_phospho', 'mol_per_s')
)

GP = ReactionTemplate(
    rid='GP',
    name='Glycogen-Phosphorylase',
    equation='glyglc + phos <-> glc1p []',
    localization='cyto',
    pars=[
        ('GP_keq', 0.211826505793075, 'per_mM'),
        ('GP_k_glyc_native', 4.8, 'mM'),
        ('GP_k_glyc_phospho', 2.7, 'mM'),
        ('GP_k_glc1p_native', 120, 'mM'),
        ('GP_k_glc1p_phospho', 2, 'mM'),
        ('GP_k_p_native', 300, 'mM'),
        ('GP_k_p_phospho', 5, 'mM'),
        ('GP_ki_glc_phospho', 5, 'mM'),
        ('GP_ka_amp_native', 1, 'mM'),
        ('GP_base_amp_native', 0.03, 'dimensionless'),
        ('GP_max_amp_native', 0.30, 'dimensionless'),
        ('GP_Vmax', 6.8, 'mol_per_s'),
    ],
    rules=[
        ('GP_fmax', '(1 dimensionless +GS_k1_max) * glyglc /( glyglc + GS_k1_max * GS_C)', 'dimensionless'),
        ('GP_vmax_native', 'scale_glyglc * GP_Vmax * GP_fmax * (GP_base_amp_native + (GP_max_amp_native - GP_base_amp_native) *amp/(amp+GP_ka_amp_native))', 'mol_per_s'),
        ('GP_native', 'GP_vmax_native/(GP_k_glyc_native*GP_k_p_native) * (glyglc*phos - glc1p/GP_keq) / ( (1 dimensionless + glyglc/GP_k_glyc_native)*(1 dimensionless + phos/GP_k_p_native) + (1 dimensionless + glc1p/GP_k_glc1p_native) - 1 dimensionless)', 'mol_per_s'),
        ('GP_vmax_phospho', 'scale_glyglc * GP_Vmax * GP_fmax * exp(-log(2 dimensionless)/GP_ki_glc_phospho * glc)', 'mol_per_s'),
        ('GP_phospho', 'GP_vmax_phospho/(GP_k_glyc_phospho*GP_k_p_phospho) * (glyglc*phos - glc1p/GP_keq) / ( (1 dimensionless + glyglc/GP_k_glyc_phospho)*(1 dimensionless + phos/GP_k_p_phospho) + (1 dimensionless + glc1p/GP_k_glc1p_phospho) - 1 dimensionless)', 'mol_per_s'),
    ],
    formula=('(1 dimensionless - gamma) * GP_native + gamma*GP_phospho', 'mol_per_s')
)

NDKGTP = ReactionTemplate(
    rid='NDKGTP',
    name='Nucleoside-diphosphate kinase (ATP, GTP)',
    equation='atp + gdp <-> adp + gtp []',
    localization='cyto',
    pars=[
        ('NDKGTP_keq', 1, 'dimensionless'),
        ('NDKGTP_km_atp', 1.33, 'mM'),
        ('NDKGTP_km_adp', 0.042, 'mM'),
        ('NDKGTP_km_gtp', 0.15, 'mM'),
        ('NDKGTP_km_gdp', 0.031, 'mM'),
        ('NDKGTP_Vmax', 0, 'mol_per_s'),
    ],
    rules=[],
    formula=('scale_gly * NDKGTP_Vmax/(NDKGTP_km_atp*NDKGTP_km_gdp) * (atp*gdp - adp*gtp/NDKGTP_keq) / ( (1 dimensionless + atp/NDKGTP_km_atp)*(1 dimensionless + gdp/NDKGTP_km_gdp) + (1 dimensionless + adp/NDKGTP_km_adp)*(1 dimensionless + gtp/NDKGTP_km_gtp) - 1 dimensionless)', 'mol_per_s')
)

NDKUTP = ReactionTemplate(
    rid='NDKUTP',
    name='Nucleoside-diphosphate kinase (ATP, UTP)',
    equation='atp + udp <-> adp + utp []',
    localization='cyto',
    pars=[
        ('NDKUTP_keq', 1, 'dimensionless'),
        ('NDKUTP_km_atp',1.33, 'mM'),
        ('NDKUTP_km_adp', 0.042, 'mM'),
        ('NDKUTP_km_utp', 16, 'mM'),
        ('NDKUTP_km_udp', 0.19, 'mM'),
        ('NDKUTP_Vmax', 2940, 'mol_per_s'),
    ],
    rules=[],
    formula=('scale_glyglc * NDKUTP_Vmax / (NDKUTP_km_atp * NDKUTP_km_udp) * (atp*udp - adp*utp/NDKUTP_keq) / ( (1 dimensionless + atp/NDKUTP_km_atp)*(1 dimensionless + udp/NDKUTP_km_udp) + (1 dimensionless + adp/NDKUTP_km_adp)*(1 dimensionless + utp/NDKUTP_km_utp) - 1 dimensionless)', 'mol_per_s')
)

AK = ReactionTemplate(
    rid='AK',
    name='ATP:AMP phosphotransferase (Adenylatkinase)',
    equation='atp + amp <-> 2 adp []',
    localization='cyto',
    pars=[
        ('AK_keq', 0.247390074904985, 'dimensionless'),
        ('AK_km_atp', 0.09, 'mM'),
        ('AK_km_amp', 0.08, 'mM'),
        ('AK_km_adp', 0.11, 'mM'),
        ('AK_Vmax', 0, 'mol_per_s'),
    ],
    rules=[],
    formula=('scale_gly * AK_Vmax / (AK_km_atp * AK_km_amp) * (atp*amp - adp*adp/AK_keq) / ( (1 dimensionless +atp/AK_km_atp)*(1 dimensionless +amp/AK_km_amp) + (1 dimensionless +adp/AK_km_adp)*(1 dimensionless +adp/AK_km_adp) - 1 dimensionless)', 'mol_per_s')
)

PFK2 = ReactionTemplate(
    rid='PFK2',
    name='ATP:D-fructose-6-phosphate 2-phosphotransferase',
    equation='fru6p + atp => fru26bp + adp []',
    localization='cyto',
    pars=[
        ('PFK2_n_native', 1.3, 'dimensionless'),
        ('PFK2_n_phospho', 2.1, 'dimensionless'),
        ('PFK2_k_fru6p_native', 0.016, 'mM'),
        ('PFK2_k_fru6p_phospho', 0.050, 'mM'),
        ('PFK2_k_atp_native', 0.28, 'mM'),
        ('PFK2_k_atp_phospho', 0.65, 'mM'),
        ('PFK2_Vmax', 0.0042, 'mol_per_s'),
    ],
    rules=[
        ('PFK2_native', 'scale_gly * PFK2_Vmax * fru6p^PFK2_n_native / (fru6p^PFK2_n_native + PFK2_k_fru6p_native^PFK2_n_native) * atp/(atp + PFK2_k_atp_native)', 'mol_per_s'),
        ('PFK2_phospho', 'scale_gly * PFK2_Vmax * fru6p^PFK2_n_phospho / (fru6p^PFK2_n_phospho + PFK2_k_fru6p_phospho^PFK2_n_phospho) * atp/(atp + PFK2_k_atp_phospho)', 'mol_per_s'),
    ],
    formula=('(1 dimensionless - gamma) * PFK2_native + gamma*PFK2_phospho', 'mol_per_s')
)

FBP2 = ReactionTemplate(
    rid='FBP2',
    name='D-Fructose-2,6-bisphosphate 2-phosphohydrolase',
    equation='fru26bp => fru6p + phos []',
    localization='cyto',
    pars=[
        ('FBP2_km_fru26bp_native', 0.010, 'mM'),
        ('FBP2_ki_fru6p_native', 0.0035, 'mM'),
        ('FBP2_km_fru26bp_phospho', 0.0005, 'mM'),
        ('FBP2_ki_fru6p_phospho', 0.010, 'mM'),
        ('FBP2_Vmax', 0.126, 'mol_per_s'),
    ],
    rules=[
        ('FBP2_native', 'scale_gly * FBP2_Vmax/(1 dimensionless + fru6p/FBP2_ki_fru6p_native) * fru26bp / ( FBP2_km_fru26bp_native + fru26bp)', 'mol_per_s'),
        ('FBP2_phospho', 'scale_gly * FBP2_Vmax/(1 dimensionless + fru6p/FBP2_ki_fru6p_phospho) * fru26bp / ( FBP2_km_fru26bp_phospho + fru26bp)', 'mol_per_s'),
    ],
    formula=('(1 dimensionless - gamma) * FBP2_native + gamma * FBP2_phospho', 'mol_per_s')
)

PFK1 = ReactionTemplate(
    rid='PFK1',
    name='ATP:D-fructose-6-phosphate 1-phosphotransferase',
    equation='fru6p + atp => fru16bp + adp []',
    localization='cyto',
    pars=[
        ('PFK1_km_atp', 0.111, 'mM'),
        ('PFK1_km_fru6p', 0.077, 'mM'),
        ('PFK1_ki_fru6p', 0.012, 'mM'),
        ('PFK1_ka_fru26bp', 0.001, 'mM'),
        ('PFK1_Vmax', 7.182, 'mol_per_s'),
    ],
    formula=('scale_gly * PFK1_Vmax * (1 dimensionless - 1 dimensionless/(1 dimensionless + fru26bp/PFK1_ka_fru26bp)) * fru6p*atp/(PFK1_ki_fru6p*PFK1_km_atp + PFK1_km_fru6p*atp + PFK1_km_atp*fru6p + atp*fru6p)', 'mol_per_s')
)

FBP1 = ReactionTemplate(
    rid='FBP1',
    name='D-Fructose-1,6-bisphosphate 1-phosphohydrolase',
    equation='fru16bp + h2o => fru6p + phos []',
    localization='cyto',
    pars=[
        ('FBP1_ki_fru26bp', 0.001, 'mM'),
        ('FBP1_km_fru16bp', 0.0013, 'mM'),
        ('FBP1_Vmax', 4.326, 'mol_per_s'),
    ],
    formula=('scale_gly * FBP1_Vmax / (1 dimensionless + fru26bp/FBP1_ki_fru26bp) * fru16bp/(fru16bp + FBP1_km_fru16bp)', 'mol_per_s')
)

ALD = ReactionTemplate(
    rid='ALD',
    name='Aldolase',
    equation='fru16bp <-> grap + dhap []',
    localization='cyto',
    pars=[
        ('ALD_keq', 9.762988973629690E-5, 'mM'),
        ('ALD_km_fru16bp', 0.0071, 'mM'),
        ('ALD_km_dhap', 0.0364, 'mM'),
        ('ALD_km_grap', 0.0071, 'mM'),
        ('ALD_ki1_grap', 0.0572, 'mM'),
        ('ALD_ki2_grap', 0.176, 'mM'),
        ('ALD_Vmax', 420, 'mol_per_s'),
    ],
    formula=('scale_gly * ALD_Vmax/ALD_km_fru16bp * (fru16bp - grap*dhap/ALD_keq) / (1 dimensionless + fru16bp/ALD_km_fru16bp + grap/ALD_ki1_grap + dhap*(grap + ALD_km_grap)/(ALD_km_dhap*ALD_ki1_grap) + (fru16bp*grap)/(ALD_km_fru16bp*ALD_ki2_grap))', 'mol_per_s')
)

TPI = ReactionTemplate(
    rid='TPI',
    name='Triosephosphate Isomerase',
    equation='dhap <-> grap []',
    localization='cyto',
    pars=[
        ('TPI_keq', 0.054476985386756, 'dimensionless'),
        ('TPI_km_dhap', 0.59, 'mM'),
        ('TPI_km_grap', 0.42, 'mM'),
        ('TPI_Vmax', 420, 'mol_per_s'),
    ],
    formula=('scale_gly * TPI_Vmax/TPI_km_dhap * (dhap - grap/TPI_keq) / (1 dimensionless + dhap/TPI_km_dhap + grap/TPI_km_grap)', 'mol_per_s')
)

GAPDH = ReactionTemplate(
    rid='GAPDH',
    name='D-Glyceraldehyde-3-phosphate:NAD+ oxidoreductase',
    equation='grap + phos + nad -> bpg13 + nadh + h []',
    localization='cyto',
    pars=[
        ('GAPDH_keq', 0.086779866194594, 'per_mM'),
        ('GAPDH_k_nad', 0.05, 'mM'),
        ('GAPDH_k_grap', 0.005, 'mM'),
        ('GAPDH_k_p', 3.9, 'mM'),
        ('GAPDH_k_nadh', 0.0083, 'mM'),
        ('GAPDH_k_bpg13', 0.0035, 'mM'),
        ('GAPDH_Vmax', 420, 'mol_per_s'),
    ],
    formula=('scale_gly * GAPDH_Vmax / (GAPDH_k_nad*GAPDH_k_grap*GAPDH_k_p) * (nad*grap*phos - bpg13*nadh/GAPDH_keq) / ( (1 dimensionless + nad/GAPDH_k_nad) * (1 dimensionless +grap/GAPDH_k_grap) * (1 dimensionless + phos/GAPDH_k_p) + (1 dimensionless +nadh/GAPDH_k_nadh)*(1 dimensionless +bpg13/GAPDH_k_bpg13) - 1 dimensionless)', 'mol_per_s')
)

PGK = ReactionTemplate(
    rid='PGK',
    name='Phosphoglycerate Kinase',
    equation='adp + bpg13 <-> atp + pg3 []',
    localization='cyto',
    pars=[
        ('PGK_keq', 6.958644052488538, 'dimensionless'),
        ('PGK_k_adp', 0.35, 'mM'),
        ('PGK_k_atp', 0.48, 'mM'),
        ('PGK_k_bpg13', 0.002, 'mM'),
        ('PGK_k_pg3', 1.2, 'mM'),
        ('PGK_Vmax', 420, 'mol_per_s'),
    ],
    formula=('scale_gly * PGK_Vmax / (PGK_k_adp*PGK_k_bpg13) * (adp*bpg13 - atp*pg3/PGK_keq) / ((1 dimensionless + adp/PGK_k_adp)*(1 dimensionless +bpg13/PGK_k_bpg13) + (1 dimensionless +atp/PGK_k_atp)*(1 dimensionless +pg3/PGK_k_pg3) - 1 dimensionless)', 'mol_per_s')
)

PGM = ReactionTemplate(
    rid='PGM',
    name='2-Phospho-D-glycerate 2,3-phosphomutase',
    equation='pg3 <-> pg2 []',
    localization='cyto',
    pars=[
        ('PGM_keq', 0.181375378837397, 'dimensionless'),
        ('PGM_k_pg3', 5, 'mM'),
        ('PGM_k_pg2', 1, 'mM'),
        ('PGM_Vmax', 420, 'mol_per_s'),
    ],
    formula=('scale_gly * PGM_Vmax * (pg3 - pg2/PGM_keq) / (pg3 + PGM_k_pg3 *(1 dimensionless + pg2/PGM_k_pg2))', 'mol_per_s')
)

EN = ReactionTemplate(
    rid='EN',
    name='2-Phospho-D-glucerate hydro-lyase (enolase)',
    equation='pg2 <-> pep []',
    localization='cyto',
    pars=[
        ('EN_keq', 0.054476985386756, 'dimensionless'),
        ('EN_k_pep', 1, 'mM'),
        ('EN_k_pg2', 1, 'mM'),
        ('EN_Vmax', 35.994, 'mol_per_s'),
    ],
    formula=('scale_gly * EN_Vmax * (pg2 - pep/EN_keq) / (pg2 + EN_k_pg2 *(1 dimensionless + pep/EN_k_pep))', 'mol_per_s')
)

PK = ReactionTemplate(
    rid='PK',
    name='Pyruvatkinase',
    equation='pep + adp => pyr + atp []',
    localization='cyto',
    pars=[
        ('PK_n', 3.5, 'dimensionless'),
        ('PK_n_p', 3.5, 'dimensionless'),
        ('PK_n_fbp', 1.8, 'dimensionless'),
        ('PK_n_fbp_p', 1.8, 'dimensionless'),
        ('PK_alpha', 1.0, 'dimensionless'),
        ('PK_alpha_p', 1.1, 'dimensionless'),
        ('PK_alpha_end', 1.0, 'dimensionless'),
        ('PK_k_fbp', 0.16E-3, 'mM'),
        ('PK_k_fbp_p', 0.35E-3, 'mM'),
        ('PK_k_pep', 0.58, 'mM'),
        ('PK_k_pep_p', 1.10, 'mM'),
        ('PK_k_pep_end', 0.08, 'mM'),
        ('PK_k_adp', 2.3, 'mM'),
        ('PK_base_act', 0.08, 'mM'),
        ('PK_base_act_p', 0.04, 'mM'),
        ('PK_Vmax', 46.2, 'mol_per_s'),
    ],
    rules=[
        ('PK_f', 'fru16bp^PK_n_fbp / (PK_k_fbp^PK_n_fbp + fru16bp^PK_n_fbp)', 'dimensionless'),
        ('PK_f_p', 'fru16bp^PK_n_fbp_p / (PK_k_fbp_p^PK_n_fbp_p + fru16bp^PK_n_fbp_p)', 'dimensionless'),
        ('PK_alpha_inp', '(1 dimensionless - PK_f) * (PK_alpha - PK_alpha_end) + PK_alpha_end', 'dimensionless'),
        ('PK_alpha_p_inp', '(1 dimensionless - PK_f_p) * (PK_alpha_p - PK_alpha_end) + PK_alpha_end', 'dimensionless'),
        ('PK_pep_inp', '(1 dimensionless - PK_f) * (PK_k_pep - PK_k_pep_end) + PK_k_pep_end', 'mM'),
        ('PK_pep_p_inp', '(1 dimensionless - PK_f_p) * (PK_k_pep_p - PK_k_pep_end) + PK_k_pep_end', 'mM'),
        ('PK_native', 'scale_gly * PK_Vmax * PK_alpha_inp * pep^PK_n/(PK_pep_inp^PK_n + pep^PK_n) * adp/(adp + PK_k_adp) * ( PK_base_act + (1-PK_base_act) *PK_f )', 'mol_per_s'),
        ('PK_phospho', 'scale_gly * PK_Vmax * PK_alpha_p_inp * pep^PK_n_p/(PK_pep_p_inp^PK_n_p + pep^PK_n_p) * adp/(adp + PK_k_adp) * ( PK_base_act_p + (1-PK_base_act_p) * PK_f_p )', 'mol_per_s'),
    ],
    formula=('(1 dimensionless - gamma)* PK_native + gamma * PK_phospho', 'mol_per_s')
)

PEPCK = ReactionTemplate(
    rid='PEPCK',
    name='PEPCK cyto',
    equation='oaa + gtp <-> pep + gdp + co2 []',
    localization='cyto',
    pars=[
        ('PEPCK_keq', 3.369565215864287E2, 'mM'),
        ('PEPCK_k_pep', 0.237, 'mM'),
        ('PEPCK_k_gdp', 0.0921, 'mM'),
        ('PEPCK_k_co2', 25.5, 'mM'),
        ('PEPCK_k_oaa', 0.0055, 'mM'),
        ('PEPCK_k_gtp', 0.0222, 'mM'),
        ('PEPCK_Vmax', 0, 'mol_per_s'),
    ],
    formula=('scale_gly * PEPCK_Vmax / (PEPCK_k_oaa * PEPCK_k_gtp) * (oaa*gtp - pep*gdp*co2/PEPCK_keq) / ( (1 dimensionless + oaa/PEPCK_k_oaa)*(1 dimensionless +gtp/PEPCK_k_gtp) + (1 dimensionless + pep/PEPCK_k_pep)*(1 dimensionless + gdp/PEPCK_k_gdp)*(1 dimensionless +co2/PEPCK_k_co2) - 1 dimensionless)', 'mol_per_s')
)

PEPCKM = ReactionTemplate(
    rid='PEPCKM',
    name='PEPCK mito',
    equation='oaa_mito + gtp_mito <-> pep_mito + gdp_mito + co2_mito []',
    localization='mito',
    pars=[
        ('PEPCKM_Vmax', 546, 'mol_per_s'),
    ],
    formula=('scale_gly * PEPCKM_Vmax / (PEPCK_k_oaa * PEPCK_k_gtp) * (oaa_mito*gtp_mito - pep_mito*gdp_mito*co2_mito/PEPCK_keq) / ( (1 dimensionless + oaa_mito/PEPCK_k_oaa)*(1 dimensionless + gtp_mito/PEPCK_k_gtp) + (1 dimensionless + pep_mito/PEPCK_k_pep)*(1 dimensionless + gdp_mito/PEPCK_k_gdp)*(1 dimensionless +co2_mito/PEPCK_k_co2) - 1 dimensionless)', 'mol_per_s')
)

PC = ReactionTemplate(
    rid='PC',
    name='Pyruvate Carboxylase',
    equation='atp_mito + pyr_mito + co2_mito => oaa_mito + adp_mito + phos_mito []',
    localization='mito',
    pars=[
        ('PC_k_atp', 0.22, 'mM'),
        ('PC_k_pyr', 0.22, 'mM'),
        ('PC_k_co2', 3.2, 'mM'),
        ('PC_k_acoa', 0.015, 'mM'),
        ('PC_n', 2.5, 'dimensionless'),
        ('PC_Vmax', 168, 'mol_per_s'),
    ],
    formula=('scale_gly * PC_Vmax * atp_mito/(PC_k_atp + atp_mito) * pyr_mito/(PC_k_pyr + pyr_mito) * co2_mito/(PC_k_co2 + co2_mito) * acoa_mito^PC_n / (acoa_mito^PC_n + PC_k_acoa^PC_n)', 'mol_per_s')
)

LDH = ReactionTemplate(
    rid='LDH',
    name='Lactate Dehydrogenase',
    equation='pyr + nadh <-> lac + nad []',
    localization='cyto',
    pars=[
        ('LDH_keq', 2.783210760047520E-004, 'dimensionless'),
        ('LDH_k_pyr', 0.495, 'mM'),
        ('LDH_k_lac', 31.98, 'mM'),
        ('LDH_k_nad', 0.984, 'mM'),
        ('LDH_k_nadh', 0.027, 'mM'),
        ('LDH_Vmax', 12.6, 'mol_per_s'),
    ],
    formula=('scale_gly * LDH_Vmax / (LDH_k_pyr * LDH_k_nadh) * (pyr*nadh - lac*nad/LDH_keq) / ( (1 dimensionless +nadh/LDH_k_nadh)*(1 dimensionless +pyr/LDH_k_pyr) + (1 dimensionless +lac/LDH_k_lac) * (1 dimensionless +nad/LDH_k_nad) - 1 dimensionless)', 'mol_per_s')
)

LACT = ReactionTemplate(
    rid='LACT',
    name='Lactate transport (import)',
    equation='lac_ext <-> lac []',
    localization='pm',
    pars=[
        ('LACT_keq', 1, 'dimensionless'),
        ('LACT_k_lac', 0.8, 'mM'),
        ('LACT_Vmax', 5.418, 'mol_per_s'),
    ],
    formula=('scale_gly * LACT_Vmax/LACT_k_lac * (lac_ext - lac/LACT_keq) / (1 dimensionless + lac_ext/LACT_k_lac + lac/LACT_k_lac)', 'mol_per_s')
)

PYRTM = ReactionTemplate(
    rid='PYRTM',
    name='Pyruvate transport (mito)',
    equation='pyr -> pyr_mito []',
    localization='mm',
    pars=[
        ('PYRTM_keq', 1, 'dimensionless'),
        ('PYRTM_k_pyr', 0.1, 'mM'),
        ('PYRTM_Vmax', 42, 'mol_per_s'),
    ],
    formula=('scale_gly * PYRTM_Vmax/PYRTM_k_pyr * (pyr - pyr_mito/PYRTM_keq) / (1 dimensionless + pyr/PYRTM_k_pyr + pyr_mito/PYRTM_k_pyr)', 'mol_per_s')
)

PEPTM = ReactionTemplate(
    rid='PEPTM',
    name='PEP Transport (export mito)',
    equation='pep_mito -> pep []',
    localization='mm',
    pars=[
        ('PEPTM_keq', 1, 'dimensionless'),
        ('PEPTM_k_pep', 0.1, 'mM'),
        ('PEPTM_Vmax', 33.6, 'mol_per_s'),
    ],
    formula=('scale_gly * PEPTM_Vmax/PEPTM_k_pep * (pep_mito - pep/PEPTM_keq) / (1 dimensionless + pep/PEPTM_k_pep + pep_mito/PEPTM_k_pep)', 'mol_per_s')
)

PDH = ReactionTemplate(
    rid='PDH',
    name='Pyruvate Dehydrogenase',
    equation='pyr_mito + coa_mito + nad_mito => acoa_mito + co2_mito + nadh_mito +h_mito []',
    localization='mito',
    pars=[
        ('PDH_k_pyr', 0.025, 'mM'),
        ('PDH_k_coa', 0.013, 'mM'),
        ('PDH_k_nad', 0.050, 'mM'),
        ('PDH_ki_acoa', 0.035, 'mM'),
        ('PDH_ki_nadh', 0.036, 'mM'),
        ('PDH_alpha_nat', 5, 'dimensionless'),
        ('PDH_alpha_p', 1, 'dimensionless'),
        ('PDH_Vmax', 13.44, 'mol_per_s'),
    ],
    rules=[
        ('PDH_base', 'scale_gly * PDH_Vmax * pyr_mito/(pyr_mito + PDH_k_pyr) * nad_mito/(nad_mito + PDH_k_nad*(1 dimensionless + nadh_mito/PDH_ki_nadh)) * coa_mito/(coa_mito + PDH_k_coa*(1 dimensionless +acoa_mito/PDH_ki_acoa))', 'mol_per_s'),
        ('PDH_nat', 'PDH_base * PDH_alpha_nat', 'mol_per_s'),
        ('PDH_p', 'PDH_base * PDH_alpha_p', 'mol_per_s'),
    ],
    formula=('(1 dimensionless - gamma) * PDH_nat + gamma*PDH_p', 'mol_per_s')
)

CS = ReactionTemplate(
    rid='CS',
    name='Citrate Synthase',
    equation='acoa_mito + oaa_mito + h2o_mito <-> cit_mito + coa_mito []',
    localization='mito',
    pars=[
        ('CS_keq', 2.665990308427589E5, 'dimensionless'),
        ('CS_k_oaa', 0.002, 'mM'),
        ('CS_k_acoa', 0.016, 'mM'),
        ('CS_k_cit', 0.420, 'mM'),
        ('CS_k_coa', 0.070, 'mM'),
        ('CS_Vmax', 4.2, 'mol_per_s'),
    ],
    formula=('scale_gly * CS_Vmax/(CS_k_oaa * CS_k_acoa) * (acoa_mito*oaa_mito - cit_mito*coa_mito/CS_keq) / ( (1 dimensionless +acoa_mito/CS_k_acoa)*(1 dimensionless +oaa_mito/CS_k_oaa) + (1 dimensionless +cit_mito/CS_k_cit)*(1 dimensionless +coa_mito/CS_k_coa) -1 dimensionless)', 'mol_per_s')
)

NDKGTPM = ReactionTemplate(
    rid='NDKGTPM',
    name='Nucleoside-diphosphate kinase (ATP, GTP) mito',
    equation='atp_mito + gdp_mito <-> adp_mito + gtp_mito []',
    localization='mito',
    pars=[
        ('NDKGTPM_keq', 1, 'dimensionless'),
        ('NDKGTPM_k_atp', 1.33, 'mM'),
        ('NDKGTPM_k_adp', 0.042, 'mM'),
        ('NDKGTPM_k_gtp', 0.15, 'mM'),
        ('NDKGTPM_k_gdp', 0.031, 'mM'),
        ('NDKGTPM_Vmax', 420, 'mol_per_s'),
    ],
    formula=('scale_gly * NDKGTPM_Vmax / (NDKGTPM_k_atp * NDKGTPM_k_gdp) * (atp_mito*gdp_mito - adp_mito*gtp_mito/NDKGTPM_keq) / ( (1 dimensionless + atp_mito/NDKGTPM_k_atp)*(1 dimensionless + gdp_mito/NDKGTPM_k_gdp) + (1 dimensionless + adp_mito/NDKGTPM_k_adp)*(1 dimensionless + gtp_mito/NDKGTPM_k_gtp) - 1 dimensionless)', 'mol_per_s')
)

OAAFLX = ReactionTemplate(
    rid='OAAFLX',
    name='oxalacetate influx',
    equation='=> oaa_mito []',
    localization='mito',
    pars=[
        ('OAAFLX_Vmax', 0, 'mol_per_s'),
    ],
    formula=('scale_gly * OAAFLX_Vmax', 'mol_per_s')
)

ACOAFLX = ReactionTemplate(
    rid='ACOAFLX',
    name='acetyl-coa efflux',
    equation='acoa_mito => []',
    localization='mito',
    pars=[
        ('ACOAFLX_Vmax', 0, 'mol_per_s'),
    ],
    formula=('scale_gly * ACOAFLX_Vmax', 'mol_per_s')
)

CITFLX = ReactionTemplate(
    rid='CITFLX',
    name='citrate efflux',
    equation='cit_mito => []',
    localization='mito',
    pars=[
        ('CITFLX_Vmax', 0, 'mol_per_s'),
    ],
    formula=('scale_gly * CITFLX_Vmax', 'mol_per_s')
)
