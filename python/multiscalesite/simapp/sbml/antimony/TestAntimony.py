'''
Simple example for the usage of the pyton libantimony bindings.

@author: Matthias Koenig
@date: 2014-06-05
'''

import libantimony
print libantimony.LIBANTIMONY_VERSION_STRING

model_str = '''
# Simple UniUni reaction with first-order mass-action kinetics
model example1
  S1 -> S2; k1*S1
  S1 = 10
  S2 = 0
  k1 = 0.1
end
'''

# Load the model string in libantimony
res = libantimony.loadAntimonyString(model_str)
if (res == -1):
    print libantimony.getLastError()

# SBML is created based on module name
module_name = libantimony.getMainModuleName()
print libantimony.getSBMLString(module_name)