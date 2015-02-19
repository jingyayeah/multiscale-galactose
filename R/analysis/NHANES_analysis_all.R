################################################################################
# NHANES based population prediction
################################################################################
# Creates all NHANES figures with the corresponding experimental data.
#
# author: Matthias Koenig
# date: 2015-02-19
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

dsets <- c('GEC_age', 'GECkg_age',  
           'volLiver_age', 'volLiverkg_age',
           'volLiver_bodyweight','volLiverkg_bodyweight',
           'volLiver_height','volLiverkg_height',
           'volLiver_BSA', 'volLiverkg_BSA',
           
           'flowLiver_volLiver', 'flowLiverkg_volLiverkg',
           'perfusion_age',
           
           'flowLiver_age', 'flowLiverkg_age',
           'flowLiver_bodyweight', 'flowLiverkg_bodyweight',
           'flowLiver_BSA', 'flowLiverkg_BSA')
dsets

#--------------------------------
# Prepare data once
#--------------------------------
# Load NHANES data 
load(file=file.path(dir.nhanes, 'nhanes_people.Rdata'))
load(file=file.path(dir.nhanes, 'nhanes_volLiver.Rdata'))
load(file=file.path(dir.nhanes, 'nhanes_flowLiver.Rdata'))
load(file=file.path(dir.nhanes, 'nhanes_GEC.Rdata'))
nhanes <- people.nhanes
rm(people.nhanes)

# additional matrices
Nr <- nrow(GEC)
Nc <- ncol(GEC)
volLiverkg = matrix(NA, nrow=Nr, ncol=Nc)
flowLiverkg = matrix(NA, nrow=Nr, ncol=Nc)
GECkg = matrix(NA, nrow=Nr, ncol=Nc)
perfusion = matrix(NA, nrow=Nr, ncol=Nc)
for(k in 1:Nr){
  volLiverkg[k, ] = volLiver[k, ]/nhanes$bodyweight[k]
  flowLiverkg[k, ] = flowLiver[k, ]/nhanes$bodyweight[k]
  GECkg[k, ] = GEC[k, ]/nhanes$bodyweight[k]
  perfusion[k, ] = flowLiver[k, ]/volLiver[k, ]
}

# calculate quantiles (mean)
volLiver.q <- calc_quantiles(volLiver)
flowLiver.q <- calc_quantiles(flowLiver)
GEC.q <- calc_quantiles(GEC)
GECkg.q <- calc_quantiles(GECkg)

# Add resulting information to nhanes
colnames(volLiver.q)
nhanes$volLiver <- volLiver.q[, '50%']
nhanes$volLiverkg <- nhanes$volLiver/nhanes$bodyweight
nhanes$flowLiver <- flowLiver.q[, '50%']
nhanes$flowLiverkg <- nhanes$flowLiver/nhanes$bodyweight
nhanes$GEC <- GEC.q[, '50%']
nhanes$GECkg <- nhanes$GEC/nhanes$bodyweight
nhanes$perfusion <- nhanes$flowLiver/nhanes$volLiver


#--------------------------------
# Create single dataset
#--------------------------------
# dataset = "GECkg_age"
# source(file.path(ma.settings$dir.code, 'analysis', 'NHANES_analysis.R'))


################################################################################
# Create all GAMLSS models 
################################################################################
for (dataset in dsets){
  cat(dataset, '\n')
  source(file.path(ma.settings$dir.code, 'analysis', 'NHANES_analysis.R'))
}