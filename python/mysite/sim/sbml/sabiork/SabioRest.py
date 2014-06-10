'''
Get SabioRK data from the webinterface.

Created on May 28, 2014

@author: mkoenig
'''
from xml.etree import ElementTree
from xml.etree.ElementTree import Element
from xml.etree.ElementTree import SubElement
import xml.dom.minidom as minidom
import requests, json
import pickle
from libsbml import SBMLDocument

SABIO_REST = 'http://sabiork.h-its.org/sabioRestWebServices/'

def prettyXML(element):
    '''
    Return a pretty-printed XML string for the Element.
    '''
    rough_string = ElementTree.tostring(element, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="\t")


def getSabioXMLForUniprot(uniprot):
    r = requests.get(''.join([SABIO_REST, 'searchKineticLaws/sbml?q=UniProtKB_AC:"', str(uniprot), '"']))
    xml = ElementTree.fromstring(r.text) 
    return xml

def getSabioCountForUniprot(uniprot):
    search = ''.join([SABIO_REST, 'searchKineticLaws/count?q=UniProtKB_AC:"', str(uniprot), '"'])
    print search
    r = requests.get(search)
    count = int(r.text)
    return count

def getSabioEntryIDsForUniprot(uniprot):
    search = ''.join([SABIO_REST, 'searchKineticLaws/entryIDs?q=UniProtKB_AC:"', str(uniprot), '"'])
    print search
    r = requests.get(search)
    doc = ElementTree.fromstring(r.text) 
    return [n.text for n in doc.findall( 'SabioEntryID' )]

    
def getQueryFields():
    return getSabioFields('searchKineticLaws')

def getSuggestionFields():
    return getSabioFields('suggestions')

def getSabioFields(adress):
    r = requests.get(SABIO_REST + adress)    
    doc = ElementTree.fromstring(r.text)
    # print prettyXML(doc)
    return [n.text for n in doc.findall( 'field' )]

def printQueryFields():
    fields = getQueryFields()
    printFields('queryFields', fields)

def printSuggestionFields():
    fields = getSuggestionFields()
    printFields('suggestions', fields)
    

def printFields(title, fields):
    fields.sort()
    print '#'*40
    print '  SABIO-RK ' + title
    print '#'*40
    for field in fields:
        print field
    print '\n'    

def getKineticLaw(entry_id):
    r = requests.get(''.join([SABIO_REST, 'kineticLaws/', str(entry_id)]))
    xml = ElementTree.fromstring(r.text) 
    return xml

def getUniprotsFromSBML(filename):
    '''
    XML with namespaces is completely fucked. Combine it with RDF and you will never
    get the information out again. This examplifies what is wrong with the Bioinformatics 
    Community.
    I want to do something simple, but became a computational nightmare.
    At this point just fuck it.
    
    Okay, seems imposible. So have to use a RDF library to parse the RDF parts.
    '''
    # <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000289"/>
    # all CVterms which contain 'uniprot'    
    # Get all the cvterms for all elements ad search for uniprot ids
    
    uniprots = []
    
#     tree = ElementTree.parse(filename)
#     for elem in tree.getiterator():
#         print elem.tag, elem.attrib
#     root = tree.getroot()
#     
#     print '#'*50
#     # print root.tag
#     # namespaces are fucked up
#     rdfs =  tree.findall('//{http://www.w3.org/1999/02/22-rdf-syntax-ns#}li')
#     resources = []
#     for n in rdfs:
#         print n.attrib
#         print n.attrib['{http://www.w3.org/1999/02/22-rdf-syntax-ns#}parseType']
    from lxml import etree
    tree = etree.parse(filename)
    root = tree.getroot()
    res = tree.findall('//{http://www.w3.org/1999/02/22-rdf-syntax-ns#}li')
    ns = '{http://www.w3.org/1999/02/22-rdf-syntax-ns#}'
    rdf_nodes = tree.findall('//{ns}RDF'.format(ns=ns))
    for rdf_n in rdf_nodes:
        print rdf_n, rdf_n.attrib
        
        rdf_tree = etree.ElementTree(rdf_n)
        rdf_str = etree.tostring(rdf_tree)
    
        
        # TODO: handle the RDF properly
        #import rdflib
        #graph = rdflib.Graph()
        #print rdf_str
        #graph.parse(data=rdf_str)

        #for s, p, o in graph:
        #    print s, p, o

        #return uniprots
    


SBML_FOLDER = "/home/mkoenig/multiscale-galactose-results/tmp_sbml"
import sys
import os
sys.path.append('/home/mkoenig/multiscale-galactose/python')
os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

import libsbml

if __name__ == "__main__":
    # available Sabio search fields
    printQueryFields();
    printSuggestionFields()
    
    # get kineticEntry in SBML format
    entry_id = 123
    xml = getKineticLaw(entry_id)
    # print prettyXML(xml)
    
    uniprots = ['P07902', 'Q14376']
    
    ####

    
    from sim.models import SBMLModel
    mg_model = SBMLModel.objects.get(pk=12)
    filename = str(mg_model.file.path)
    print filename
    
    doc = libsbml.readSBML(filename)
    model = doc.getModel()
    
    uniprots = getUniprotsFromSBML(filename)
    print uniprots
    
    sabio_dict = dict()
    for uniprot_id in uniprots:
        count = getSabioCountForUniprot(uniprot_id)
        print count
        entry_ids = getSabioEntryIDsForUniprot(uniprot_id)
        sabio_dict[uniprot_id] = entry_ids
    
    for key, value in sabio_dict.iteritems():
        print key, ' : ', value
    
