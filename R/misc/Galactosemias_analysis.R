# Analyse the Galactosemias
# TODO:

################################################################
rm(list=ls())
library(data.table)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

# Galactose challenge, with galactosemias
folder <- '2014-07-30_T25'

folders <- paste('2014-08-13_T', seq(33,49), sep='')
for (folder in folders){
  source(file=file.path(ma.settings$dir.code, 'analysis', 'Preprocess.R'), 
         echo=TRUE, local=FALSE)
}
stop('finished preprocessing')
###########################################################################