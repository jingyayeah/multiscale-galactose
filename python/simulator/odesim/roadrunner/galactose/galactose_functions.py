# -*- coding: utf-8 -*-
"""
Created on Fri Dec 19 14:47:01 2014

@author: mkoenig
"""

import numpy as np
from scipy import stats
from roadrunner_tools import selection_dict


##  Distribution of fluxes  ##################################################
def flux_sample():
    ''' 
    Returns sampled fluxes for the integration.
    '''
    flux = np.arange(start=10, stop=800, step=50) *1E-6
    return np.sort(flux)


def flux_probability(flux):
    """
    Returns probability for given flux based on probability
    distribution of fluxes.
    """
    # TODO: this is hardcoded and should be read from the fitted parameters.
    import pylab as plt
    x = np.linspace(0.1E-6, 1100E-6, num=400) # values for x-axis
    # mu = -8.358303    # dtmp['meanlog']
    # sigma = 0.6178210 # dtmp['sdlog']
    mu = -8.383090    # dtmp['meanlog']
    sigma = 0.5468566 # dtmp['sdlog']
    
    pdf = stats.lognorm.pdf(x, sigma, loc=0, scale=np.exp(mu))
    plt.figure(figsize=(12,4.5))
    plt.plot(x, pdf)
    
    p_flux = stats.lognorm.pdf(flux, sigma, loc=0, scale=np.exp(mu))
    plt.plot(flux, p_flux)
    return p_flux
    
    
def pressure_sample(Pb=2.0):
    '''
    Returns sampled periportal pressures for the integration in [mmHg].
    
    Lognormal pressure distribution in [mmHg] 
    mean =  4.4 , meanlog =  1.309539 
    std =  2.82 , stdlog =  0.5866274
    Pb = 2 [mmHg] 
    '''
    pressure = np.arange(start=Pb + 0.5, stop=18, step=1.5)
    return np.sort(pressure)


def pressure_probability(pressure, Pb=2.0):
    """
    Returns probability for given pressure based on probability
    distribution of fluxes.

    Careful with the offset of perivenous pressure.
    """
    # TODO: this is hardcoded and should use the fitted parameter values.
    import pylab as plt
    x = np.linspace(0, 40, num=400) # values for x-axis
    
    mu = 1.309539    # dtmp['meanlog']
    sigma = 0.5866274 # dtmp['sdlog']
    
    pdf = stats.lognorm.pdf(x, sigma, loc=0, scale=np.exp(mu))
    plt.figure(figsize=(12,4.5))
    plt.plot(x+Pb, pdf)
    
    p_pressure = stats.lognorm.pdf(pressure-Pb, sigma, loc=0, scale=np.exp(mu))
    plt.plot(pressure, p_pressure)
    return p_pressure


 
def average_results(f_list, weights, ids, time, selections):
    from scipy import interpolate
    sel_dict = selection_dict(selections)
    
    res = np.zeros(shape=(len(time), len(ids)))  # store the averaged results    
    for (k, sid) in enumerate(ids):
        # create empty array
        mat = np.zeros(shape =(len(time), len(f_list)))
        # fill matrix        
        for ks, s in enumerate(f_list):
            x = s[:,0]
            # find in which place of the solution the component is encoded
            index = sel_dict.get(sid, None)
            if not index:
                raise Exception("{} not in selection".format(sid))
            y = s[:,index]
            f = interpolate.interp1d(x=x, y=y)
            mat[:,ks] = f(time)
        # average the matrix
        av = np.average(mat, axis=1, weights=weights)
        res[:, k] = av
    return res
 
 
def GLUT2_inhibition(c,km):
    ''' Analyse inhibition of GLUT2 (competitive) '''
    return 1.0/(1.0+2.0*c/km)    


if __name__ == "__main__":
    import numpy as np

    c = np.array((2.58,14.8, 19.8))
    GLUT2_inhibition(c, 27.8)
    c = np.array((0.28,12.5, 17.5))
    GLUT2_inhibition(c, 27.8)