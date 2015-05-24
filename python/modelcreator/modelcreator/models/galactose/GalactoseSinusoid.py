"""
Model of galactose metabolism on sinusoidal level.

Definition of the information necessary for galactose
metabolism on sinusoidal level.
"""

names = dict()
units = dict()
pars = []
external = []
assignments = []
rules = []

# -------------------------------------------------------------------------
# External Species
# -------------------------------------------------------------------------
external.extend([
    ('rbcM', 0.0, '-'),
    ('suc',  0.0, 'mM'),
    ('alb',  0.0, 'mM'),
    ('gal',  0.00012, 'mM'),
    ('galM', 0.0, 'mM'),
    ('h2oM', 0.0, 'mM'),
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

# -------------------------------------------------------------------------
# Diffusion Parameters
# -------------------------------------------------------------------------
pars.extend([
    # diffusion constants [m^2/s]
    ('Dh2oM', 2300E-12, 'm2_per_s', 'True'),
    ('Dgal',   910E-12, 'm2_per_s', 'True'),
    ('DgalM',  910E-12, 'm2_per_s', 'True'),
    ('Dsuc',   720E-12, 'm2_per_s', 'True'),
    ('Dalb',    90E-12, 'm2_per_s', 'True'),
    ('DrbcM',  0.0E-12, 'm2_per_s', 'True'),
            
    ('r_h2oM', 0.15E-9, 'm', 'True'),
    ('r_gal',  0.36E-9, 'm', 'True'),
    ('r_galM', 0.36E-9, 'm', 'True'),
    ('r_suc',  0.44E-9, 'm', 'True'),
    ('r_alb',  3.64E-9, 'm', 'True'),
    ('r_rbcM', 3000E-9, 'm', 'True'),
])

names.update({
    'Dh2oM': 'diffusion constant water M*',
    'Dgal': 'diffusion constant galactose',
    'DgalM': 'diffusion constant galactose M*',
    'Dsuc': 'diffusion constant sucrose',
    'Dalb': 'diffusion constant albumin',
    'DrbcM': 'diffusion constant rbc M*',

    'r_h2oM': 'diffusion constant water M*',
    'r_gal': 'effective radius galactose',
    'r_galM': 'effective radius galactose M*',
    'r_suc': 'effective radius sucrose',
    'r_alb': 'effective radius albumin',
    'r_rbcM': 'effective radius rbc M*',
})

# -------------------------------------------------------------------------
# Event parameters
# -------------------------------------------------------------------------
pars.extend([
    ('gal_challenge',  0.0,    'mM',    True),
    ('peak_type',      0.0,    '-',    False),
    ('peak_status',    0.0,    '-',    False),
    ('t_peak',         5000.0, 's',     True),
    ('t_duration',     0.5,    's',     True),
    ('peak_area',      1.0,    'mM_s',     True),
])

rules.extend([
    # id, assignment, unit
    ('t_peak_end', 't_peak + t_duration', 's'),
    ('y_peak', 'peak_area/t_duration', 'mM'),
    ("mu_peak", "t_peak + t_duration/2 dimensionless",  "s"),
    ('sigma_peak',  "1 mM_s/(y_peak * sqrt(2 dimensionless*pi))", "s"),
    ('peak_gauss',  "peak_status * 1 mM_s/(sigma_peak *sqrt(2 dimensionless*pi)) * exp(-(time-mu_peak)^2/(2 dimensionless * sigma_peak^2))", "mM"),
    ('peak_rect',  "peak_status * y_peak", "mM"),
    ('peak', "(1 dimensionless - peak_type)*peak_rect + peak_type * peak_gauss", "mM"),
    ('PP__galM',  "peak_status * peak", "mM"),
    ('PP__rbcM',  "peak_status * peak", "mM"),
    ('PP__alb',  "peak_status * peak", "mM"),
    ('PP__h2oM',  "peak_status * peak", "mM"),
    ('PP__suc',  "peak_status * peak", "mM"),
])

names.update({
    'gal_challenge': 'galactose challenge periportal',
    't_peak': 'time of peak',
    't_peak_end': 'end time of peak',
    't_duration': 'duration of peak',
    'y_peak': 'peak height',
    'mu_peak': 'mean location gauss peak',
    'sigma_peak': 'sigma gauss peak',
    'peak': 'concentration of gauss peak',
    'peak_status': 'no peak (0), peak (1)',
    'peak_type': 'type of peak (rectangular 0, gauss 1)',
})
