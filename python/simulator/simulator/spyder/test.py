'''
Created on Dec 7, 2014

@author: mkoenig
'''

import numpy
import roadrunner
from roadrunner.roadrunner import Logger
print roadrunner.__version__

if __name__ == '__main__':
    import antimony
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
    K3 = K1 + K2;
    K4 = 2*K3
    end
    """
    model = antimony.loadString(model_txt)
    print antimony.getModuleNames()
    antimony.writeSBMLFile('test.xml', 'test')
    
    
    sbml_file = 'test.xml'
    print sbml_file
    rr = roadrunner.RoadRunner(sbml_file)
    
    print rr.model.items()
    
    rr.simulate(plot=True)
    
    rr.K2 = 5;
    print rr.model.items()
    rr.reset()
    print rr.model.items()
    
    
    
    
    