"""
Get the additional information via a MIRIAM Rest Web Service.

An API that adheres to the principles of REST does not require the client to know
anything about the structure of the API. Rather, the server needs to provide whatever
information the client needs to interact with the service.

MIRIAM WebInterface
    /datatypes/: retrieves the list of all available datatypes
    /datatypes/$id: retrieves the datatype identified by $id (for example: MIR:00000008)
    /resolve/$urn: resolves the given MIRIAM URN (for example: urn:miriam:uniprot:P62158)
    /version: displays the current version of the services

The schema of the XML response is the same as the one used for the XML export of MIRIAM Resources,
and is available at: http://www.ebi.ac.uk/miriam/main/export/xml

Use the requests package & xml.etree
    http://isbullsh.it/2012/06/Rest-api-in-python/


TODO: update the miriam REST scripts

@author: Matthias Koenig
@date: 2014-05-26
"""
from xml.etree import ElementTree
import xml.dom.minidom as minidom
import requests
import pickle

MIRIAM_REST = 'http://www.ebi.ac.uk/miriamws/main/rest/'


def pretty_xml(element):
    """ Return a pretty-printed XML string for the Element. """
    rough_string = ElementTree.tostring(element, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="\t")


def get_miriam_datatypes():
    """ Creates the dictionary of Miriam datatypes. """
    datatypes = dict()
    
    r = requests.get(MIRIAM_REST + 'datatypes/')    
    doc = ElementTree.fromstring(r.text)
    # print pretty_xml(doc)
    for n in doc.findall('datatype'):
        dt_id = n.find('id').text
        name = n.find('name').text
        datatypes[dt_id] = name
    return datatypes


def create_miriam_urn_pickle(fname):
    datatypes = get_miriam_datatypes()
    _, uri_dict = get_miriam_resources_for_datatypes(datatypes.keys())
    with open(fname, 'wb') as handle:
        pickle.dump(uri_dict, handle)


def get_miriam_resources_for_datatypes(ids, debug=False):
    """ Get resources for given datatypes """
    res_dict = dict()
    uri_dict = dict()
    for key in ids:
        resources, uris = get_miriam_resources_for_datatype(key, debug)
        res_dict[key] = resources
        for uri in uris:
            uri_dict[uri] = resources 
    return res_dict, uri_dict


def get_miriam_resources_for_datatype(dt_id, debug=False):
    """ Returns dictionary of resources for the given datatype. """
    r = requests.get(MIRIAM_REST + 'datatypes/' + dt_id + '/')
    doc = ElementTree.fromstring(r.text)
    if debug:
        print pretty_xml(doc)
    resources = []
    for n in doc.iter('resource'):
        resource = dict()
        resource['id'] = n.attrib['id']
        resource['dataEntry'] = n.find('dataEntry').text
        resources.append(resource)
    # select all uris of type URN
    uris = []
    for n in doc.iter('uri'):
        
        if n.attrib['type'] == 'URN':
            uris.append(n.text)
    return resources, uris
