'''
Parse equation strings into a standard format.

Created on Jun 30, 2014
@author: mkoenig
'''
import re
REV_PATTERN = '<[-=]>'
IRREV_PATTERN = '[-=]>'
MOD_PATTERN = '\[.*\]'
REV_SEP = '<=>'
IRREV_SEP = '=>'

class Equation(object):
    
    def __init__(self, equation):
        self.raw = equation
        
        self.reactants = []
        self.products = []
        self.modifiers = []
        self.reversible = None

        self.parseEquation()
    
    def parseEquation(self):
        eq_string = self.raw[:]
        
        # get modifiers and remove from equation string
        mod_list = re.findall(MOD_PATTERN, eq_string)
        if len(mod_list) == 1:
            self.parseModifiers(mod_list[0])
            tokens = eq_string.split('[')
            eq_string = tokens[0].strip()
        elif len(mod_list) > 1:
            print 'Invalid equation_', self.raw
        
        # now parse the equation without modifiers
        items = re.split(REV_PATTERN, eq_string)
        if len(items) == 2:
            self.reversible = True
        elif len(items) == 1:
            items = re.split(IRREV_PATTERN, eq_string)
            self.reversible = False
        else:
            print 'Invalid equation:', self.raw
            
        self.reactants = self.parseHalfEquation(items[0])
        self.products = self.parseHalfEquation(items[1])

    def parseModifiers(self, s):
        s = s.replace('[', '')
        s = s.replace(']', '')
        s = s.strip()
        tokens = re.split('[,;]', s)
        tokens = [t.strip() for t in tokens]
        print tokens
        self.modifiers = tokens

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
            sep = REV_SEP
        elif self.reversible == False:
            sep = IRREV_SEP
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
                 '{:<10s} : {}'.format('modifiers', self.modifiers),
                 '\n'
                 ]
        print '\n'.join(lines)
        
##################################################################
if __name__ == '__main__':
    
    tests = ['c__gal1p => c__gal + c__phos',
             'e__h2oM <-> c__h2oM',
             '3 atp + 2.0 phos + ki <-> 16.98 tet',
             'c__gal1p => c__gal + c__phos [c__udp, c__utp]',
             ]
    
    for test in tests:
        print '-' * 40
        print test
        print '-' * 40
        eq = Equation(test)
        eq.info()
    
    