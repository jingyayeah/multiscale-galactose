'''
Created on Mar 25, 2014

@author: Matthias Koenig

    # TODO: Somehow the database has to be checked for consistency.
    # Perform db validation routines and cleanup on the database.
    
    
    # remove all simulations
    # print "Deleting all simulations !!!"
    # Simulation.objects.all().delete()
    
    TODO: 
    check for Simulations which have status assigned, but never finished.
    
    TODO: 
    Check for timecourses which point to unassigned & assigned simulations
    and remove these files.    
'''

def testSimulations():
    print "NOT IMPLEMENTED"



if __name__ == "__main__":
    testSimulations();