#!/bin/bash
freport="test.csv"
fconfig="test.ini"
# remove old report
rm $freport
# show config information for integration
more $fconfig

# build from the eclipse makefile
# Debug/CopasiModelRunner -s /home/mkoenig/multiscale-galactose-results/tmp_sbml/Dilution_Curves_v5_Nc20_Nf1.xml -c $fconfig -t $freport

# build from the cmake makefile
build/CopasiModelRunner -s /home/mkoenig/multiscale-galactose-results/tmp_sbml/Dilution_Curves_v5_Nc20_Nf1.xml -c $fconfig -t $freport

