#!/bin/bash
freport="test.csv"
fconfig="test.ini"
# remove old report
rm $freport
# show config information for integration
more $fconfig

Debug/CopasiModelRunner -s /home/mkoenig/multiscale-galactose-results/test/Dilution_Curves_v4_Nc20_Nf1.xml -c $fconfig -t $freport

# create plots for data for control

