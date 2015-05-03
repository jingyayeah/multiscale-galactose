################################################################
# HDF5 writing and reading
################################################################
# Test support of HDF5 for data communication.
# 
# author: Matthias Koenig
# date: 2015-05-03
################################################################

# source("http://bioconductor.org/biocLite.R")
# biocLite("rhdf5")

library(rhdf5)
filepath <- "/home/mkoenig/multiscale-galactose-results/tmp_sim/T2/Koenig2014_demo_kinetic_v7_Sim26_roadrunner.h5"
# fid <- H5Fopen(filepath)
data <- t(h5read(filepath, 'data'))
time <- h5read(filepath, 'time')
header <- h5read(filepath, 'header')
str(header)
header[1]
colnames(data) <- header
rownames(data) <- time
data



H5Fclose()

summary(data)
dim(data)

# time the file reading