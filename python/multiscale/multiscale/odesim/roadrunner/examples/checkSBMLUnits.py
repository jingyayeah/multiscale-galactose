"""
Created on Apr 15, 2015

@author: mkoenig
"""



from libsbml import *
doc = SBMLReader().readSBML('test.xml')
m = doc.getModel()


units = ['mmHg', 'Pa_per_mmHg', 'Pa_per_s']
parameters = ['conv', 'k1', 'P', 'w']
for sid in units:
    print '*'*3, sid, '*'*3
    udef = m.getUnitDefinition(sid)
    print UnitDefinition_printUnits(udef), ' => '    
    UnitDefinition_reorder(udef)
    print '\t\t', UnitDefinition_printUnits(udef)
    print

print '#'*80

for sid in parameters:
    print '*'*3, sid, '*'*3
    udef = m.getParameter(sid).getDerivedUnitDefinition()
    
    print UnitDefinition_printUnits(udef), ' => '    
    UnitDefinition_reorder(udef)
    print '\t\t', UnitDefinition_printUnits(udef)
    print

print '#'*80

# k1 has suddenly completely different units depending if parameter
# or initialassignment
udef = m.getParameter('k1').getDerivedUnitDefinition()
UnitDefinition_reorder(udef)
print UnitDefinition_printUnits(udef)

udef = m.getInitialAssignment('k1').getDerivedUnitDefinition()
UnitDefinition_reorder(udef)
print UnitDefinition_printUnits(udef)