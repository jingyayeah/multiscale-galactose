#!/bin/bash
############################################################
# starts the ode simulations (simulator get information from
# database and than run the simulations.
#
# @author: Matthias Koenig
# @date: 2014-05-23
# TODO: use options to not use all CPUS on target computer
# TODO: handle copying of results files better
############################################################
export MULTISCALE_GALACTOSE=~/multiscale-galactose
export MULTISCALE_GALACTOSE_RESULTS=~/multiscale-galactose-results

export PYTHONPATH=${PYTHONPATH}:${MULTISCALE_GALACTOSE}/python
export PYTHONPATH=${PYTHONPATH}:${MULTISCALE_GALACTOSE}/python/mysite/
export PYTHONPATH=${PYTHONPATH}:${MULTISCALE_GALACTOSE}/python/simulator/
export DJANGO_SETTINGS_MODULE=mysite.settings

echo "###################################"
echo "# Pull git source code"
echo "###################################"
cd ${MULTISCALE_GALACTOSE}
git config --global credential.helper 'cache --timeout 86400'
git pull

echo "###################################"
echo "# Create folders"
echo "###################################"
mkdir ${MULTISCALE_GALACTOSE_RESULTS}
mkdir ${MULTISCALE_GALACTOSE_RESULTS}/tmp_sbml
mkdir ${MULTISCALE_GALACTOSE_RESULTS}/tmp_sim
mkdir ${MULTISCALE_GALACTOSE_RESULTS}/django
mkdir ${MULTISCALE_GALACTOSE_RESULTS}/django/sbml
mkdir ${MULTISCALE_GALACTOSE_RESULTS}/django/timecourse

echo "###################################"
echo "# Build copasi #"
echo "###################################"
# copy libraries
export COPASI_PROJECT=~/multiscale-galactose/cpp/copasi/CopasiModelRunner
cp ~/copasi/build_copasi/copasi/libCOPASISE.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.a $COPASI_PROJECT
cp ~/copasi/copasi-dependencies/bin/lib/*.la $COPASI_PROJECT
rm -r ${COPASI_PROJECT}/Debug
rm -r ${COPASI_PROJECT}/build
mkdir ${COPASI_PROJECT}/build
cd ${COPASI_PROJECT}/build
cmake ..
make

echo "###################################"
echo "# run simulations #"
echo "###################################"
cd ${MULTISCALE_GALACTOSE}/python/simulator/simulation
python Simulator.py


