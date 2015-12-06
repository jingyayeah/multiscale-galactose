# -*- coding: utf-8 -*-
"""
SBMLValidator based on the sbml.org validator example code.
"""
import os.path
import time
import libsbml


def validate_sbml(sbml_file, ucheck=True):
    validator = SBMLValidator(ucheck=ucheck)
    return validator.validate(sbml_file)

# TODO: use the sbmlutils
def check_sbml(filename):
    current = time.clock()
    doc = libsbml.readSBML(filename)
    # doc.setConsistencyChecks(libsbml.LIBSBML_CAT_UNITS_CONSISTENCY, False)
    # doc.setConsistencyChecks(libsbml.LIBSBML_CAT_MODELING_PRACTICE, False)
    doc.checkConsistency()
    errors = doc.getNumErrors()

    print
    print(" filename: " + filename)
    print(" file size: " + str(os.stat(filename).st_size))
    print(" read time (ms): " + str(time.clock() - current))
    print(" validation error(s): " + str(errors))
    print
    doc.printErrors()
    return errors

def check(value, message):
    if value == None:
        print('LibSBML returned a null value trying to ' + message + '.')
        sys.exit(1)
    elif type(value) is int:
        if value == libsbml.LIBSBML_OPERATION_SUCCESS:
            return
        else:
            print('Error encountered trying to ' + message + '.')
            print('LibSBML returned error code ' + str(value) + ': "'
                  + libsbml.OperationReturnValue_toString(value).strip() + '"')
            print('Exiting.')
            sys.exit(1)
    else:
        return




class SBMLValidator:
    def __init__(self, ucheck):
        self.reader = libsbml.SBMLReader()
        self.ucheck = ucheck
        self.numinvalid = 0
 
    def validate(self, infile):
        if not os.path.exists(infile):
            print("[Error] %s : No such file." % (infile))
            self.numinvalid += 1
            return
 
        start = time.time()
        sbmlDoc = libsbml.readSBML(infile)
        stop = time.time()
        timeRead = (stop - start)*1000
        errors = sbmlDoc.getNumErrors()

        seriousErrors = False
 
        numReadErr = 0
        numReadWarn = 0
        errMsgRead = ""

        if errors > 0:
            for i in range(errors):
                severity = sbmlDoc.getError(i).getSeverity()
                if (severity == libsbml.LIBSBML_SEV_ERROR) or (severity == libsbml.LIBSBML_SEV_FATAL):
                    seriousErrors = True
                    numReadErr += 1
                else:
                    numReadWarn += 1

                errMsgRead = sbmlDoc.getErrorLog().toString()

        # If serious errors are encountered while reading an SBML document, it
        # does not make sense to go on and do full consistency checking because
        # the model may be nonsense in the first place.
 
        numCCErr = 0
        numCCWarn = 0
        errMsgCC = ""
        skipCC = False;
        timeCC = 0.0

        if seriousErrors:
            skipCC = True;
            errMsgRead += "Further consistency checking and validation aborted."
            self.numinvalid += 1;
        else:
            sbmlDoc.setConsistencyChecks(libsbml.LIBSBML_CAT_UNITS_CONSISTENCY, self.ucheck)
            start = time.time()
            failures = sbmlDoc.checkConsistency()
            stop = time.time()
            timeCC = (stop - start)*1000

            if failures > 0:

                isinvalid = False;
                for i in range(failures):
                    severity = sbmlDoc.getError(i).getSeverity()
                    if (severity == libsbml.LIBSBML_SEV_ERROR) or (severity == libsbml.LIBSBML_SEV_FATAL):
                        numCCErr += 1
                        isinvalid = True;
                    else:
                        numCCWarn += 1

                if isinvalid:
                    self.numinvalid += 1;

                errMsgCC = sbmlDoc.getErrorLog().toString()
        #
        # print results
        #
        lines = []
        lines.append(" filename : %s" % (infile))
        lines.append(" file size (byte) : %d" % (os.path.getsize(infile)))
        lines.append(" read time (ms) : %f" % (timeRead))

        if not skipCC :
            lines.append( " c-check time (ms) : %f" % (timeCC))
        else:
            lines.append( " c-check time (ms) : skipped")

        lines.append( " validation error(s) : %d" % (numReadErr + numCCErr))
        if not skipCC :
            lines.append( " (consistency error(s)): %d" % (numCCErr))
        else:
            lines.append( " (consistency error(s)): skipped")

        lines.append( " validation warning(s) : %d" % (numReadWarn + numCCWarn))
        if not skipCC :
            lines.append( " (consistency warning(s)): %d" % (numCCWarn))
        else:
            lines.append( " (consistency warning(s)): skipped")

        if errMsgRead or errMsgCC:
            lines.append('')
            lines.append( "===== validation error/warning messages =====\n")
            if errMsgRead :
                lines.append( errMsgRead)
            if errMsgCC :
                lines.append( "*** consistency check ***\n")
                lines.append( errMsgCC)
        val_string = '\n'.join(lines)
        print val_string, '\n'
        
        return { "numCCErr": numCCErr,
                 "numCCWarn": numCCWarn,
                 "errMsgCC": errMsgCC,
                 "skipCC": skipCC,
                 "timeCC": timeCC
                 }


