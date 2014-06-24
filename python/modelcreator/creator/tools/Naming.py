'''
Definition of ids and names for objects
in the metabolic networks.

Created on Jun 19, 2014
@author: mkoenig
'''

# Compartments
def getPPId():
    return 'PP'
def getPVId():
    return 'PV'
def getSinusoidId(k):
    return 'S{:0>2d}'.format(k)
def getDisseId(k):
    return 'D{:0>2d}'.format(k)
def getHepatocyteId(k):
    return 'H{:0>2d}'.format(k)

def getPPName():
    return '[{}] periportal'.format(getPPId())
def getPVName():
    return '[{}] perivenious'.format(getPVId())
def getSinusoidName(k):
    return '[{}] sinusoid'.format(getSinusoidId(k))
def getDisseName(k):
    return '[{}] disse'.format(getDisseId(k))
def getHepatocyteName(k):
    return '[{}] hepatocyte'.format(getHepatocyteId(k))

# Species
SEPARATOR = "__"
NONE_ID = 'NONE'

def getPPSpeciesId(sid):
    return createLocalizedId(getPPId(), sid)
def getPVSpeciesId(sid):
    return createLocalizedId(getPVId(), sid)
def getSinusoidSpeciesId(sid, k):
    return createLocalizedId(getSinusoidId(k), sid)
def getDisseSpeciesId(sid, k):
    return createLocalizedId(getDisseId(k), sid)
def getHepatocyteSpeciesId(sid, k):
    return createLocalizedId(getHepatocyteId(k), sid)

def createLocalizedId(cid, sid):
    return SEPARATOR.join([cid, sid])

def getPPSpeciesName(name):
    return '[{}] {}'.format(getPPId(), name)
def getPVSpeciesName(name):
    return '[{}] {}'.format(getPVId(), name)
def getSinusoidSpeciesName(name, k):
    return '[{}] {}'.format(getSinusoidId(k), name)
def getDisseSpeciesName(name, k):
    return '[{}] {}'.format(getDisseId(k), name)
def getHepatocyteSpeciesName(name, k):
    return createLocalizedId(getHepatocyteId(k), name)

# Reactions
def createFlowId(c_from, c_to, sid):
    return 'Flow{}{}_{}'.format(c_from, c_to, sid)

def createFlowName(c_from, c_to, sid):
    if c_to == NONE_ID:
        c_to = ''
    return '[{} -> {}] convection {}'.format(c_from, c_to, sid)

def createDiffusionId(c_from, c_to, sid):
    return 'Diff{}{}_{}'.format(c_from, c_to, sid)

def createDiffusionName(c_from, c_to, sid):
    if c_to == NONE_ID:
        c_to = ''
    return '[{} <-> {}] diffusion {}'.format(c_from, c_to, sid)
