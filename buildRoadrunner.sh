#!/bin/bash
############################################################
# Builds Roadrunner and its dependencies from git releases.
# Generate cpproadrunner and the pyroadrunner
#
# @author: Matthias Koenig
# @date: 2014-05-23
############################################################
# install dependencies
sudo apt-get install llvm python-numpy python-scipy

# CPP_RR=http://sourceforge.net/projects/libroadrunner/files/libroadrunner-1.2.3/cpplibroadrunner-1.2.3-linux_ubuntu10.04%2B_x86_64.tar.gz/download
CPP_RR=http://sourceforge.net/projects/libroadrunner/files/libroadrunner-1.2.6/cpplibroadrunner-1.2.6-linux_x86_64.tar.gz/download


CPP_RR_NAME=cpplibroadrunner-latest

# PY_RR=http://sourceforge.net/projects/libroadrunner/files/libroadrunner-1.2.3/pylibroadrunner-1.2.3-linux_ubuntu10.04%2B_x86_64.tar.gz/download
# PY_RR=http://sourceforge.net/projects/libroadrunner/files/libroadrunner-1.2.6/pylibroadrunner-1.2.6-linux_x86_64.tar.gz/download
#PY_RR=http://sourceforge.net/projects/libroadrunner/files/libroadrunner-1.3-beta/pylibroadrunner-1.3-symcache-beta5-linux_x86_64.tar.gz/download
PY_RR=http://sourceforge.net/projects/libroadrunner/files/libroadrunner-1.3-beta/pylibroadrunner-1.3-beta7-linux_x86_64.tar.gz/download

PY_RR_NAME=pylibroadrunner-latest


# get the latest files
rm ~/Downloads/${CPP_RR_NAME}.tar.gz
rm ~/Downloads/${PY_RR_NAME}.tar.gz
wget --output-document ~/Downloads/${CPP_RR_NAME}.tar.gz ${CPP_RR}
wget --output-document ~/Downloads/${PY_RR_NAME}.tar.gz ${PY_RR}

cd ~/Downloads

tar xzvf ${CPP_RR_NAME}.tar.gz
cd libroadrunner
sudo python setup.py install

cd ~/Downloads
tar xzvf ${PY_RR_NAME}.tar.gz
# cd pylibroadrunner-1.2.3-linux_x86_64
# cd pylibroadrunner-1.2.6-linux_x86_64
# cd pylibroadrunner-1.3-symcache-beta5-linux_x86_64
cd pylibroadrunner-1.3-beta7-linux_x86_64

sudo python setup.py install

cd ~/multiscale-galactose
./testRoadrunner.py
