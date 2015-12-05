#!/bin/bash
############################################################
# Build roadrunner directly from the release files on
# github https://github.com/sys-bio/roadrunner/releases
#
# Ubuntu x64
# For updating increase the tag number.
#
# @author: Matthias Koenig
# @date: 2015-12-05
############################################################

echo "Make directories for roadrunner installation"
ROADRUNNER=roadrunner
GIT_DIR=$HOME/git 
TMP_DIR=$HOME/tmp
if ! [ -d "$GIT_DIR" ]; then
	mkdir $GIT_DIR
fi
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

# install dependencies
echo "install roadrunner dependencies"
sudo apt-get install llvm llvm-dev git libxml2-dev
sudo -E pip install numpy --upgrade
sudo -E pip install scipy --upgrade

# clone the repository (hard remove & clone)
echo "pull roadrunner repository"
cd $GIT_DIR
if [ -d "$ROADRUNNER" ]; then
	cd ${GIT_DIR}/$ROADRUNNER
	git pull
else
	git clone https://github.com/sys-bio/roadrunner.git $ROADRUNNER
	cd ${GIT_DIR}/$ROADRUNNER
fi
# checkout release tag or version to build
# git tag -l
# git checkout tags/1.4.1
git checkout develop

# create build folders
echo "build roadrunner third party dependencies"
ROADRUNNER_INSTALL=$TMP_DIR/roadrunner_install
ROADRUNNER_BUILD=$TMP_DIR/roadrunner_build
ROADRUNNER_BUILD_THIRDPARTY=$TMP_DIR/roadrunner_build_thirdparty

# clean install directory
sudo rm -rf $ROADRUNNER_INSTALL
mkdir $ROADRUNNER_INSTALL

# build the third party libraries
git checkout tags/1.4.1

rm -rf $ROADRUNNER_BUILD_THIRDPARTY
mkdir $ROADRUNNER_BUILD_THIRDPARTY
cd $ROADRUNNER_BUILD_THIRDPARTY
cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL ${GIT_DIR}/$ROADRUNNER/third_party && make -j4 install


# build roadrunner
cd ${GIT_DIR}/$ROADRUNNER
git checkout develop
read -p "Press any key to continue ..."

rm -rf $ROADRUNNER_BUILD
mkdir $ROADRUNNER_BUILD
cd $ROADRUNNER_BUILD
cmake -DCMAKE_INSTALL_PREFIX=$ROADRUNNER_INSTALL -DTHIRD_PARTY_INSTALL_FOLDER=$ROADRUNNER_INSTALL -DBUILD_LLVM=ON -DBUILD_PYTHON=ON -DUSE_TR1_CXX_NS=ON -DBUILD_TESTS=ON -DBUILD_TEST_TOOLS=ON ${GIT_DIR}/$ROADRUNNER
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
