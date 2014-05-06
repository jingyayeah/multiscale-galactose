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

# libraries are copied during next simulation
