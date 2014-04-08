#!/bin/bash
echo "###################################"
echo "# build copasi #"
echo "###################################"
# copy all the libraries to link
COPASI_PROJECT=~/multiscale-galactose/cpp/copasi/CopasiModelRunner
cp ~/copasi/build_copasi/copasi/libCOPASISE.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.la $COPASI_PROJECT


rm -r ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/Debug
rm -r ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
mkdir ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
cd ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/build
cmake ..
make


echo "###################################"
echo "# run test simulation #"
echo "###################################"
cd ~/multiscale-galactose/cpp/copasi/CopasiModelRunner/
freport="test.csv"
fconfig="test.ini"
# remove old report
rm $freport
# show config information for integration
more $fconfig

# build from the eclipse makefile
# Debug/CopasiModelRunner -s /home/mkoenig/multiscale-galactose-results/tmp_sbml/Dilution_Curves_v5_Nc20_Nf1.xml -c $fconfig -t $freport

# build from the cmake makefile
# build/CopasiModelRunner -s /home/mkoenig/multiscale-galactose-results/tmp_sbml/Dilution_Curves_v5_Nc20_Nf1.xml -c $fconfig -t $freport
# build/CopasiModelRunner -s /home/mkoenig/multiscale-galactose-results/tmp_sbml/Galactose_v8_Nc20_Nf1.xml -c $fconfig -t $freport
build/CopasiModelRunner -s /home/mkoenig/multiscale-galactose-results/tmp_sbml/Galactose_v8_Nc1_Nf1.xml -c $fconfig -t $freport
