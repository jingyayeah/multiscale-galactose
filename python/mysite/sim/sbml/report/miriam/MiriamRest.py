'''
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


@author: Matthias Koenig
@date: 2014-05-26
'''
from xml.etree import ElementTree
from xml.etree.ElementTree import Element
from xml.etree.ElementTree import SubElement
import xml.dom.minidom as minidom
import requests, json

MIRIAM_REST = 'http://www.ebi.ac.uk/miriamws/main/rest/'

def prettyXML(element):
    '''
    Return a pretty-printed XML string for the Element.
    '''
    rough_string = ElementTree.tostring(element, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="\t")


def getMiriamDatatypes():
    '''
    Creates the dictionary of Miriam datatypes.
    '''
    datatypes = dict()
    
    r = requests.get(MIRIAM_REST + 'datatypes/')    
    doc = ElementTree.fromstring(r.text)
    # print prettyXML(doc)
    for n in doc.findall( 'datatype' ):
        dt_id = n.find('id').text
        name = n.find('name').text
        datatypes[dt_id] = name
    return datatypes


def getMiriamResourcesForDatatypes(ids):
    '''
    Get resources for given datatypes
    '''
    res_dict = dict()
    uri_dict = dict()
    for key in ids:
        resources, uris = getMiriamResourcesForDatatype(key)
        res_dict[key] = resources
        for uri in uris:
            uri_dict[uri] = resources 
    return res_dict, uri_dict


def getMiriamResourcesForDatatype(dt_id):
    '''
    Returns dictionary of resources for the given datatype.
    '''
    r = requests.get(MIRIAM_REST + 'datatypes/' +dt_id + '/')
    doc = ElementTree.fromstring(r.text)
    print prettyXML(doc)
    resources = []
    for n in doc.iter( 'resource' ):
        resource = dict()
        resource['id'] = n.attrib['id']
        resource['dataEntry'] = n.find('dataEntry').text
        resources.append(resource)
    uris = []
    for n in doc.iter( 'uri' ):
        uris.append(n.text)
    return resources, uris


def test():
    url = "http://www.ebi.ac.uk/miriamws/main/rest/"
    r = requests.get(url)
    print r
    print r.status_code
    print r.headers
    print r.headers['content-type']
    print r.encoding
    print r.text
    print '#'*60
    
    # Get the json
    url = 'http://www.ebi.ac.uk/miriamws/main/rest/datatypes/'
    headers = {'Accept': 'application/json'}
    r = requests.get(url, headers=headers)
    print r
    print r.headers['content-type']
    print r.text
    print r.json()


if __name__ == '__main__':
    # Get resources for datatype
    resources, uris = getMiriamResourcesForDatatype('MIR:00000352')
    print resources
    print uris

    # Get all datatypes    
    datatypes = getMiriamDatatypes()
    print '#'*60
    for key, value in datatypes.iteritems():
        print key, ' : ', value
    print '#'*60
    
    ids = datatypes.keys()[0:5]
    res_dict, uri_dict = getMiriamResourcesForDatatypes(ids)
    for key, value in res_dict.iteritems():
        print key, ':', value
    print '#'*60
    for key, value in uri_dict.iteritems():
        print key, ':', value

    
    # Store everything in simple NOSQL database