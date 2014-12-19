'''
Model of galactose metabolism on sinusoidal level.

Definition of the information necessary for galactose 
metabolism on sinusoidal level. 

@author: Matthias Koenig
@date:   2014-07-21
'''

names = dict()
units = dict()
pars = []
external = []
assignments = []
rules = []

##########################################################################
# External Species
##########################################################################
external.extend([
           ('rbcM', 0.0, '-'),
           ('suc',  0.0, 'mM'),
           ('alb',  0.0, 'mM'),
           ('gal',  0.00012, 'mM'),
           ('galM', 0.0, 'mM'),
           ('h2oM', 0.0, 'mM'),
])

names['rbcM'] = 'red blood cells M*'
names['suc'] = 'sucrose'
names['alb'] = 'albumin'
names['h2oM'] = 'water M*'
names['glc'] = 'D-glucose'
names['gal'] = 'D-galactose'
names['galM'] = 'D-galactose M*'
names['glc1p'] = 'D-glucose 1-phophate'
names['glc1pM'] = 'D-glucose 1-phophate M*'
names['glc6p'] = 'D-glucose 6-phosphate'
names['glc6pM'] = 'D-glucose 6-phosphate M*'
names['gal1p'] = 'D-galactose 1-phosphate'
names['gal1pM'] = 'D-galactose 1-phosphate M*'
names['udpglc'] = 'UDP-D-glucose'
names['udpglcM'] = 'UDP-D-glucose M*'
names['udpgal'] = 'UDP-D-galactose'
names['udpgalM'] = 'UDP-D-galactose M*'
names['galtol'] = 'D-galactitol'
names['galtolM'] = 'D-galactitol M*'
names['atp'] = 'ATP'
names['adp'] = 'ADP'
names['utp'] = 'UTP'
names['udp'] = 'UDP'
names['phos'] = 'phosphate'
names['ppi'] = 'pyrophosphate'
names['nadp'] = 'NADP'
names['nadph'] = 'NADPH'
     
##########################################################################
# Diffusion Parameters
##########################################################################
pars.extend(
            # diffusion constants [m^2/s]
            [
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

names['Dh2oM'] = 'diffusion constant water M*'
names['Dgal'] = 'diffusion constant galactose'
names['DgalM'] = 'diffusion constant galactose M*'
names['Dsuc'] = 'diffusion constant sucrose'
names['Dalb'] = 'diffusion constant albumin'
names['DrbcM'] = 'diffusion constant rbc M*'

names['r_h2oM'] = 'diffusion constant water M*'
names['r_gal'] = 'effective radius galactose'
names['r_galM'] = 'effective radius galactose M*'
names['r_suc'] = 'effective radius sucrose'
names['r_alb'] = 'effective radius albumin'
names['r_rbcM'] = 'effective radius rbc M*'

    
##########################################################################
# Additional Parameters for Simulations
##########################################################################
pars.extend([
              ('gal_challenge',  0.0,    'mM',    True),
              ('peak_type',      0.0,    '-',    False),
              ('peak_status',    0.0,    '-',    False),
              ('t_peak',         5000.0, 's',     True),
              ('t_duration',     0.5,    's',     True),
            ])

rules.extend([
             # id, assignment, unit
            ('t_peak_end', 't_peak + t_duration', 's'),
            ('y_peak', '1 mM_s/t_duration', 'mM'),
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
    
names['gal_challenge'] = 'galactose challenge periportal'
names['t_peak'] = 'time of peak'
names['t_peak_end'] = 'end time of peak'
names['t_duration'] = 'duration of peak'    
names['y_peak'] = 'peak height'
names['mu_pean'] = 'mean location gauss peak'
names['sigma_peak'] = 'sigma gauss peak'
names['peak'] = 'concentration of gauss peak'
names['peak_status'] = 'no peak (0), peak (1)'
names['peak_type'] = 'type of peak (rectangular 0, gauss 1)'
