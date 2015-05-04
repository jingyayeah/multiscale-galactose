'''
Simulation tool to create the matrices from the resulting odesim.
The provided functions recreate matrices and arrows lost in the SBML
encoding for easier analysis.

@author: Matthias Koenig
@date: 2014-04-14
'''

import numpy as np
from modelcreator.tools.naming import *
import pandas as pd
from pandas import DataFrame, Series


def get_Nc(gp):
    return int(gp.ix['Nc'].value)

def get_P(gp):
    ''' Get DataFrame of local pressures from global parameters. 
        Information from global parameters only valid if the 
        calculated values are stationary.
    '''
    Nc = get_Nc(gp)
    ids = []
    x_ids = []

    # PP
    ids.append( getPressureId(getPPId()) )
    x_ids.append( getPositionId(getPPId()) )
    # along sinusoid
    for k in xrange(Nc):    
        ids.append( getPressureId(getSinusoidId(k+1)) )
        x_ids.append( getPositionId(getSinusoidId(k+1)) )
    # PV
    ids.append( getPressureId(getPVId()) )
    x_ids.append( getPositionId(getPVId()) )
    
    # create result df
    P = DataFrame({'value': gp.ix[ids].value}, 
                  index=ids)
    x = Series(gp.ix[x_ids].value)
    x.index = P.index # replace index
    P['x'] = x # add colum
    return P


def get_Q(gp):
    ''' Capillary flow vector. '''
    Nc = get_Nc(gp)
    ids = []
    x_ids = []

    # PP
    ids.append( getQFlowId(getPPId()) )
    x_ids.append( getPositionId(getPPId()) )
    # along sinusoid
    for k in xrange(Nc-1):    
        sid1 = getSinusoidId(k+1)
        sid2 = getSinusoidId(k+2)
        ids.append( getQFlowId(sid1, sid2) )
        x_ids.append( getPositionId(sid1, sid2) )
    # PV
    ids.append( getQFlowId(getPVId()) )
    x_ids.append( getPositionId(getPVId()) )
    
    # create result df
    Q = DataFrame({'value': gp.ix[ids].value}, 
                  index=ids)
    x = Series(gp.ix[x_ids].value)
    x.index = Q.index # replace index
    Q['x'] = x # add colum
    return Q
        

def get_q(gp):
    ''' Pore flow vector. '''
    Nc = get_Nc(gp)
    ids = []
    x_ids = []

    # along sinusoid
    for k in xrange(Nc):    
        ids.append( getqFlowId(getSinusoidId(k+1)) )
        x_ids.append( getPositionId(getSinusoidId(k+1)) )
    
    q = DataFrame({'value': gp.ix[ids].value}, 
                  index=ids)
    x = Series(gp.ix[x_ids].value)
    x.index = q.index # replace index
    q['x'] = x # add colum
    return q
    