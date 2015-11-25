# -*- coding: utf-8 -*-
"""
Basic settings used for the galactose simulations.
Here the version and necessary settings are created.
"""

from multiscale.multiscale_settings import SBML_DIR

# Model version to use
# VERSION = 107 # flow constant
VERSION = 129  # pressure model

T_PEAK = 5000  # TODO: read from SBML
F_FLOW = 0.8   # TODO: read from SBML

# Model changes applied to all simulations
D_TEMPLATE = {
              "gal_challenge" : 8,  
              # "GLUT2_f" : 17,
              # "GALK_k_gal": 0.14,
              # "scale_f" : 0.31,   # human 
              # "y_dis" : 2.3E-6,
              #"y_cell" : 8.39E-6*1.12,
              #"f_cyto" : 0.4,
              
              #"GALK_PA" : 0.024,
             
              # "H2OT_f": 5.0,         
}
