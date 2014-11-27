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

dataOverview <- function(df){
  t <- table(df$study)
  t <- t[order(names(t))]
  
  tokens <- list(length(t))
  for (k in 1:length(t)){
    tokens[k] <- sprintf('%s(%s)', names(t)[k], t[k]) 
  }
  return( paste(tokens, collapse = ', ') )
}
# df <- models[['df.all']]
# dataOverview(df)


# Create the table
Nr <- length(dsets)
res.table <- data.frame(character(Nr*3), character(Nr*3), character(Nr*3), character(Nr*3), 
                        character(Nr*3), character(Nr*3), numeric(Nr*3), numeric(Nr*3), 
                        character(Nr*3), stringsAsFactors=FALSE)
names(res.table) <- c('y', 'x', 'sex', 'link',
                      'mu.formula', 'sigma.formula', 'df', 'N', 'data')
for (k in 1:Nr){
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
     row <- c(yname, xname, sex, '',
              '', '', '', nrow(df), '')
   } else {
     row <- c(yname, xname, sex, m$family[1],
              formulaString(m$mu.formula), formulaString(m$sigma.formula, sigma=T), sprintf('%1.1f', m$df.fit), m$N,
              dataOverview(df))     
     
   }
   res.table[3*(k-1)+si, ] <- row
 }
}

# save the table
# replace sex
res.table$sex[res.table$sex==gender.levels[1]] <- 'A'
res.table$sex[res.table$sex==gender.levels[2]] <- 'M'
res.table$sex[res.table$sex==gender.levels[3]] <- 'F'

t_fname <- file.path(ma.settings$dir.base, "results", "GAMLSS_models_table.csv")
cat('Table:', t_fname, '\n')
write.table(x=res.table, file=t_fname, sep='\t', col.names=T, row.names=F, quote=F)

# m <- models[['fit.all']]
# m$family[2]
head(res.table)
