################################################################################
# Centile estimation & model building with GAMLSS
################################################################################
# http://www.gamlss.org/?p=1215
# Fitting of GAMLSS statistical models to the underlying datasats. These are 
# the models used for the individual predictions of the 2D correlations.
#
# TODO: cross-validation of model fits
# TODO: create GAMLSS model table (which studies, how many data points)
#
# author: Matthias Koenig
# date: 2014-11-26
################################################################################

if (!exists('dataset')){
  # clean start
  rm(list = ls())
  create_plots = TRUE
  
  # dataset <- 'GEC_age'
  # dataset <- 'GECkg_age'

  # dataset <- 'volLiver_age'
  # dataset <- 'volLiverkg_age'
  # dataset <- 'volLiver_bodyweight'
  # dataset <- 'volLiverkg_bodyweight'
  # dataset <- 'volLiver_height'
  # dataset <- 'volLiverkg_height'
  # dataset <- 'volLiver_BSA'
  # dataset <- 'volLiverkg_BSA'

  # dataset <- 'flowLiver_volLiver'
  # dataset <- 'flowLiverkg_volLiverkg'
  # dataset <- 'perfusion_age'

  # dataset <- 'flowLiver_age'
  # dataset <- 'flowLiverkg_age'
  # dataset <- 'flowLiver_bodyweight'
  # dataset <- 'flowLiverkg_bodyweight'
  # dataset <- 'flowLiver_BSA'
  # dataset <- 'flowLiverkg_BSA'
} else {
  create_plots = TRUE
}

################################################################################
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))

# Plot helpers
names <- createXYNameFromDatasetName(dataset)
xname <- names$xname
yname <- names$yname
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)

# Plot to file
startDevPlot <- function(width=2000, height=1000, file=NULL){
  if (create_plots == T) { 
    print(file)
    png(filename=file, width=width, height=height, 
        units = "px", bg = "white",  res = 150)
  } else { print('No plot files created') }
}
stopDevPlot <- function(){
  if (create_plots == T) { dev.off() }
}

#######################################################
# Data preprocessing
#######################################################
fname <- file.path(ma.settings$dir.base, "results", 'correlations', sprintf("%s_%s.Rdata", yname, xname))
print(fname)
load(file=fname)

# data processing (change names, remove NAs, create factors)
names(data)[names(data) == 'gender'] <- 'sex'
data <- na.omit(data)
data$study <- as.factor(data$study)
data$sex <- as.factor(data$sex)
data$dtype <- as.factor(data$dtype)

# weighting of data points in regression
data$weights <- 1 
data$weights[data$dtype=='population'] = 0.1 # data from population studies is less weighted (not used in regression)
data$weights[data$study=="cat2010"] = 0.1    # indirect measured data (flow via cardiac output), is weighted less
data$weights[data$study=="sim1997"] = 0.1    # indirect measured data (flow via cardiac output), is weighted less
data$weights[data$study=="ircp2001"] = 10    # the very few data points for flow in children are weighted more
table(data$weights)

# reduce data tp the individual points (no population data used)
data <- data[data$dtype=="individual", ]

# prepare subsets
df.names <- c('all', 'male', 'female')
df.all <- data
df.male <- df.all[df.all$sex == 'male', ]
df.female <- df.all[df.all$sex == 'female', ]
rm(data)

#######################################################
# Plot basic data overview
#######################################################
startDevPlot(width=2000, height=1000, 
             file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_raw.png", yname, xname)))
par(mfrow=c(1,3))
for (k in 1:3){
  if (k==1){ d <- df.all }
  if (k==2){ d <- df.male }
  if (k==3){ d <- df.female }
  
  plot(d[, xname], d[, yname], type='n',
       main=sprintf('%s', df.names[k]), xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim)
  
  inds.po <- which(d$dtype == 'population')
  points(d[inds.po, xname], d[inds.po, yname], col=gender.base_cols[k], pch=gender.symbols[k])
  inds.in <- which(d$dtype == 'individual')
  points(d[inds.in, xname], d[inds.in, yname], col=gender.cols[k], bg=gender.cols[k], pch=gender.symbols[k])
  
  rug(d[inds.in, xname], side=1, col="black"); rug(d[inds.in, yname], side=2, col="black")
}
par(mfrow=c(1,1))
stopDevPlot()
rm(d,k)

################################################################################
# GAMLSS - Model fitting
################################################################################
library('gamlss')

## GEC vs. age ########################################
if (dataset == 'GEC_age'){
  startDevPlot(width=650, height=1000,
               file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname))) 
  # all
  fit.all.nosigma <- gamlss(GEC ~ cs(age,2), family=NO, weights=weights, data=df.all)
  fit.all <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,1), family=NO, weights=weights, data=df.all, start.from=fit.all.nosigma)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['all']])
  # male
  fit.male <- NULL
  # female
  fit.female <- NULL
  stopDevPlot()
  
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## GECkg vs. age ######################################
if (dataset == 'GECkg_age'){
  startDevPlot(width=650, height=1000,
               file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
  # all
  fit.all.nosigma <- gamlss(GECkg ~ cs(age,4), family=NO, weights=weights, data=df.all)
  fit.all <- gamlss(GECkg ~ cs(age,4), sigma.formula= ~age, family=NO, weights=weights, data=df.all, start.from=fit.all.nosigma)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['all']])
  # male
  fit.male <- NULL
  # female
  fit.female <- NULL
  stopDevPlot()
  
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## volLiver vs. age ######################################
if (dataset == 'volLiver_age'){    
  startDevPlot(width=2000, height=1000,
               file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
  par(mfrow=c(1,3))
  # all
  fit.all.nosigma <- gamlss(volLiver ~ cs(age,4), family=BCCG, weights=weights, data=df.all)
  fit.all <- gamlss(volLiver ~ cs(age,4), sigma.formula=~age, family=BCCG, weights=weights, data=df.all, start.from=fit.all.nosigma)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['all']])
  # test predictions
  mu <- predict(fit.all, what = "mu", type = "response", newdata=data.frame(age=c(20)), data=df.all)
  # male
  fit.male.nosigma <- gamlss(volLiver ~ cs(age,4), family=BCCG, weights=weights, data=df.male)
  fit.male <- gamlss(volLiver ~ cs(age,4), sigma.formula=~age, family=BCCG, weights=weights, data=df.male, start.from=fit.male.nosigma)
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['male']])
  # female
  fit.female <- gamlss(volLiver ~ cs(age,4), family=BCCG, weights=weights, data=df.female)
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## volLiverkg vs. age ######################################
if (dataset == 'volLiverkg_age'){
  startDevPlot(width=2000, height=1000,
               file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
  par(mfrow=c(1,3))
  # all
  fit.all <- gamlss(volLiverkg ~ cs(age,1), family=BCCG, weights=weights, data=df.all, method=mixed(2,10))
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['all']])
  # male
  fit.male <- gamlss(volLiverkg ~ cs(age,1), family=BCCG, weights=weights, data=df.male, method=mixed(2,10))
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['male']])
  # female
  fit.female <- gamlss(volLiverkg ~ cs(age,1), family=BCCG, weights=weights, data=df.female, method=mixed(2,10))
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  # save Models
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## volLiver vs. bodyweight ######################################
if (dataset == 'volLiver_bodyweight'){
    startDevPlot(width=2000, height=1000,
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all.nosigma <- gamlss(volLiver ~ cs(bodyweight,2), family=BCCG, weights=weights, data=df.all)
    fit.all <- gamlss(volLiver ~ cs(bodyweight,2), sigma.formula= ~bodyweight, family=BCCG, weights=weights, data=df.all, start.from=fit.all.nosigma)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male.nosigma <- gamlss(volLiver ~ cs(bodyweight,2), family=BCCG, weights=weights, data=df.male)
    fit.male <- gamlss(volLiver ~ cs(bodyweight,2), sigma.formula= ~bodyweight, family=BCCG, weights=weights, data=df.male, start.from=fit.male.nosigma)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    
    # female
    fit.female.nosigma <- gamlss(volLiver ~ cs(bodyweight,2), family=BCCG, weights=weights, data=df.female)
    fit.female <- gamlss(volLiver ~ cs(bodyweight,2), sigma.formula= ~cs(bodyweight,1), family=BCCG, weights=weights, data=df.female, start.from=fit.female.nosigma)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## volLiverkg vs. bodyweight ######################################
if (dataset == 'volLiverkg_bodyweight'){
    startDevPlot(width=2000, height=1000,
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all.nosigma <- gamlss(volLiverkg ~ cs(bodyweight,2), family=BCCG, weights=weights, data=df.all, method=mixed(2,10))
    fit.all <- gamlss(volLiverkg ~ cs(bodyweight,2), sigma.formula= ~bodyweight, family=BCCG, weights=weights, data=df.all, start.from=fit.all.nosigma, method=mixed(2,10))
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male.nosigma <- gamlss(volLiverkg ~ cs(bodyweight,2), family=BCCG, weights=weights, data=df.male, method=mixed(2,10))
    fit.male <- gamlss(volLiverkg ~ cs(bodyweight,2), sigma.formula= ~bodyweight, family=BCCG, weights=weights, data=df.male, start.from=fit.male.nosigma, method=mixed(2,10))
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female.nosigma <- gamlss(volLiverkg ~ cs(bodyweight,2), family=BCCG, weights=weights, data=df.female, method=mixed(2,10))
    fit.female <- gamlss(volLiverkg ~ cs(bodyweight,2), sigma.formula= ~bodyweight, family=BCCG, weights=weights, data=df.female, start.from=fit.female.nosigma, method=mixed(2,10))
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## volLiver vs. height ######################################
if (dataset == 'volLiver_height'){
    startDevPlot(width=2000, height=1000,
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all.nosigma <- gamlss(volLiver ~ cs(height,5), family=BCCG, weights=weights, data=df.all)
    fit.all <- gamlss(volLiver ~ cs(height,5), sigma.formula= ~height, family=BCCG, weights=weights, data=df.all, start.from=fit.all.nosigma)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male.nosigma <- gamlss(volLiver ~ cs(height,5), family=BCCG, weights=weights, data=df.male)
    fit.male <- gamlss(volLiver ~ cs(height,5), sigma.formula= ~height, family=BCCG, weights=weights, data=df.male, start.from=fit.male.nosigma)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    
    # female
    fit.female.nosigma <- gamlss(volLiver ~ cs(height,4), family=BCCG, weights=weights, data=df.female)
    fit.female <- gamlss(volLiver ~ cs(height,4), sigma.formula= ~height, family=BCCG, weights=weights, data=df.female, start.from=fit.female.nosigma)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## volLiverkg vs. height ######################################
if (dataset == 'volLiverkg_height'){
    startDevPlot(width=2000, height=1000,
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all <- gamlss(volLiverkg ~ cs(height,2), family=BCCG, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(volLiverkg ~ cs(height,2), family=BCCG, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(volLiverkg ~ cs(height,2), family=BCCG, weights=weights, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## volLiver vs. BSA ######################################
if (dataset == 'volLiver_BSA'){
  startDevPlot(width=2000, height=1000,
               file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
  par(mfrow=c(1,3))
  # all
  fit.all.nosigma <- gamlss(volLiver ~ cs(BSA,3), family=BCCG, weights=weights, data=df.all)
  fit.all <- gamlss(volLiver ~ cs(BSA,3), sigma.formula= ~cs(BSA,1), family=BCCG, weights=weights, data=df.all, start.from=fit.all.nosigma)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['all']])
  # male
  fit.male.nosigma <- gamlss(volLiver ~ cs(BSA,3), family=BCCG, weights=weights, data=df.male)
  fit.male <- gamlss(volLiver ~ cs(BSA,3), sigma.formula= ~cs(BSA,1), family=BCCG, weights=weights, data=df.male, start.from=fit.male.nosigma)
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['male']])
  # female
  fit.female.nosigma <- gamlss(volLiver ~ cs(BSA,3), family=BCCG, weights=weights, data=df.female)
  fit.female <- gamlss(volLiver ~ cs(BSA,3), sigma.formula= ~cs(BSA,1), family=BCCG, weights=weights, data=df.female, start.from=fit.female.nosigma)
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
  
  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## volLiverkg vs. BSA ######################################
if (dataset == 'volLiverkg_BSA'){
    startDevPlot(width=2000, height=1000, 
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all <- gamlss(volLiverkg ~ cs(BSA,2), family=BCCG, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(volLiverkg ~ cs(BSA,2), family=BCCG, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(volLiverkg ~ cs(BSA,2), family=BCCG, weights=weights, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## flowLiver vs. volLiver ######################################
if (dataset == 'flowLiver_volLiver'){
    startDevPlot(width=2000, height=1000, 
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))

    # all
    fit.all <- gamlss(flowLiver ~ volLiver, sigma.formula= ~cs(volLiver,1), family=NO, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(flowLiver ~ volLiver, sigma.formula= ~volLiver, family=NO, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(flowLiver ~ volLiver, sigma.formula= ~cs(volLiver,1), family=NO, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## flowLiverkg vs. volLiverkg ######################################
if (dataset == 'flowLiverkg_volLiverkg'){
    startDevPlot(width=2000, height=1000, 
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    
    # all
    fit.all <- gamlss(flowLiverkg ~ volLiverkg, sigma.formula= ~cs(volLiverkg,1), family=NO, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(flowLiverkg ~ volLiverkg, sigma.formula= ~volLiverkg, family=NO, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(flowLiverkg ~ volLiverkg, sigma.formula= ~volLiverkg, family=NO, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## perfusion vs. age ######################################
if (dataset == 'perfusion_age'){
    startDevPlot(width=2000, height=1000, 
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all <- gamlss(perfusion ~ age, family=NO, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(perfusion ~ age, family=NO, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(perfusion ~ age, family=NO, weights=weights, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## flowLiver vs. age ######################################
if (dataset == 'flowLiver_age'){
  startDevPlot(width=2000, height=1000,
               file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
  par(mfrow=c(1,3))
  # all
  fit.all.nosigma <- gamlss(flowLiver ~ cs(age,5), family=BCCG, weights=weights, data=df.all)
  fit.all <- gamlss(flowLiver ~ cs(age,5), sigma.formula= ~cs(age,1), family=BCCG, weights=weights, data=df.all, start.from=fit.all.nosigma)
  plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['all']])
  # male
  fit.male.nosigma <- gamlss(flowLiver ~ cs(age,4), family=BCCG, weights=weights, data=df.male)
  fit.male <- gamlss(flowLiver ~ cs(age,4), sigma.formula= ~cs(age,1), family=BCCG, weights=weights, data=df.male, start.from=fit.male.nosigma)
  plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['male']])
  # female
  fit.female.nosigma <- gamlss(flowLiver ~ cs(age,4), family=BCCG, weights=weights, data=df.female)
  fit.female <- gamlss(flowLiver ~ cs(age,4), sigma.formula= ~cs(age,1), family=BCCG, weights=weights, data=df.female, start.from=fit.female.nosigma)
  plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=gender.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()

  models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                 df.all=df.all, df.male=df.male, df.female=df.female)
  saveFitModels(models, xname, yname)
}

## flowLiverkg vs. age ######################################
if (dataset == 'flowLiverkg_age'){
    startDevPlot(width=2000, height=1000,
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))  
    # all
    fit.all <- gamlss(flowLiverkg ~ cs(age,5), family=BCCG, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(flowLiverkg ~ cs(age,4), family=BCCG, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(flowLiverkg ~ cs(age,4), family=BCCG, weights=weights, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    # save models
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## flowLiver vs. bodyweight ######################################
if (dataset == 'flowLiver_bodyweight'){
    startDevPlot(width=2000, height=1000,
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all <- gamlss(flowLiver ~ cs(bodyweight,3), family=BCCG, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(flowLiver ~ cs(bodyweight,3), family=BCCG, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(flowLiver ~ cs(bodyweight,3), family=BCCG, weights=weights, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()

    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## flowLiverkg vs. bodyweight ######################################
if (dataset == 'flowLiverkg_bodyweight'){
    startDevPlot(width=2000, height=1000, 
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all <- gamlss(flowLiverkg ~cs(bodyweight, 2), family=BCCG, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(flowLiverkg ~cs(bodyweight, 2), family=BCCG, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(flowLiverkg ~cs(bodyweight, 2), family=BCCG, weights=weights, data=df.female, method=mixed(2,10))
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## flowLiver vs. BSA ######################################
if (dataset == 'flowLiver_BSA'){
    startDevPlot(width=2000, height=1000, file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all <- gamlss(flowLiver ~ cs(BSA,2), family=BCCG, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(flowLiver ~ cs(BSA,2), family=BCCG, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(flowLiver ~ cs(BSA,2), family=BCCG, weights=weights, data=df.female)
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
    models <- list(fit.all=fit.all, fit.male=fit.male, fit.female=fit.female, 
                   df.all=df.all, df.male=df.male, df.female=df.female)
    saveFitModels(models, xname, yname)
}

## flowLiverkg vs. BSA ######################################
if (dataset == 'flowLiverkg_BSA'){
    startDevPlot(width=2000, height=1000,  
                 file=file.path(ma.settings$dir.base, 'results', 'gamlss', sprintf("%s_%s_models.png", yname, xname)))
    par(mfrow=c(1,3))
    # all
    fit.all <- gamlss(flowLiverkg ~cs(BSA, 2), family=BCCG, weights=weights, data=df.all)
    plotCentiles(model=fit.all, d=df.all, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['all']])
    # male
    fit.male <- gamlss(flowLiverkg ~cs(BSA, 2), family=BCCG, weights=weights, data=df.male)
    plotCentiles(model=fit.male, d=df.male, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['male']])
    # female
    fit.female <- gamlss(flowLiverkg ~cs(BSA, 2), family=BCCG, weights=weights, data=df.female, method=mixed(2,10))
    plotCentiles(model=fit.female, d=df.female, xname=xname, yname=yname,
                 main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
                 pcol=gender.cols[['female']])
    par(mfrow=c(1,1))
    stopDevPlot()
    
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
# library(gamlss)
# install.packages("multcomp")
# library(multcomp)
# 
# comps <- glht(modelfit2, mcp(Treatment="Tukey"))
# CIs2<-CIGLM(comps2, method="Raw")
# CIs2
# 
# CIsAdj2<-CIGLM(comps2, method="Adj")
# CIsAdj2
# 
# CIsBonf2<-CIGLM(comps2, method="Bonf")
# CIsBonf2

