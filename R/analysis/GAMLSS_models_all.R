################################################################################
# Create all GAMLSS models
################################################################################
# Fitting of GAMLSS statistical models to the underlying datasats. These are 
# the models used for the individual predictions of the 2D correlations.
#
# TODO: create overview table of models (studies, datapoints, link function, ...)
#
# author: Matthias Koenig
# date: 2014-11-26
################################################################################
setwd(ma.settings$dir.base)
# load field, axis and color information


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

for (dataset in dsets){
  cat(dataset, '\n')
  source(file.path(ma.settings$dir.code, 'analysis', 'GAMLSS_models.R'))
  cat(xname, '~', yname, '\n')
  models
}

# Create the tables from the datasets