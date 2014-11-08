################################################################################
# Centile estimation for other datasets with GAMLSS
################################################################################
# http://www.gamlss.org/?p=1215
# Fitting statistical model todata.
# These models are linked and used for prediction.
#
# author: Matthias Koenig
# date: 14-10-2014
################################################################################
library('MultiscaleAnalysis')
setwd('/home/mkoenig/multiscale-galactose/')
rm(list = ls())
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))

################################################################################
# dataset <- 'GEC_age'
# dataset <- 'GECkg_age'

dataset <- 'volLiver_age'
# dataset <- 'volLiverkg_age'
# dataset <- 'volLiver_bodyweight'
# dataset <- 'volLiver_height'
# dataset <- 'volLiver_BSA'

# dataset <- 'flowLiver_volLiver'
# dataset <- 'flowLiverkg_volLiver'
# dataset <- 'flowLiver_age'
# dataset <- 'flowLiverkg_age'
# dataset <- 'flowLiverkg_bodyweight'
#dataset <- 'perfusion_age'

# dataset <- 'volLiver_flowLiver'
################################################################################
# Plot helpers
name.parts <- strsplit(dataset, '_')
xname <- name.parts[[1]][2]
yname <- name.parts[[1]][1]
rm(name.parts)
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)

# Plot to file
create_plots = FALSE
startDevPlot <- function(width=2000, height=1000, file=NULL){
  if (is.null(file)){
    file <- file.path(ma.settings$dir.results, 'regression', sprintf('%s_%s_regression.png', yname, xname))
  }
  if (create_plots == T) { 
    print(file)
    png(filename=file, width=width, height=height, 
        units = "px", bg = "white",  res = 150)
  } else { print('No plot files created') }
}
stopDevPlot <- function(){
  if (create_plots == T) { dev.off() }
}

################################################################################
## load data ##
fname <- file.path(ma.settings$dir.expdata, "processed", sprintf("%s_%s.Rdata", yname, xname))
print(fname)
load(file=fname)
head(data)

# data processing
names(data)[names(data) == 'gender'] <- 'sex'
data <- na.omit(data) # remove NA
data$weights <- 1   # population data is weighted 0.25
data$weights[data$dtype=='population'] = 0.1
data$study <- as.factor(data$study)
data$sex <- as.factor(data$sex)
data$dtype <- as.factor(data$dtype)

# prepare subsets
df.names <- c('all', 'male', 'female')
df.all <- data
# reduce data tp the individual data for first analysis
df.all <- df.all[df.all$dtype=="individual", ]

# some preprocessing
if (dataset == 'GEC_age'){
  # problems with non Marchesini data,
  # data far away and very large spread
  df.all <- df.all[df.all$sex=='all',]
}
if (dataset == 'volLiver_BSA'){
  # cutoff based on the NHANES normal range
  df.all <- df.all[df.all$BSA<=2.5,]
}
df.male <- df.all[df.all$sex == 'male', ]
df.female <- df.all[df.all$sex == 'female', ]
rm(data)

#######################################################
# Plot basic data overview
#######################################################
create_plots = F
sprintf("/home/mkoenig/Desktop/data/%s_%s.png", xname, yname)
startDevPlot(width=2000, height=1000, file=sprintf("/home/mkoenig/Desktop/data/%s_%s.png", yname, xname))
par(mfrow=c(1,3))
for (k in 1:3){
  if (k==1){ d <- df.all }
  if (k==2){ d <- df.male }
  if (k==3){ d <- df.female }
  
  plot(d[, xname], d[, yname], type='n',
       main=sprintf('%s', df.names[k]), xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim)
  
  inds.po <- which(d$dtype == 'population')
  points(d[inds.po, xname], d[inds.po, yname], col=df.cols.po[k], pch=df.symbols[k])
  inds.in <- which(d$dtype == 'individual')
  points(d[inds.in, xname], d[inds.in, yname], col=df.cols[k], bg=df.cols[k], pch=df.symbols[k])
  
  rug(d[inds.in, xname], side=1, col="black"); rug(d[inds.in, yname], side=2, col="black")
}
par(mfrow=c(1,1))
stopDevPlot()
rm(d,k)

################################################################################
# GAMLSS - Model fitting
################################################################################
library('gamlss')

# Save models
saveFitModels <- function(models, xname, yname, dir=NULL){
    if (is.null(dir)){
        dir <- file.path(ma.settings$dir.expdata, "processed")
    }
    r_fname <- file.path(dir, sprintf('%s_%s_models.Rdata', yname, xname))
    print( sprintf('%s vs. %s -> %s', yname, xname, r_fname) )
    save('models', file=r_fname)
}
create_plots=TRUE

# TODO: fix the model liver ~ age problems.
# TODO: always fit a good model for mu first and use as starting point for mu, sigma 
# model

## GEC vs. age ########################################
create_plots=T
if (dataset == 'GEC_age'){
  startDevPlot(width=650, height=1000)
  # all #
  fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,1), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  
  fit.all <- fit.all.no
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  stopDevPlot()
  
  # male #
  fit.male <- NULL
  # female #
  fit.female <- NULL
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## GECkg vs. age ######################################
if (dataset == 'GECkg_age'){
  startDevPlot(width=650, height=1000)
  # simple model with normal distributed link function
  fit.all.no <- gamlss(GECkg ~ cs(age,4), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  
  fit.final <- fit.all.no
  plotCentiles(model=fit.final, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  stopDevPlot()
}

head(df.all)

## volLiver vs. age ######################################
if (dataset == 'volLiver_age'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  ## all ##    
  fit.all <- gamlss(volLiver ~ cs(age,3), family=BCCG, data=df.all)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  newdata <- data.frame(age=c(20))
  mu <- predict(fit.all, what = "mu", type = "response", newdata=newdata, data=df.all)
  
  ## male ##
  fit.male <- gamlss(volLiver ~ cs(age,3), sigma.formula=~age ,family=BCCG, data=df.male)
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  
  newdata <- data.frame(age=c(20))
  mu <- predict(fit.male, what = "mu", type = "response", newdata=newdata, data=df.male)
  
  ## female ##
  fit.female <- gamlss(volLiver ~ cs(age,3), family=BCCG, data=df.female)
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## volLiverkg vs. age ######################################
if (dataset == 'volLiverkg_age'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  ## all ##
  fit.all <- gamlss(volLiverkg ~ cs(age,1), family=BCCG, data=df.all)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  ## male ##
  fit.male <- gamlss(volLiverkg ~ cs(age,1), family=BCCG, data=df.male)
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  ## female ##
  fit.female <- gamlss(volLiverkg ~ cs(age,1), family=BCCG, data=df.female)
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## volLiver vs. BSA ######################################
if (dataset == 'volLiver_BSA'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  ## all ##
  fit.all <- gamlss(volLiver ~ cs(BSA,2), sigma.formula= ~cs(BSA,1), family=NO, data=df.all)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  ## male ##
  fit.male <- gamlss(volLiver ~ cs(BSA,2), sigma.formula= ~cs(BSA,1), family=NO, data=df.male)
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  ## female ##
  fit.female <- gamlss(volLiver ~ cs(BSA,2), sigma.formula= ~cs(BSA,1), family=NO, data=df.female)
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## volLiver vs. bodyweight ######################################
if (dataset == 'volLiver_bodyweight'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  ## all ##
  fit.all.no <- gamlss(volLiver ~ cs(bodyweight,2), sigma.formula= ~cs(bodyweight,2), family=NO, data=df.all)
  fit.all <- fit.all.no
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.no <- gamlss(volLiver ~ cs(bodyweight,2), sigma.formula= ~cs(bodyweight,1), family=NO, data=df.male)
  fit.male <- fit.male.no
  plotCentiles(model=fit.male.no, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  
  ## female ##
  fit.female.no <- gamlss(volLiver ~ cs(bodyweight,2), sigma.formula= ~cs(bodyweight,1), family=NO, data=df.female)
  fit.female <- fit.female.no
  plotCentiles(model=fit.female.no, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## flowLiver vs. age ######################################
create_plots=T
if (dataset == 'flowLiver_age'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  head(df.all); tail(df.all)
  
  ## all ##
  # fit.all.bccg <- gamlss(flowLiver ~ cs(age,3), sigma.formula= ~cs(age,1), family=BCCG, weights=weights, data=df.all)
  fit.all.bccg <- gamlss(flowLiver ~ cs(age,5), sigma.formula= ~cs(age,1), family=BCCG, weights=weights, data=df.all)
  fit.all <- fit.all.bccg
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  summary(fit.all)
  
  ## male ##
  fit.male.bccg <- gamlss(flowLiver ~ cs(age,4), sigma.formula= ~cs(age,1), family=BCCG, data=df.male)
  fit.male <- fit.male.bccg
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  
  ## female ##
  summary(df.female)
  fit.female.bccg <- gamlss(flowLiver ~ cs(age,4), sigma.formula= ~cs(age,1), family=BCCG, data=df.female)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  fit.female <- fit.female.bccg
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## flowLiverkg vs. age ######################################
create_plots=T
if (dataset == 'flowLiverkg_age'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  
  ## all ##
  fit.all.no <- gamlss(flowLiverkg ~ cs(age,1), sigma.formula= ~age, family=NO, weights=weights, data=df.all)
  fit.all <- fit.all.no
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.no <- gamlss(flowLiverkg ~ cs(age,1), sigma.formula= ~cs(age,1), family=NO, data=df.male)
  fit.male <- fit.male.no
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  
  ## female ##
  fit.female.no <- gamlss(flowLiverkg ~ cs(age,1), family=NO, data=df.female)
  fit.female <- fit.female.no
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## flowLiver vs. volLiver ######################################
create_plots=T
if (dataset == 'flowLiver_volLiver'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  head(df.all)
  ## all ##
  fit.all.no <- gamlss(flowLiver ~ volLiver, sigma.formula= ~cs(volLiver,1), family=NO, data=df.all)
  fit.all <- fit.all.no
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  ## male ##
  fit.male.no <- gamlss(flowLiver ~ volLiver, sigma.formula= ~volLiver, family=NO, data=df.male)
  fit.male <- fit.male.no
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  ## female ##
  fit.female.no <- gamlss(flowLiver ~ volLiver, sigma.formula= ~cs(volLiver,1), family=NO, data=df.female)
  fit.female <- fit.female.no
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## flowLiverkg vs. bodyweight ######################################
create_plots=T
if (dataset == 'flowLiverkg_bodyweight'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  
  ## all ##
  fit.all.no <- gamlss(flowLiverkg ~lo(~bodyweight, span=0.6), sigma.formula= ~cs(bodyweight,2), family=NO, weights=weights, data=df.all)
  #fit.all.no <- gamlss(flowLiverkg ~cs(bodyweight, df=5),sigma.formula= ~cs(bodyweight,1), family=NO, weights=weights, data=df.all)
  fit.all <- fit.all.no
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.no <- gamlss(flowLiverkg ~ bodyweight, family=NO, data=df.male)
  fit.male <- fit.male.no
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  
  ## female ##
  fit.female.no <- gamlss(flowLiverkg ~ bodyweight, family=NO, data=df.female)
  fit.female <- fit.female.no
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}



#######################################################
# GAMLSS - Model selection
#######################################################
# TODO
# optimize degree of freedoms based on BIC (Baysian information criterium)
#   fn.SBC.female <- function(p) {
#       AIC(gamlss(volLiver ~ cs(age, df = p[1]), data=df.female, trace = FALSE, family=NO), k = log(nrow(df.female)))
#   }
#   opSBC <- optim(par=c(4), fn.SBC.female, method = "L-BFGS-B", lower = c(1), upper = c(6))

#######################################################
# GAMLSS - Confidence intervals
#######################################################
# Bootstrap intervals

# Using multcomp
# artax.karlin.mff.cuni.cz/r-help/library/BSagri/
library(gamlss)
install.packages("multcomp")
library(multcomp)

comps <- glht(modelfit2, mcp(Treatment="Tukey"))
CIs2<-CIGLM(comps2, method="Raw")
CIs2

CIsAdj2<-CIGLM(comps2, method="Adj")
CIsAdj2

CIsBonf2<-CIGLM(comps2, method="Bonf")
CIsBonf2

