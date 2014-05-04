#!/bin/bash

# copies the simulation results from servers to proper data directory
# for preprocessing
DATE=2014-05-04
STYPE=MultipleIndicator
IPS=(10.39.32.106 10.39.32.189 10.39.34.27)

DATA_DIR=~/multiscale-galactose-results/${DATE}_${STYPE}
mkdir $DATA_DIR 
mkdir $DATA_DIR/data
cd $DATA_DIR/data

for i in ${IPS[@]}; do
    echo "*** ${i} ***"
    
    scp mkoenig@${i}:~/multiscale-galactose-results/django/timecourse/$DATE/*.* .
done

# copy SBML files

# create parameter files and copy

# do the preprocessing





