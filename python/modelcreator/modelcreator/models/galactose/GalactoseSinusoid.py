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
names['glc'] = 'D-glucose'
names['glc1p'] = 'D-glucose 1-phophate'
names['glc6p'] = 'D-glucose 6-phosphate'
names['gal1p'] = 'D-galactose 1-phosphate'
names['udpglc'] = 'UDP-D-glucose'
names['udpgal'] = 'UDP-D-galactose'
names['galtol'] = 'D-galactitol'
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
# Additional Parameters
##########################################################################
pars.append( ('gal_challenge',  0.0,    'mM',    True) )
    
    
