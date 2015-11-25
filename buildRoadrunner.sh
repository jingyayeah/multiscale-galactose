#!/bin/bash
############################################################
# Build roadrunner directly from the release files on
# github https://github.com/sys-bio/roadrunner/releases
#
# Ubuntu x64
# For updating increase the tag number.
#
# @author: Matthias Koenig
# @date: 2015-11-05
############################################################
GIT_DIR=~/git 
TMP_DIR=~/tmp
mkdir $GIT_DIR
mkdir $TMP_DIR

# install dependencies
sudo apt-get install llvm llvm-dev git libxml2-dev

# install/upgrade python dependencies
sudo -E pip install numpy --upgrade
sudo -E pip install scipy --upgrade

# clone the repository (hard remove & clone)
cd $GIT_DIR
rm -rf roadrunner
git clone https://github.com/sys-bio/roadrunner.git roadrunner
cd ${GIT_DIR}/roadrunner

# checkout the release tag
# git tag -l
# git checkout tags/<tag_name>
git checkout tags/1.4.1

# create build folders
ROADRUNNER_INSTALL=$TMP_DIR/roadrunner_install
ROADRUNNER_BUILD=$TMP_DIR/roadrunner_build
ROADRUNNER_BUILD_THIRDPARTY=$TMP_DIR/roadrunner_build_thirdparty
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
cd $MULTISCALE_GALACTOSE
./testRoadrunner.py
