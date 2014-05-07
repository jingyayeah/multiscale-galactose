import libxml2
import sys 

doc = libxml2.parseFile('/home/mkoenig/glucose-model/sbml/Koenig2014_Hepatic_Glucose_Model.xml')

for url in doc.xpathEval('//@id'):
    print url.content
print '-'*20
for url in doc.xpathEval('/sbml/model/listOfSpecies/species/@id'):
    print url