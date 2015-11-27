# -*- coding: utf-8 -*-
"""
Adding history information to SBML file based on list of creators.
"""
from libsbml import *

from SBMLUtils import check
from multiscale.modelcreator.annotation.annotation import create_meta_id


def set_model_history(model, creators):
    if not model.isSetMetaId():
        model.setMetaId(create_meta_id(model.getId()))      
    
    # set history
    h = create_history(creators)
    check(model.setModelHistory(h), 'set model history')


def create_history(creators):
    h = ModelHistory()

    # add all creators
    for creator in creators.itervalues():
        c = ModelCreator()
        c.setFamilyName(creator['FamilyName'])
        c.setGivenName(creator['GivenName'])
        c.setEmail(creator['Email'])
        c.setOrganization(creator['Organization'])
        check(h.addCreator(c), 'add creator')

    # create time is now
    date = date_now()
    check(h.setCreatedDate(date), 'set creation date')
    check(h.setModifiedDate(date), 'set creation date')
    return h


def date_now():
    import datetime
    time = datetime.datetime.now()
    timestr = time.strftime('%Y-%m-%dT%H:%M:%S')
    return Date(timestr)
