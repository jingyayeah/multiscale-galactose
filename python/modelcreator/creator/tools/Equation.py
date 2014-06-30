'''
Created on Jun 30, 2014

@author: mkoenig
'''
import re
REVERSIBLE = '<[-=]>'
IRREVERSIBLE = '[-=]>'

class Equation(object):
    '''
    
    '''
    def __init__(self, equation):
        self.reactants = []
        self.products = []
        self.modifiers = []
        self.reversible = None
        
        self.raw = equation
        self.parseEquation()
    
    def parseEquation(self):
        items = re.split(IRREVERSIBLE, self.raw)
        if len(items) == 2:
            self.reversible = False
        elif len(items) == 1:
            items = re.split(REVERSIBLE, self.raw)
            self.reversible = True
        else:
            print 'Invalid equation:', self.raw
        self.reactants = self.parseHalfEquation(items[0])
        self.products = self.parseHalfEquation(items[1])

    def parseHalfEquation(self, string):
        eq_objects = []
        items = re.split('[+-]', string)
        

    def info(self):
        lines = [self.raw]
        lines.append('reversible: ' + str(self.reversible))
        lines.append('reactants: ' + str(self.reactants))
        lines.append('products: '+ str(self.products))
        print '\n'.join(lines)


if __name__ == '__main__':
    eq = Equation('c__gal1p => c__gal + c__phos')
    eq.info()
    