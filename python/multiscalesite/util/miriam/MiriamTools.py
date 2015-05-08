'''
Created on May 28, 2014

@author: mkoenig
'''


import pickle
with open('data/miriam.pickle', 'rb') as handle:
    uri_dict = pickle.load(handle)


def handleSBMLAnnotation(annotation):
    pass
    for key in uri_dict.keys()[0:20]:
        print key
        
        


if __name__ == "__main__":
    import libsbml
    sbml = 'data/Koenig2014_Hepatic_Glucose_Model_annotated.xml'
    doc = libsbml.readSBML(sbml)
    model = doc.getModel()
    print model
    print model.getId()
    
    
    # handleSBMLAnnotation(annotation)