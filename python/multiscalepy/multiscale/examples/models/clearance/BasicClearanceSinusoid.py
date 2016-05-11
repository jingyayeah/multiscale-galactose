"""
Basic model for clearance of substance.
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
    ('sucM',  0.0, 'mM'),
    ('albM',  0.0, 'mM'),
    ('s1',  0.0, 'mM'),
    ('s1M', 0.0, 'mM'),
])
names.update({
    'rbcM': 'red blood cells M*',
    'sucM': 'sucrose M*',
    'albM': 'albumin M*',
    's1': 's1',
    's1M': 's1 M*',
    's1p': 's1 phosphate',
    'atp': 'ATP',
    'adp': 'ADP',
    'phos': 'phosphate',
})

# -------------------------------------------------------------------------
# Diffusion Parameters
# -------------------------------------------------------------------------
pars.extend([
    # diffusion constants [m^2/s]
    ('DrbcM',  0.0E-12, 'm2_per_s', 'True'),
    ('DsucM',   720E-12, 'm2_per_s', 'True'),
    ('DalbM',    90E-12, 'm2_per_s', 'True'),
    ('Ds1',   910E-12, 'm2_per_s', 'True'),
    ('Ds1M',  910E-12, 'm2_per_s', 'True'),
])
names.update({
    'DrbcM': 'diffusion constant rbc M*',
    'DsucM': 'diffusion constant sucrose M*',
    'DalbM': 'diffusion constant albumin M*',
    'Ds1': 'diffusion constant s1',
    'Ds1M': 'diffusion constant s1 M*',
})

# -------------------------------------------------------------------------
# Event parameters
# -------------------------------------------------------------------------
pars.extend([
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
    # what to set in the peak
    ('PP__s1M',  "peak_status * peak", "mM"),
    ('PP__rbcM',  "peak_status * peak", "mM"),
    ('PP__albM',  "peak_status * peak", "mM"),
    ('PP__sucM',  "peak_status * peak", "mM"),
])

names.update({
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
