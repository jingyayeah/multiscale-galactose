# -*- coding: utf-8 -*-
"""
Created on Thu Feb 12 11:58:16 2015

@author: mkoenig
"""

# Model version to use
VERSION = 104
SBML_DIR = '/home/mkoenig/multiscale-galactose-results/tmp_sbml'
T_PEAK = 5000

F_FLOW = 0.5

# Model changes applied to all simulations
D_TEMPLATE = {
              "gal_challenge" : 8,  
              "GALK_k_gal": 0.14,
              # "y_dis" : 2.3E-6,
              #"y_cell" : 8.39E-6*1.12,
              #"f_cyto" : 0.4,
              "scale_f" : 0.41/1.1,
              #"GALK_PA" : 0.024,
              #"GLUT2_f" : 7.5,              
              # "H2OT_f": 5.0,         
}
