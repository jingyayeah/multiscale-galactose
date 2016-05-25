"""
Helper tools to access sinusoidal unit information.

Simulation tool to create the matrices from the resulting odesim.
The provided functions recreate matrices and arrows lost in the SBML
encoding for easier analysis.
"""


from sbmlutils.modelcreator.factory import sinnaming as naming
from pandas import DataFrame, Series


# TODO: get sinusoidal ids for given species
# TODO: get disse ids for given species
# TODO: get hepatocye ids for given species
# TODO: get the indices in the the respective r.timeCourseSelection, for
#       creating the subsets of solution matrices


class IdResolver(object):
    """ Helper class to resolve ids. """

    def __init__(self, selections, Nc):
        """ The selection and number of cells are required. """
        self.indices = dict(zip(selections, range(len(selections))))
        self.Nc = Nc

    def _compartment_ids(self, id_function, sid, concentration=True):
        ids = [id_function(sid, k) for k in range(1, int(self.Nc+1))]
        # only in the case of concentrations the additional brackets are needed
        if concentration:
            ids = ['[{}]'.format(s) for s in ids]
        return ids

    def sinusoidal_ids(self, sid, concentration=True):
        """ Get sinusoidal amount/concentration ids. """
        return self._compartment_ids(id_function=naming.getSinusoidSpeciesId, sid=sid,
                                     concentration=concentration)

    def disse_ids(self, sid, concentration=True):
        """ Get disse amount/concentration ids. """
        return self._compartment_ids(id_function=naming.getDisseSpeciesId, sid=sid,
                                     concentration=concentration)

    def pp_id(self, sid, concentration=True):
        """ Get periportal amount/concentration ids. """
        pp_id = naming.getPPSpeciesId(sid)
        if concentration:
            pp_id = '[{}]'.format(pp_id)
        return pp_id

    def pv_id(self, sid, concentration=True):
        pv_id = naming.getPVSpeciesId(sid)
        if concentration:
            pv_id = '[{}]'.format(pv_id)
        return pv_id

    def find_indices(self, ids):
        """ Resolve the indices in the timeCourseSelection for given ids.

        :param ids:
        :type ids:
        :return:
        :rtype:
        """
        return [self.indices[token] for token in ids]


def get_ids_from_selection(name, selections, comp_type='H'):
    """ Returns list of ids in selection for given name. """
    ids = [item for item in selections if ( (item.startswith('[{}'.format(comp_type)) | item.startswith(comp_type))
                                    & (item.endswith('__{}]'.format(name)) | item.endswith('__{}'.format(name))) )]
    if len(ids) == 0:
        ids = [name, ]
    return ids



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
