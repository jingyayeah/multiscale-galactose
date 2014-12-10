'''
Created on Dec 7, 2014

@author: mkoenig
'''

import numpy
import roadrunner
from roadrunner import SelectionRecord
from roadrunner.roadrunner import Logger
print roadrunner.__version__

import antimony

roadrunner.Config.setValue(roadrunner.Config.LLVM_SYMBOL_CACHE, True)

model_txt = """
    model test()
    // Reactions
    J0: S1 + S2 -> $S3; K3 * S1 * S2;

    // Species initializations:
    S1 = 1;

    // S2 init conditions is specified by the rule of K1 + K2;
    S2 = K1 + K2;
    S3 = 0;


    // Variable initialization:
    K1 = 1;
    K2 = 2;
    K3 = 0.1;
    K4 = K1 + K2;   # K4 has an initial assignment, only active at init or reset time.
    K5 := K1 + K2;  # K5 is defined by a rule, this is always active
    K6 = 2*K4;      # going a level deeper
    end
"""
model = antimony.loadString(model_txt)
antimony.writeSBMLFile('test.xml', 'test')

sbml_file = 'test.xml'
r = roadrunner.RoadRunner(sbml_file)
r.model.items()
r.selections = ['time'] + r.model.getBoundarySpeciesIds() + r.model.getFloatingSpeciesIds() 


r.K1 = 10
r.K2 = 11
r.model.items()

# reset with default args does NOT change any parameters, users would want to manually change params to see
# how the model is effected, so default reset should not change these
r.reset() 
r.model.items()

# new optional arg invokes the global param init assignment rules
r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
r.model.items()
r.S1 = 10
r.model.items()
r.K1 = 0
r.model.items()
r.reset(SelectionRecord.INITIAL_GLOBAL_PARAMETER)
r.model.items()

print r.simulate(plot=True)


# Additional information
S = r.getFullStoichiometryMatrix()
print S
C = r.getConservationMatrix()
print C

####

# 
r.steadyState()
# RuntimeError: Jacobian matrix singular in NLEQ
r.getSteadyStateValues()
# RuntimeError: Jacobian matrix singular in NLEQ

r.getCC('J0', 'K3')
# Warning: Conserved Moiety Analysis is not enabled, steady state may fail with singular Jacobian
# Warning: Conserved Moiety Analysis may be enabled via the conservedMoeityAnalysis property or via the configuration file or the Config class setValue, see roadrunner documentation
# Error: Error :Jacobian matrix singular in NLEQ

r.getFullJacobian()
# RuntimeError: could not set value for S2, it is defined by an initial assignment rule and can not be set independently., at int rrllvm::LLVMExecutableModel::setValues(bool (*)(rrllvm::LLVMModelData*, int, double), rrllvm::LLVMExecutableModel::GetNameFuncPtr, int, const int*, const double*)
r.getFullEigenvalues()
# RuntimeError: could not set value for S2, it is defined by an initial assignment rule and can not be set independently., at int rrllvm::LLVMExecutableModel::setValues(bool (*)(rrllvm::LLVMModelData*, int, double), rrllvm::LLVMExecutableModel::GetNameFuncPtr, int, const int*, const double*)

