#!/bin/bash
############################################################
# Build roadrunner directly from the release files on
# github https://github.com/sys-bio/roadrunner/releases
#
# Ubuntu x64
#
# @author: Matthias Koenig
# @date: 2015-05-23
############################################################

# install/upgrade python dependencies
sudo pip install numpy --upgrade
sudo pip install scipy --upgrade

sudo apt-get install llvm llvm-dev git libxml2-dev

# clone the repository
GIT_DIR=~/git 
mkdir $GIT_DIR
cd $GIT_DIR
git clone https://github.com/sys-bio/roadrunner.git roadrunner
cd ${GIT_DIR}/roadrunner

# checkout the release tag
# git tag -l
# git checkout tags/<tag_name>
git checkout tags/1.3.2

# create build folders
mkdir ~/tmp
ROADRUNNER_INSTALL=~/tmp/roadrunner_install
ROADRUNNER_BUILD=~/tmp/roadrunner_build
ROADRUNNER_BUILD_THIRDPARTY=~/tmp/roadrunner_build_thirdparty
mkdir $ROADRUNNER_INSTALL
mkdir $ROADRUNNER_BUILD
mkdir $ROADRUNNER_BUILD_THIRDPARTY

# build the third party libraries
cd $ROADRUNNER_BUILD_THIRDPARTY
cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL ${GIT_DIR}/roadrunner/third_party && make -j4 install

# build roadrunner
cd $ROADRUNNER_BUILD
cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL -DTHIRD_PARTY_INSTALL_FOLDER=$ROADRUNNER_INSTALL -DBUILD_LLVM=ON -DBUILD_PYTHON=ON -DUSE_TR1_CXX_NS=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON ${GIT_DIR}/roadrunner
make
make install

# clean old roadrunner installs
sudo rm -r /usr/local/lib/python2.7/dist-packages/roadrunner
sudo rm /usr/local/lib/python2.7/dist-packages/*roadrunner*

# make the python setup
cd $ROADRUNNER_INSTALL
sudo python setup.py install

# perform the tests
cd ~/multiscale-galactose
./testRoadrunner.py
