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
rm(list=ls())
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
  source(file.path(ma.settings$dir.code, 'analysis', 'GAMLSS_models.R'))
  cat(xname, '~', yname, '\n')
  models
}

################################################################################
# Create GAMLSS model table 
################################################################################
formulaString <- function(formula, sigma=F){
  tokens <- as.character(formula)
  if (sigma == T){
    f <- sprintf('%s', tokens[2])
  } else {
    f <- sprintf('%s', tokens[3])
    # f <- sprintf('%s ~ %s', tokens[2], tokens[3])
  }
  return(f)
}

Nr <- length(dsets)
res.table <- data.frame(character(Nr*3), character(Nr*3), character(Nr*3), character(Nr*3), 
                        character(Nr*3), character(Nr*3), numeric(Nr*3), numeric(Nr*3), stringsAsFactors=FALSE)
names(res.table) <- c('y', 'x', 'sex', 'link',
                      'mu.formula', 'sigma.formula', 'df', 'N')
head(res.table)

# for (k in 1:Nr){
for (k in 1:2){
 # get names
 dset.name <- dsets[k]
 xy.names <- createXYNameFromDatasetName(dset.name)
 xname <- xy.names$xname; yname <- xy.names$yname
 # load the model and get information
 models <- loadFitModels(xname=xname, yname=yname)
 for (si in 1:length(gender.levels)){
   sex <- gender.levels[si]
   m <- models[[sprintf('fit.%s', sex)]]
   df <- models[[sprintf('df.%s', sex)]]
   if(is.null(m)){
     link <- '';  mu.f <- ''; sigma.f <- ''
   } else {
     link <- m$family[2]
     mu.f <- formulaString(m$mu.formula)
     sigma.f <- formulaString(m$sigma.formula, sigma=T)
     row <- c(yname, xname, sex, link,
              mu.f, sigma.f, sprintf('%1.1f', m$df.fit), m$N)
   }
   row <- c(yname, xname, sex, link,
            mu.f, sigma.f, sprintf('%1.1f', m$df.fit), m$N)
   print(row)
   res.table[3*(k-1)+si, ] <- row
 }
}
head(res.table)

models <- loadFitModels(xname='age', yname='GEC')
m <- models[['fit.all']]
m
m$family[2]
m$call
m$sigma.df
m$mu.df
formulaString(m$mu.formula)
str(m)
df <- models[['df.all']]




