################################################################################
# Prediction Evaluation
################################################################################
# Classification of subjects based on available GEC.
#
# author: Matthias Koenig
# date: 2014-12-05
################################################################################

# Perform the classification for GEC & GECkg

# 1. Create a prediction dataset consisting of GEC value & disease/health state
# i.e. dataset which can be used for classification

# load the correlation data



rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)




# Read data into standard data frame for prediction.
prepare_data <- function(data, fields){
  df <- data.frame(matrix(NA, ncol=length(fields), nrow=nrow(data)) )
  names(df) <- fields
  for (k in 1:length(fields)){
    name <- fields[k]
    if (name %in% names(data)){
      df[ ,k] <- data[[name]] 
    }
  }
  return(df)
}

# Prepare data for the GEC prediction.
prepare_GEC_data <- function(name){
  fields <- c('study', 'gender', 'age', 'bodyweight', 'height', 'BSA', 
              'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg', 'GEC', 'GECkg', 'status')
  data <- loadRawData(name)
  df <- prepare_data(data, fields)
}

############################################
# GEC [mmol/min] & GECkg [mmol/min/kgbw] 
############################################
# install.packages('reshape')
# Additional status is necessary, i.e. healthy or disease so that the classification is working.

## tyg1963 (age, bodyweight, [GEC, GECkg])
## sch1986.tab1 (sex, age, bodyweight, [GEC, GECkg])
## win1965 (sex, age, bodyweight, BSA, flowLiver, [GEC, GECkg] [NOT USED]
## duc1979 (sex, age, bodyweight BSA, [GEC, GECkg])
## duf2005 (sex, age, [GEC, GECkg])
## sch1968.fig1 (age, [GECkg])
## lan2011 (age, [GECkg])

names <- c('mar1988', 'tyg1963', 'sch1986.tab1', 'duc1979', 'duf1992', 'sch1986.fig1', 'lan2011')
df.list <- list(length(names))
for (k in 1:length(names)){
  name <- names[k]
  df <- prepare_GEC_data(name)
  cat(nrow(df), '\n')
  df.list[[k]] <- df
}

library('reshape')
df <- reshape::merge_all(df.list)
head(df, 20)
df$status <- as.factor(df$status)
summary(df)
df$healthy = as.factor(df$status == 'healthy')
summary(df)

hist(df$GEC[df$healthy==TRUE], breaks =20, xlim=c(0,5), xlab=lab[['GEC']])
hist(df$GEC[df$healthy==FALSE], breaks =20, xlim=c(0,5), xlab=lab[['GEC']], col='red', add=TRUE)

hist(df$GECkg[df$healthy==TRUE], breaks =20, xlim=c(0,0.2), xlab=lab[['GECkg']])
hist(df$GECkg[df$healthy==FALSE], breaks =20, xlim=c(0,0.2), xlab=lab[['GECkg']], col='red', add=TRUE)
# TODO: check for disease data in the trainings data & use if available
# TODO: use Marchesini data



