'''
Created on May 30, 2014

@author: mkoenig
'''

class Annotation(object):
    
    def __init__(self, d):
        self.id = d['id'];
        self.sbml_type = d['sbml_type'];
        self.annotation_type = d['annotation_type'];
        self.qualifier = d['qualifier'];
        self.collection = d['collection'];
        self.entity = d['entity'];
    
    def printAnnotation(self):
        print self.id, self.sbml_type, self.annotation_type, self.qualifier, self.collection, self.entity
    

def readAnnotationsFromFile(filename, sep='\t'):
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

def annotateModel(model, annotations):
    for a in annotations:
        annotateComponent(model, a)
        
def annotateComponent(model, a):
    ids = getModelIds(a.id, a.sbml_type)
    
    # do the annotation (switch SBO and RDF)

def getModelIds(model, pattern, sbml_type):
    
    
    


if __name__ == "__main__":
    # read SBML model
    import libsbml
    sbml = 'examples/Koenig2014_demo_kinetic_v7.xml'
    doc = libsbml.readSBML(sbml)
    model = doc.getModel()
    print model
    print model.getId()
    
    # Read annotation file
    afile = 'examples/Koenig2014_demo_kinetic_v7.csv'
    
    annotations = readAnnotationsFromFile(afile)
    print '*' * 60
    print(annotations)
    for a in annotations:
        a.printAnnotation()
    
    # Annotate the model
    annotateModel(model, annotations)