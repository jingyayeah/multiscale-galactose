#!/bin/bash
############################################################
# Builds Copasi and its dependencies from git code.
# Libraries are copied during next simulation.
#
# @author: Matthias Koenig
# @date: 2014-05-13
############################################################
# install dependencies
sudo apt-get install libboost-all-dev git cmake g++ libgl1-mesa-dev libglu1-mesa-dev libqt4-dev libxml2-dev zlib1g-dev byacc flex

# building copasi from scratch
rm -rf ~/copasi
mkdir ~/copasi

# build the dependencies
cd ~/copasi/
git clone https://github.com/copasi/copasi-dependencies
cd copasi-dependencies
./createLinux.sh
cd ..

# build copasi
git clone https://github.com/copasi/COPASI
mkdir build_copasi
cd build_copasi
cmake -DBUILD_GUI=OFF -DBUILD_CXX_EXAMPLES=ON -DCMAKE_INSTALL_PREFIX=~/copasi -DCOPASI_DEPENDENCY_DIR=../copasi-dependencies/bin ../COPASI
make
sudo make install

# test installation
~/copasi/bin/CopasiSE


