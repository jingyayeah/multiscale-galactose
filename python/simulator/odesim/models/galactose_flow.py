"""
Simulations under given flow.

Created on May 3, 2015
@author: mkoenig
"""
from simapp.models import *
import numpy as np

from simulator.dist.distributions import getGalactoseDistributions
from simulator.dist.sampling import createParametersBySampling

import odesim.db_tools as simfac

SYNC_BETWEEN_SERVERS = False

def createGalactoseSamples(N, sampling):
    dist_data = getGalactoseDistributions()
    samples = createParametersBySampling(dist_data, N, sampling)
    samples = setDeficiencyInSamples(samples, deficiency=0)
    return samples

def createFlowSamples(N, sampling, f_flows):
    ''' Create samples for the different flow adaptions. '''
    dist_data = getGalactoseDistributions()
    raw_samples = createParametersBySampling(dist_data, N, sampling)
    raw_samples = setDeficiencyInSamples(raw_samples, deficiency=0)
    samples = []
    # Go over the flow range and create the flow samples, set the flow parameter in all cases
    for f_flow in f_flows:
        tmp_samples = simfac.deepcopy_samples(raw_samples)
        tmp_samples = adapt_flow_in_samples(tmp_samples, f_flow)
        samples.extend(tmp_samples)
    return samples

def adapt_flow_in_samples(samples, f_flow):
    '''
    Flow is adapted via scaling of all samples with a constant factor f_flow.
    The sample distribution is linearly scaled with the provided factor.
    '''
    for s in samples:
        if (s.has_key("flow_sin")):
            name, value, unit, ptype = s["flow_sin"]
            s["flow_sin"] = (name, value*f_flow, unit, ptype)
            s["f_flow"] = ("f_flow", f_flow, '-', NONE_SBML_PARAMETER)
    return samples


def createPressureSamples(N):
    '''  '''
    # TODO: implement the sampling from pressures
    raise NotImplemented


def setDeficiencyInSamples(samples, deficiency=0):
    return simfac.setParameterInSamples(samples, 'deficiency', deficiency, '-', GLOBAL_PARAMETER)



# TODO: provide functionality for simple manual creation
# def _createSamplesByManual():
#     ''' Manual parameter creation. Only sample L and flow_sin. 
#
#     '''
#     print "DEPRECIATED _createSamplesByManual"
#     samples = []
#     # what parameters should be sampled
#     flows = np.arange(0.0, 600E-6, 60E-6)
#     lengths = np.arange(400E-6, 600E-6, 100E-6)
#     for flow_sin in flows:
#         for L in lengths: 
#             s = Sample()
#             for pid in ("y_cell", "y_dis", "y_sin"):
#                 dtmp = dist_data[pid];
#                 s.add_parameter(SampleParameter(dtmp['name'], dtmp['mean'],
#                                                 dtmp['unit'], GLOBAL_PARAMETER))
#             s.add_parameter(SampleParameter('flow_sin', flow_sin, 'm/s', GLOBAL_PARAMETER))
#             s.add_parameter(SampleParameter('L', L, 'm', GLOBAL_PARAMETER))                     
#             samples.append(s)
#     return samples


#----------------------------------------------------------------------#
def make_galactose_core(sbml_id, N):
    info = '''Simulation of varying galactose concentrations periportal to steady state.'''
    model = simfac.django_model_from_id(sbml_id, sync=SYNC_BETWEEN_SERVERS)
    
    # create parameter samples
    samples = createGalactoseSamples(N=N, sampling='distribution') 
    samples = adapt_flow_in_samples(samples, f_flow=0.5)
    gal_range = np.arange(0, 6, 0.5)
    samples = simfac.setParameterValuesInSamples(samples, 'PP__gal', gal_range, 'mM', BOUNDERY_INIT)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Method.get_or_create_integration(settings)
    task = simfac.create_task(model, integration, info=info)
    simfac.createSimulationsForSamples(task, samples)
    
    return (task, samples)

# ----------------------------------------------------------------------#
def make_galactose_dilution(sbml_id, N, sampling):
    info = 'Multiple-indicator dilution curves II({})'.model_format(sampling)
    model = simfac.django_model_from_id(sbml_id, sync=SYNC_BETWEEN_SERVERS)
    
    # adapt flow in samples with the given f_flows
    # f_flows = (1.0, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.01)
    if VERSION <= 107:
        f_flows = (1.0, 0.5, 0.25)
        raw_samples = createFlowSamples(N=N, sampling=sampling, f_flows=f_flows)
    else:
        # set the pressures for the simulation
        # TODO: implement
        raise NotImplemented

        # raw_samples = createPressureSamples(N=N, sampling=sampling)
    
    # ? why this
    samples = simfac.setParameterInSamples(raw_samples, 'PP__gal', 0.0, 'mM', BOUNDERY_INIT)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Method.get_or_create_integration(settings)
    task = simfac.create_task(model, integration, info=info, priority=0)
    # createSimulationsForSamples(task, samples)

    return (task, samples)

# ----------------------------------------------------------------------#
def make_galactose_challenge(sbml_id, N, sampling):        
    info = 'Galactose challenge periportal ({})'.model_format(sampling)
    model = simfac.django_model_from_id(sbml_id, sync=SYNC_BETWEEN_SERVERS)
    
    # parameter samples
    raw_samples = createGalactoseSamples(N=N, sampling=sampling) 
    # gal_challenge = np.arange(0.5, 7.0, 0.5)
    gal_challenge = (0.5, 1.0, 2.0, 4.0, 8.0)
    samples = simfac.setParameterValuesInSamples(raw_samples, 'gal_challenge', gal_challenge, 'mM', GLOBAL_PARAMETER)
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':100} )
    integration = Method.get_or_create_integration(settings)
    task = simfac.create_task(model, integration, info=info)
    simfac.createSimulationsForSamples(task, samples)
    
    return (task, samples)

#----------------------------------------------------------------------#
def make_galatose_flow_samples(N, sampling, f_flows, gal_challenge):
    # adapt flow in samples with the given f_flows
    raw_samples = createFlowSamples(N=N, sampling=sampling, f_flows=f_flows)
    
    # Set given galactose challenge   
    samples = simfac.setParameterValuesInSamples(raw_samples, 
                [{'pid': 'gal_challenge', 'values': gal_challenge, 'unit': 'mM', 'parameter_type':GLOBAL_PARAMETER}])
    return samples


def make_elimination_curve(sbml_id, sampling, samples):        
    info = 'Galactose elimination ({}).'.model_format(sampling)
    model = simfac.django_model_from_id(sbml_id, sync=SYNC_BETWEEN_SERVERS)
        
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':50} )
    integration = Method.get_or_create_integration(settings)
    task = simfac.create_task(model, integration, info=info)
    simfac.createSimulationsForSamples(task, samples)

    return (task, samples)

#----------------------------------------------------------------------#
def make_galactose_aging(sbml_id, sampling, samples):        
    
    model = simfac.django_model_from_id(sbml_id, sync=SYNC_BETWEEN_SERVERS)
        
    # age represents : [20, 40, 60, 80, 100]
    # [1, 1.375, 1.75, 2.125, 2.5]
    # [1, 0.5, 0.25, 0.125, 0.0625]
    
    # age represents : [60, 80, 100]
    # age = [20, 60, 80, 100]
    # y_end = [165E-9*x for x in [1, 1.75, 2.125, 2.5]]  # [nm]
    # N_fen = [1E13*x for x in [1, 0.25, 0.125, 0.0625]]  # [1/m^2]
    age = [20, 60, 100]
    y_end = [165E-9*x for x in [1, 1.75, 2.5]]  # [nm]
    N_fen = [1E13*x for x in [1, 0.25, 0.0625]]  # [1/m^2]
    
    
    for k in range(len(y_end)):
        info = 'Galactose elimination age {} ({}).'.model_format(age[k], sampling)
        p_list = [ {'pid': 'y_end', 'values': (y_end[k],) , 'unit': 'nm', 'parameter_type':GLOBAL_PARAMETER},
                   {'pid': 'N_fen', 'values': (N_fen[k],), 'unit': 'per_m2', 'parameter_type':GLOBAL_PARAMETER}]
        nsamples = simfac.setParameterValuesInSamples(samples, p_list)
        
        # simulations
        settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':50} )
        integration = Method.get_or_create_integration(settings)
        task = simfac.create_task(model, integration, info=info)
        simfac.createSimulationsForSamples(task, nsamples)

    return None

#----------------------------------------------------------------------#
def make_galactose_vmax(sbml_id, sampling, samples):        
   
    model = simfac.django_model_from_id(sbml_id, sync=SYNC_BETWEEN_SERVERS)
    # age represents : [20, 40, 60, 80, 100]
    GALK_PA = [0.024*x for x in [0.5, 0.75, 0.9, 1, 1.1, 1.5]]  # [-]
    for k in range(len(GALK_PA)):
        info = 'Galactose elimination GALK Vmax {} ({}).'.model_format(GALK_PA[k], sampling)
        p_list = [ {'pid': 'GALK_PA', 'values': (GALK_PA[k],), 'unit': '-', 'parameter_type':GLOBAL_PARAMETER}, ]
        nsamples = simfac.setParameterValuesInSamples(samples, p_list)
    
        # simulations
        settings = Setting.get_settings( {'tstart':0.0, 'tend':10000.0, 'steps':50} )
        integration = Method.get_or_create_integration(settings)
        task = simfac.create_task(model, integration, info=info)
        simfac.createSimulationsForSamples(task, nsamples)

    return None


#----------------------------------------------------------------------#
def make_galactose_step(sbml_id, N, sampling):        
    info = 'Stepwise increase of periportal galactose ({})'.model_format(sampling)
    model = simfac.django_model_from_id(sbml_id, sync=SYNC_BETWEEN_SERVERS)
    
    # parameter samples
    samples = createGalactoseSamples(N=N, sampling=sampling) 
    
    # simulations
    settings = Setting.get_settings( {'tstart':0.0, 'tend':30000.0, 'steps':100} )
    integration = Method.get_or_create_integration(settings)
    task = simfac.create_task(model, integration, info=info)
    simfac.createSimulationsForSamples(task, samples)
    
    return (task, samples)

#----------------------------------------------------------------------#
def derive_deficiency_simulations(task, samples, deficiencies):
    """ Takes a given set of samples for the normal case and
        creates the corresponding deficiency simulations.
        The information is stored in the settings dict
        """
    sdict = task.method.get_settings_dict()
    for d in deficiencies:
        sdict['condition'] = 'GDEF_' + str(d)
        settings = Setting.get_settings(sdict)
        integration = Method.get_or_create_integration(settings)
        # Creates a new derived task (the integr
        task_d = simfac.create_task(task.model, integration, info=task.info)
        
        # create the simulations (adaption of samples)
        samples = setDeficiencyInSamples(samples, deficiency=d)
        simfac.createSimulationsForSamples(task_d, samples)    


####################################################################################
if __name__ == "__main__":
    VERSION = 107 
    
    #----------------------------------------------------------------------#
    # Core odesim
    #----------------------------------------------------------------------#
    # Varying galatose under constant flow
    if (1):
        
        sbml_id = 'Galactose_v{}_Nc20_core'.model_format(VERSION)
        # create model from file
        model = simfac.django_model_from_file(sbml_file='../../examples/{}.xml'.model_format(sbml_id), sync=False)
        [task, samples] = make_galactose_core(sbml_id, N=1)
    
    
    
    #----------------------------------------------------------------------#
    # GALACTOSE CHALLENGE
    #----------------------------------------------------------------------#
    # run all simulations under the same flow and galactose conditions
    #    especially the the aging & varying metabolic capacity
    f_flows = (1.0, 0.8, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.01)
    gal_challenge = (0.05, 0.1, 0.2, 0.5, 1.0, 2.0, 4.0, 6.0, 8.0,)
    
    # sample from distribution
    dist_samples = make_galatose_flow_samples(N=1, sampling='distribution', 
                                             f_flows=f_flows, gal_challenge=gal_challenge)
    # mean sinusoidal unit
    mean_samples = make_galatose_flow_samples(N=1, sampling='mean', 
                                             f_flows=f_flows, gal_challenge=gal_challenge)
    
    if (0):
        '''
        Galactose elimination curves. 
        The simple galactose elimination curve is calculated by scaling the
        flow distributions to various mean flow values. These curves have
        to be calculated for varying galactose challenges.
        '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".model_format(VERSION)
        # samples
        task = make_elimination_curve(sbml_id, sampling='distribution', 
                                      samples=dist_samples)
        
        # mean sinusoidal unit
        task = make_elimination_curve(sbml_id, sampling='mean', 
                                      samples=mean_samples)

    #----------------------------------------------------------------------#
    if (0):
        ''' GEC curves in aging. 
            Age dependent change in N_fen and y_end.
        '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".model_format(VERSION)
        # samples
        make_galactose_aging(sbml_id, sampling='distribution', 
                                    samples=dist_samples)
        # mean sinusoidal unit
        make_galactose_aging(sbml_id, sampling='mean',
                                             samples=mean_samples)
   
    #----------------------------------------------------------------------#
    if (0):
        ''' GEC curves under varying metabolic capacity of galactose metabolism. 
            Change in the maximal scale of metabolism.
        '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".model_format(VERSION)
        # sample from distribution & add additional changes in aging
        make_galactose_vmax(sbml_id, sampling='distribution',
                                            samples=dist_samples)
        
        # mean sinusoidal unit
        make_galactose_vmax(sbml_id, sampling='mean',
                                                        samples=mean_samples)
   
    #----------------------------------------------------------------------#
    # MULTIPLE INDICATOR DILUTION CURVES
    #----------------------------------------------------------------------#
    if (0):
        '''
        Multiple Indicator Dilution.
        Combination with different galactose challenge, i.e. dilution curves
        under varying galactose concentrations periportal.
        The galactose values periportal must be corrected for already occurred clearance,
        i.e the periportal concentrations are higher than the reported values.
        A correction factor of ~2.3 was applied to the reported galactose values of
        PP__gal = (2.3, 5, 14.8, 19.8) # [mM]
        '''
        sbml_id = 'Galactose_v{}_Nc20_dilution'.model_format(VERSION)
        PP__gal = (0.28, 12.5, 17.5) # [mM]
        # PP__gal = (2.58, 14.8, 19.8)   # [mM]
        
        p_list = [ {'pid': 'PP__gal', 'values': PP__gal, 'unit': 'mM', 'parameter_type':BOUNDERY_INIT}]
        
        # mean sinusoid for comparison
        [task, raw_samples] = make_galactose_dilution(sbml_id, N=1, sampling="mean")
        samples = simfac.setParameterValuesInSamples(raw_samples, p_list)
        
        # TODO: URGENT model scaling : fix this shit, is really bad
        # introduce dog factor
        scale_dog = 0.31/2
        samples = simfac.setParameterInSamples(samples, "scale_f", scale_dog, 'per_m3', GLOBAL_PARAMETER)
        
        simfac.createSimulationsForSamples(task, samples)
        
        if False:
            # basic dilution curves with additional galactose challenge
            [task, raw_samples] = make_galactose_dilution(sbml_id, N=100, sampling="distribution")
            samples = simfac.setParameterValuesInSamples(raw_samples, p_list)
            simfac.createSimulationsForSamples(task, samples)

    #----------------------------------------------------------------------#
    # GALACTOSEMIAS
    #----------------------------------------------------------------------#
    if (0):
        ''' Galactose challenge in galactosemias. '''
        sbml_id = "Galactose_v{}_Nc20_galchallenge".model_format(VERSION)
        deficiencies = range(1, 24)
        
        # Create deficiency samples belonging to the original samples
        task, samples = make_galactose_challenge(sbml_id, N=5, sampling='distribution')
        derive_deficiency_simulations(task, samples, deficiencies)
    
        # mean sinusoidal unit
        task, samples = make_galactose_challenge(sbml_id, N=1, sampling='mean')
        derive_deficiency_simulations(task, samples, deficiencies)
    #===========================================================================
    # if (0):
    #     ''' Reuse the samples from task.
    #         Necessary to generate the identical geometries than
    #         for the normal case.
    #         This is only for testing. For final simulations all galactosemias
    #         should be generated in batch.
    #     '''
    #     from simulator.dist.samples import get_samples_from_task
    #     task = Task.objects.get(pk=26)
    #     samples = get_samples_from_task(task)
    #     deficiencies = range(4,24)
    #     derive_deficiency_simulations(task, samples, deficiencies=deficiencies)
    #===========================================================================
        
    #----------------------------------------------------------------------#
    if (0):
        ''' Galactose stepwise increase. '''
        # sample from distribution
        task, samples = make_galactose_step(sbml_id="Galactose_v{}_Nc20_galstep".model_format(VERSION), 
                                            N=100, sampling='distribution')
        # mean sinusoidal unit
        task, samples = make_galactose_step(sbml_id="Galactose_v{}_Nc20_galstep".model_format(VERSION), 
                                            N=1, sampling='mean')

####################################################################################

