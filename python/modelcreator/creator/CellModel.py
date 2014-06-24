'''
Created on Jun 24, 2014

@author: mkoenig

The important part is to be able to put various metabolic models
in the sinusoidal model geometry. 
'''
from creator.MetabolicModel import MetabolicModel


class CellModel(MetabolicModel):
    '''
    Main functions to handle metabolic models included in
    sinusoidal models.
    '''
    pass


def GalactoseModel():
    gm = CellModel()
    
    
    gm.create
    
        ##########################################################################
    # Galactose cell model
    ##########################################################################
    def createCellCompartmentsDict(self):
        comps = dict()
        # hepatocyte compartments
        for k in GalactoseModel.cell_range:
            comps[getHepatocyteId(k)] = (getHepatocyteName(k), 3, 'm3', True, 'Vol_cell')
        return comps
##########################################################################
'''    
        cell = [
            ('gal',             0.00012, 'mM'),
            ('galM',            0.0,     'mM'),
            ('h2oM',            0.0,     'mM'),
            ('glc1p',           0.012,   'mM'),
            ('glc6p',           0.12,    'mM'),
            ('gal1p',           0.001,   'mM'),
            ('udpglc',          0.34,    'mM'),
            ('udpgal',          0.11,    'mM'),
            ('galtol',          0.001,   'mM'),
    
            ('atp',              2.7,    'mM'),
            ('adp',              1.2,    'mM'),
            ('utp',              0.27,   'mM'),
            ('udp',              0.09,   'mM'),
            ('phos',             5.0,    'mM'),
            ('ppi',              0.008,  'mM'),
            ('nadp',             0.1,    'mM'),
            ('nadph',            0.1,    'mM'),
    ]

    for data in cell:
        for k in range(1, Nc+1):
            sdict['H{:0>2d}__{}'.format(k, data[0])] = (names[data[0]]+' [H{:0>2d}]'.format(k), data[1], data[2])


# Reactions

# general definition
%% [GLUT2_GAL] galactose transport (gal_dis <-> gal)
%% [GLUT2_GALM] galactoseM transport (galM_dis <-> galM)

%------------------------------------------------------------
class GLUT2_GAL():
    id = 'GLUT2_GAL'
    name = 'galactose transport (gal_dis <-> gal)'
    equation = 'gal_dis <-> gal'
    unit = 'mole/s'
    
    parameters = [
        (GLUT2_P, 1.0, 'mM')
        (GLUT2_f, 0.5E6, '-')
        (GLUT2_k_gal, 85.5, 'mM')
    ]

    # assignments / initial assignment
    GLUT2_Vmax = GLUT2_f * scale * GLUT2_P/REF_P;  % [mole/s]
    GLUT2_dm = (1 + (gal_dis+galM_dis)/GLUT2_k_gal + (gal+galM)/GLUT2_k_gal); % [-]

    GLUT2_GAL_dis  = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (gal_dis - gal*onevec)./GLUT2_dm;    % [mole/s]
    GLUT2_GALM_dis = GLUT2_Vmax/(GLUT2_k_gal*Nf) * (galM_dis - galM*onevec)./GLUT2_dm;  % [mole/s]

    GLUT2_GAL  = sum(GLUT2_GAL_dis);    % [mole/s]
    GLUT2_GALM = sum(GLUT2_GALM_dis);   % [mole/s]


'''