#!/bin/bash
############################################################
# Builds Copasi and its dependencies from git code.
# Libraries are copied during next simulation.
# Set -DBUILD_GUI=ON to build with GUI
#
# @author: Matthias Koenig
# @date: 2014-05-13
############################################################
# install dependencies
sudo apt-get install libboost-all-dev git cmake g++ libgl1-mesa-dev libglu1-mesa-dev libqt4-dev libxml2-dev zlib1g-dev byacc flex
sudo apt-get install qt4-dev-tools libqt4-webkit libqtwebkit-dev libqt4-opengl libqt4-opengl-dev
# Necessary to comile own code with copasi
sudo apt-get install libboost-all-dev

# building copasi from scratch
rm -rf ~/copasi
mkdir ~/copasi

# build the dependencies
cd ~/copasi/
git clone https://github.com/copasi/copasi-dependencies
cd copasi-dependencies
./createLinux.sh
cd ..

# fix for the dependencies
cd ~/copasi/copasi-dependencies/tmp/libSEDML
rm -rf sedml
cmake -DLIBSBML_INCLUDE_DIR=../../bin/include -DLIBSBML_LIBRARY=../../bin/lib/libsbml-static.a ../../src/libSEDML
make
make install

# build copasi
cd ~/copasi/
git clone https://github.com/copasi/COPASI
mkdir build_copasi
cd build_copasi
cmake -DBUILD_GUI=ON -DBUILD_CXX_EXAMPLES=ON -DCMAKE_CXX_FLAGS=-fPIC -DENABLE_PYTHON=ON -DCMAKE_INSTALL_PREFIX=~/copasi -DCOPASI_DEPENDENCY_DIR=../copasi-dependencies/bin ../COPASI
make
sudo make install

# test installation
~/copasi/bin/CopasiSE

# make symbolic links
sudo ln -s ~/copasi/build_copasi/copasi/CopasiUI/CopasiUI /usr/local/bin/CopasiUI
sudo ln -s ~/copasi/build_copasi/copasi/CopasiSE/CopasiSE /usr/local/bin/CopasiSE



