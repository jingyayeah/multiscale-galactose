'''
Annotating SBML models.

 ModelHistory * h = new ModelHistory();
ModelCreator *c = new ModelCreator();
c->setFamilyName("Keating");
c->setGivenName("Sarah");
c->setEmail("sbml-team@caltech.edu");
c->setOrganization("University of Hertfordshire");
int status = h->addCreator(c);
printStatus("Status for addCreator: ", status);
Date * date = new Date("1999-11-13T06:54:32");
Date * date2 = new Date("2007-11-30T06:54:00-02:00");
status = h->setCreatedDate(date);
printStatus("Set created date: ", status);
status = h->setModifiedDate(date2);
printStatus("Set modified date: ", status);
status = d->getModel()->setModelHistory(h);
printStatus("Set model history: ", status);




@author: Matthias Koenig
@date: 2014-05-30
'''
import libsbml

class Annotation(object):
    
    def __init__(self, d):
        self.id = d['id'];
        self.sbml_type = d['sbml_type'];
        self.annotation_type = d['annotation_type'];
        self.qualifier = d['qualifier'];
        self.collection = d['collection'];
        self.entity = d['entity'];
    
    def printAnnotation(self):
        print ("{:<20}"*6).format(self.id, self.sbml_type, self.annotation_type, 
                                  self.qualifier, self.collection, self.entity)


class Annotator(object):
    
    def __init__(self, model, annotations):
        self.model = model
        self.annotations = annotations
        self.id_dict = self.getIdsFromModel()
        
    def getIdsFromModel(self):
        '''
        Creates the ids dictionary for the model for easy retrieval.
        '''
        id_dict = dict()
        id_dict['model'] = [ self.model.getId() ]
    
        lof = self.model.getListOfCompartments()
        if (lof):
            id_dict['compartment'] = [item.getId() for item in lof]
    
        lof = self.model.getListOfSpecies()
        if (lof):
            id_dict['species'] = [item.getId() for item in lof]
            
        lof = self.model.getListOfParameters()
        if (lof):
            id_dict['parameter'] = [item.getId() for item in lof]
            
        lof = self.model.getListOfReactions()
        if (lof):
            id_dict['reaction'] = [item.getId() for item in lof]

        lof = self.model.getListOfEvents()
        if (lof):
            id_dict['event'] = [item.getId() for item in lof]
            
        return id_dict

    def annotateModel(self):
        '''
        Annotates the model with the given annotations.
        Returns the annotated model.
        '''
        for a in annotations:
            pattern = a.id
            ids = self.id_dict[a.sbml_type]
            mids = getMatchingIds(ids, pattern)
            self.annotateComponents(mids, a)
        return self.model

    def annotateComponents(self, mids, a):
        '''
        Annotate components 
        '''
        print '-'*60
        for mid in mids:
            element = self.model.getElementBySId(mid)
            if (element == None):
                if (mid == self.model.getId()):
                    element = self.model
                else:
                    print "Element could not be found"
                    continue
            
            if (a.annotation_type == 'SBO'):
                print 'SBO:', mid, element
                element.setSBOTerm(int(a.entity))
            elif (a.annotation_type == 'RDF'):
                addRDFAnnotationToElement(element, a.qualifier, a.collection, a.entity)
                print 'RDF:', mid, element
            else:
                print 'Annotation type not supported: ', a.annotation_type
        print '-'*60

def addRDFAnnotationToElement(element, qualifier, collection, entity):
    cvterm = libsbml.CVTerm()
    if (qualifier.startswith('BQB')):
        cvterm.setBiologicalQualifierType(qualifier)
    elif (qualifier.startswith('BQM')):
        cvterm.setModelQualifierType(qualifier)
    else:
        print "Unsupported qualifier:", qualifier
    
    resource = ''.join(['http://identifiers.org/', collection, '/', entity])
    cvterm.addResource(resource)
    
    # metaid has to be set
    # libsbml.Model.setMetaId(self)
    
    element.addCVTerm(cvterm)

def readAnnotationsFromFile(filename, sep='\t'):
    '''
    Reads the annotations into an iteratable annotation data structure.
    '''
    res = []
    count = 0;
    with open(filename, 'r') as f:
        for line in f:
            if (count == 0):
                header = line.split(sep)
                header = [item.strip() for item in header]
            else:
                items = line.split(sep)
                if len(items) != len(header):
                    print 'wrong number of items'
                    continue
                elif (items[0].startswith('#') | len(items[0]) == 0):
                    print 'empty line'
                    continue
                else:
                    d = dict()
                    for k in xrange(len(items)):
                        d[header[k]] = items[k].strip()
                    a = Annotation(d)
                    if a:
                        res.append(a)    
            count = count + 1
    f.close()
    return res

def getMatchingIds(ids, pattern):
    '''
    Finds the model ids based on the regular expression pattern
    and the sbml_type.
    '''    
    import re
    mids = []
    for string in ids:
        match = re.match(pattern, string)
        if (match):
            print 'Match: ', pattern, '<->', string
            mids.append(string)
    return mids
    
    


if __name__ == "__main__":
    # read SBML model
    
    sbml = 'examples/Koenig2014_demo_kinetic_v7.xml'
    doc = libsbml.readSBML(sbml)
    model = doc.getModel()
    print model
    print model.getId()
    
    # Read annotation file
    afile = 'examples/Koenig2014_demo_kinetic_v7_annotations.csv'
    
    annotations = readAnnotationsFromFile(afile)
    print '*' * 60
    print(annotations)
    for a in annotations:
        a.printAnnotation()
    
    res = model.getElementBySId(model.getId())
    print res

    
    # Annotate the model
    print '#'*60
    ar = Annotator(model, annotations)
    ar.annotateModel()
    
    
    # model.setSBOTerm(11)
    cv1 = libsbml.CVTerm();
    cv1.setQualifierType(libsbml.BIOLOGICAL_QUALIFIER);
    cv1.setBiologicalQualifierType(libsbml.BQB_IS_VERSION_OF);
    cv1.addResource("http://www.ebi.ac.uk/interpro/#IPR002394");
    model.addCVTerm(cv1);
    
    
    
    
    # c = model.getCompartment('outside')
    # c.setSBOTerm(12)
    # c2 = model.getElementBySId('inside')
    # c2.setSBOTerm(13)
    xml = libsbml.writeSBMLToFile(doc, 'test_annotated.xml')
    # hashlib.sha1(str(a)).hexdigest()
    
    
    
    
    # xml = libsbml.writeSBMLToString(doc)
    # print xml
    # Write the annotated model
    
    