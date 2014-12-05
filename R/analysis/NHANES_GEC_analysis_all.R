################################################################################
# Create all NHANES figures with the predicted data
################################################################################
# Create figure for the NHANES simulation in combination with the experimental
# data.
#
# author: Matthias Koenig
# date: 2014-12-03
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))

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

################################################################################
# Create all GAMLSS models 
################################################################################
for (dataset in dsets){
  cat(dataset, '\n')
  source(file.path(ma.settings$dir.code, 'analysis', 'NHANES_GEC_analysis.R'))
}