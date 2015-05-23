"""
Definition of ids and names for objects
in the metabolic networks.
General helper functions to work with the naming.

"""

def initString(string, initDict):
    ''' Initializes the string with the given data dictionary. 
        Makes a copy to allow multiple initializations with 
        differing data.
    '''
    if not isinstance(string, str):
        return string
    
    res = string[:]
    for key, value in initDict.iteritems():
        res = res.replace(key, value)
    return res


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
def getCytosolId(k):
    return 'C{:0>2d}'.format(k)

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
def getCytosolName(k):
    return '[{}] cytosol'.format(getCytosolId(k))



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
def getCytosolSpeciesId(sid, k):
    return createLocalizedId(getCytosolId(k), sid)

def createLocalizedId(cid, sid):
    return SEPARATOR.join([cid, sid])

def isPPSpeciesId(sid):
    return sid.startswith(getPPId() + SEPARATOR)
def isPVSpeciesId(sid):
    return sid.startswith(getPVId() + SEPARATOR)


def getPPSpeciesName(name):
    return '[{}] {}'.format(getPPId(), name)
def getPVSpeciesName(name):
    return '[{}] {}'.format(getPVId(), name)
def getSinusoidSpeciesName(name, k):
    return '[{}] {}'.format(getSinusoidId(k), name)
def getDisseSpeciesName(name, k):
    return '[{}] {}'.format(getDisseId(k), name)
def getHepatocyteSpeciesName(name, k):
    return '[{}] {}'.format(getHepatocyteId(k), name)
def getCytosolSpeciesName(name, k):
    return '[{}] {}'.format(getHepatocyteId(k), name)


def getTemplateId(pid, sid1, sid2):
    if not sid2:
        # returns the midpoint position id of the volume
        return '{}_{}'.format(sid1, pid)
    else:
        # returns the between position id for two volumes
        return '{}{}_{}'.format(sid1, sid2, pid)

# Parameters (position, pressure, flow)
def getPositionId(sid1, sid2=None):
    return getTemplateId('x', sid1, sid2)
    
def getPressureId(sid1, sid2=None):
    return getTemplateId('P', sid1, sid2)
        
def getqFlowId(sid1, sid2=None):
    return getTemplateId('q', sid1, sid2)
    
def getQFlowId(sid1, sid2=None):
    return getTemplateId('Q', sid1, sid2)
    

# Reactions
def createFlowId(c_from, c_to, sid):
    return 'F_{}{}_{}'.format(c_from, c_to, sid)

def createFlowName(c_from, c_to, sid):
    if c_to == NONE_ID:
        c_to = ''
    return '[{} -> {}] convection {}'.format(c_from, c_to, sid)

def createDiffusionId(c_from, c_to, sid):
    return 'D_{}{}_{}'.format(c_from, c_to, sid)

def createDiffusionName(c_from, c_to, sid):
    if c_to == NONE_ID:
        c_to = ''
    return '[{} <-> {}] diffusion {}'.format(c_from, c_to, sid)
