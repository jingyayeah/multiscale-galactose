'''
Parse equation strings into a standard format.

Created on Jun 30, 2014
@author: mkoenig
'''
import re
REVERSIBLE = '<[-=]>'
IRREVERSIBLE = '[-=]>'

class Equation(object):
    
    def __init__(self, equation):
        self.raw = equation
        
        self.reactants = []
        self.products = []
        self.modifiers = []
        self.reversible = None

        self.parseEquation()
    
    def parseEquation(self):
        items = re.split(REVERSIBLE, self.raw)
        if len(items) == 2:
            self.reversible = True
        elif len(items) == 1:
            items = re.split(IRREVERSIBLE, self.raw)
            self.reversible = False
        else:
            print 'Invalid equation:', self.raw
            
        self.reactants = self.parseHalfEquation(items[0])
        self.products = self.parseHalfEquation(items[1])

    def parseHalfEquation(self, string):
        ''' Only '+ supported in equation !, do not use negative
            stoichiometries.
        '''
        items = re.split('[+-]', string)
        items = [item.strip() for item in items]
        return [self.parseReactant(item) for item in items]
    
    def parseReactant(self, item):
        ''' Returns tuple of stoichiometry, sid. '''
        tokens = item.split()
        if len(tokens) == 1:
            stoichiometry = 1.0
            sid = tokens[0]
        else:
            stoichiometry = float(tokens[0])
            sid = ' '.join(tokens[1:])
        return (stoichiometry, sid)
        
    def toString(self):
        left = self.toStringSide(self.reactants)
        right = self.toStringSide(self.products)
        if self.reversible == True:
            sep = '<=>'
        elif self.reversible == False:
            sep = '=>'
        return ' '.join([left, sep, right])
    
    def toStringSide(self, items):
        tokens = []
        for item in items:
            stoichiometry, sid = item[0], item[1]
            if abs(1.0 - stoichiometry) < 1E-10:
                tokens.append(sid)
            else:
                tokens.append(' '.join([str(stoichiometry), sid]))
        return ' + '.join(tokens)
    
    def info(self):
        lines = [
                 '{:<10s} : {}'.format('raw', self.raw),
                 '{:<10s} : {}'.format('parsed', self.toString()),
                 '{:<10s} : {}'.format('reversible', self.reversible),
                 '{:<10s} : {}'.format('reactants', self.reactants),
                 '{:<10s} : {}'.format('products', self.products),
                 '\n'
                 ]
        print '\n'.join(lines)
        
##################################################################
if __name__ == '__main__':
    tests = ['c__gal1p => c__gal + c__phos',
             'e__h2oM <-> c__h2oM',
             '3 atp + 2.0 phos + ki <-> 16.98 tet'
             ]
    
    for test in tests:
        print '-' * 40
        print test
        print '-' * 40
        eq = Equation(test)
        eq.info()
    
    