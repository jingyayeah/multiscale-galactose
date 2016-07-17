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


#############################
# Pressure model
#############################
# Helper functions for getting the capillary flow and pressure profiles.

def get_P(gp):
    """ Get DataFrame of local pressures in sinusoid.

    The global parameter dataframe gp is used to lookup the values.
    Information from global parameters only valid if the
    calculated values are stationary.

    :param gp: global parameter DataFrame
    :type gp: DataFrame
    :return:
    :rtype:
    """
    Nc = get_Nc(gp)

    # get the ids of volumes
    ids = [naming.getPPId()] + [naming.getSinusoidId(k) for k in range(1, Nc+1)] + [naming.getPVId()]

    # get pressure and position
    x_ids = [naming.getPositionId(sid) for sid in ids]
    P_ids = [naming.getPressureId(sid) for sid in ids]

    # first get the DataSeries, than the numpy values
    return DataFrame({'x': gp.ix[x_ids].value.values,
                      'P': gp.ix[P_ids].value.values}, index=x_ids)


def get_Q(gp):
    """ Get DataFrame of local flows in sinusoid.

    Calculated on midpoints between volumes.
    """
    Nc = get_Nc(gp)

    # PP
    pp_id = naming.getPPId()
    x_ids = [naming.getPositionId(pp_id)]
    Q_ids = [naming.getQFlowId(pp_id)]

    # along sinusoid
    for k in range(1, Nc):
        sid1 = naming.getSinusoidId(k)
        sid2 = naming.getSinusoidId(k+1)
        x_ids.append(naming.getPositionId(sid1, sid2))
        Q_ids.append(naming.getQFlowId(sid1, sid2))

    # PV
    pv_id = naming.getPVId()
    x_ids.append(naming.getPositionId(pv_id))
    Q_ids.append(naming.getQFlowId(pv_id))

    # first get the DataSeries, than the numpy values
    return DataFrame({'x': gp.ix[x_ids].value.values,
                      'Q': gp.ix[Q_ids].value.values}, index=x_ids)


def get_q(gp):
    """ Get DataFrame of pore flow in sinusoid.

    :param gp: global parameter DataFrame
    :type gp: DataFrame
    :return:
    :rtype:
    """
    Nc = get_Nc(gp)

    # get the ids of volumes
    ids = [naming.getSinusoidId(k) for k in range(1, Nc+1)]

    # get pressure and position
    x_ids = [naming.getPositionId(sid) for sid in ids]
    q_ids = [naming.getqFlowId(sid) for sid in ids]

    # first get the DataSeries, than the numpy values
    return DataFrame({'x': gp.ix[x_ids].value.values,
                      'q': gp.ix[q_ids].value.values}, index=x_ids)
