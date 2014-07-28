'''
Basic model for clearance of substance.

@author: Matthias Koenig
@date:   2014-07-28
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
           ('sucM',  0.0, 'mM'),
           ('albM',  0.0, 'mM'),
           ('s1',  0.0, 'mM'),
           ('s1M', 0.0, 'mM'),
])
names['rbcM'] = 'red blood cells M*'
names['sucM'] = 'sucrose M*'
names['albM'] = 'albumin M*'
names['s1'] = 's1'
names['s1M'] = 's1 M*'
names['s1p'] = 's1 phosphate'
names['atp'] = 'ATP'
names['adp'] = 'ADP'
names['phos'] = 'phosphate'
    
##########################################################################
# Diffusion Parameters
##########################################################################
pars.extend(
            # diffusion constants [m^2/s]
            [
            ('DrbcM',  0.0E-12, 'm2_per_s', 'True'),
            ('DsucM',   720E-12, 'm2_per_s', 'True'),
            ('DalbM',    90E-12, 'm2_per_s', 'True'),
            # ('Dgal',   910E-12, 'm2_per_s', 'True'),
            ('Ds1',   910E-12, 'm2_per_s', 'True'),
            ('Ds1M',  910E-12, 'm2_per_s', 'True'),
            #('Dh2oM', 2200E-12, 'm2_per_s', 'True'),
])
names['DrbcM'] = 'diffusion constant rbc M*'
names['DsucM'] = 'diffusion constant sucrose M*'
names['DalbM'] = 'diffusion constant albumin M*'
names['Ds1'] = 'diffusion constant s1'
names['Ds1M'] = 'diffusion constant s1 M*'
# names['Dgal'] = 'diffusion constant galactose'
# names['DgalM'] = 'diffusion constant galactose M*'
# names['Dh2oM'] = 'diffusion constant water M*'
    
##########################################################################
# Additional Parameters
##########################################################################
# pars.append( ('gal_challenge',  0.0,    'mM',    True) )
    
    

    
    