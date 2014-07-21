'''
Created on Jul 21, 2014

@author: mkoenig
'''


from SinusoidalUnit import SinusoidalUnit

class GalactoseSinusoid(SinusoidalUnit):
    '''
    Here the core information specific to the instantiation 
    of the sinusoidal unit model is stored.
    '''
    #########################################################################
    # TODO: get an overview how the class hierarchy is handeled
    # in python. There should be cleaner ways to do this.
    names = SinusoidalUnit.names
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
    # External Species
    ##########################################################################
    external = SinusoidalUnit.external
    external.extend([
           ('rbcM', 0.0, '-'),
           ('suc',  0.0, 'mM'),
           ('alb',  0.0, 'mM'),
           ('gal',  0.00012, 'mM'),
           ('galM', 0.0, 'mM'),
           ('h2oM', 0.0, 'mM'),
           ])
    
    ##########################################################################
    # Diffusion Parameters
    ##########################################################################
    pars = SinusoidalUnit.pars 
    pars.extend(
            # diffusion constants [m^2/s]
            [
            ('DrbcM',  0.0E-12, 'm2_per_s', 'True'),
            ('Dsuc',   720E-12, 'm2_per_s', 'True'),
            ('Dalb',    90E-12, 'm2_per_s', 'True'),
            ('Dgal',   910E-12, 'm2_per_s', 'True'),
            ('DgalM',  910E-12, 'm2_per_s', 'True'),
            ('Dh2oM', 2200E-12, 'm2_per_s', 'True'),
            ])
    names['DrbcM'] = 'diffusion constant rbc M*'
    names['Dsuc'] = 'diffusion constant sucrose'
    names['Dalb'] = 'diffusion constant albumin'
    names['Dgal'] = 'diffusion constant galactose'
    names['DgalM'] = 'diffusion constant galactose M*'
    names['Dh2oM'] = 'diffusion constant water M*'
    
    ##########################################################################
    # Additional Parameters
    ##########################################################################
    pars.append( ('gal_challenge',  0.0,    'mM',    True) )
    
    
##########################################################################
if __name__ == "__main__":
    ''' 
    Create the various SinusoidalUnit models, i.e. the different
    model types based on the defined timecourse events.
    '''
    from sim.PathSettings import SBML_DIR    
    from creator.models.GalactoseCell import GalactoseCell
    from creator.events.EventFactory import createDilutionEventData, createGalactoseChallengeEventData
    from creator.events.EventFactory import createGalactoseStepEventData
    from SinusoidalUnit import storeInDatabase

    # Create the general model information 
    SinusoidalUnit.Nc = 1
    SinusoidalUnit.version = 17
    cellModel = GalactoseCell()
    
    # [1] core model
    gm = SinusoidalUnit(cellModel, simId='core', events=None)
    gm.createModel()
    gm.writeSBML(SBML_DIR)    
    storeInDatabase(gm, SBML_DIR)
    
    
    # [2] multiple dilution indicator
    # ___|---|__ (in all periportal species)
    # The multiple dilution indicator peak comes when the system is 
    # in steady state after the applied initial condition changes:
    events = createDilutionEventData(tp_start=1000.0, duration=0.5)
    gm = SinusoidalUnit(cellModel, simId="dilution", events=events)
    gm.createModel()
    gm.writeSBML(SBML_DIR)    
    storeInDatabase(gm, SBML_DIR)
    
    # [3] galactose challenge (with various galactose)
    # __|------
    events = createGalactoseChallengeEventData(tc_start=100.0)
    gm = SinusoidalUnit(cellModel, simId="galactose-challenge", events=events)
    gm.createModel()
    gm.writeSBML(SBML_DIR)    
    storeInDatabase(gm, SBML_DIR)
    
    # [4] galactose step (with various galactose)
    # __|------
    events = createGalactoseStepEventData()
    gm = SinusoidalUnit(cellModel, simId="galactose-step", events=events)
    gm.createModel()
    gm.writeSBML(SBML_DIR)    
    storeInDatabase(gm, SBML_DIR)

##########################################################################