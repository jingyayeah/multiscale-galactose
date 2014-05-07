'''
The Report factory generates the SBML report based on the underlying SBML
using the Django template language. 
The original prototype was developed in Java with JSBML based on a 
different template language but the underlying idea of rendering the
template with the given SBML structure remains the same.

But some other dependencies.
TODO: implement

@author: Matthias Koenig
@date: 2014-05-07
'''


def createSBMLReport():
    '''
    Creates the SBML report by rendering a Django view.
    '''
    print 'Not Implemented!'
    pass


if __name__ == "__main__":
    createSBMLReport()
