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
# dataset <- 'volLiver_age'
# dataset <- 'volLiverkg_age'
# dataset <- 'volLiver_BSA'
# dataset <- 'volLiver_bodyweight'
# dataset <- 'flowLiver_age'
# dataset <- 'flowLiverkg_age'
# dataset <- 'perfusion_age'
dataset <- 'flowLiver_volLiver'
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
create_plots = TRUE
startDevPlot <- function(width=2000, height=1000, file=NULL){
  if (is.null(file)){
    file <- file.path(ma.settings$dir.results, 'regression', sprintf('%s_%s_regression.png', yname, xname))
  }
  if (create_plots == T) { 
    print(file)
    png(filename=file, width=width, height=height, 
        units = "px", bg = "white",  res = 150)
  }
  print('No plot files created')
}
stopDevPlot <- function(){
  if (create_plots == T) { dev.off() }
}
################################################################################

## load data ##
fname <- file.path(ma.settings$dir.expdata, "processed", sprintf("%s_%s.Rdata", yname, xname))
print(fname)
load(file=fname)
names(data)[names(data) == 'gender'] <- 'sex'
head(data)

data <- na.omit(data)

# prepare subsets
df.names <- c('all', 'male', 'female')
df.all <- data
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

df.cols <- c( rgb(0,0,0,alpha=0.5),
              rgb(0,0,1,alpha=0.5),
              rgb(1,0,0,alpha=0.5) )
names(df.cols) <- df.names 

table(df.all$study)

#######################################################
# Data overview
#######################################################
# startDevPlot(width=2000, height=1000)
par(mfrow=c(1,3))
for (k in 1:3){
  if (k==1){ d <- df.all }
  if (k==2){ d <- df.male }
  if (k==3){ d <- df.female }
  
  plot(d[[xname]], d[[yname]], col=df.cols[k], 
       main=sprintf('%s', df.names[k]), xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim)
  rug(d[[xname]], side=1, col="black"); rug(d[[yname]], side=2, col="black")
}
par(mfrow=c(1,1))
# stopDevPlot()
rm(d,k)

#######################################################
# GAMLSS - Model fitting
#######################################################
library('gamlss')

## GEC vs. age ########################################
if (dataset == 'GEC_age'){
  startDevPlot(width=650, height=1000)
  # simple model with normal distributed link function
  fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,1), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  
  fit.final <- fit.all.no
  plotCentiles(model=fit.final, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  stopDevPlot()
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

## volLiver vs. age ######################################
if (dataset == 'volLiver_age'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  ## all ##
  fit.all.no <- gamlss(volLiver ~ cs(age,4), sigma.formula= ~cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.all.no, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.no <- gamlss(volLiver ~ cs(age,6), sigma.formula= ~cs(age,3), family=NO, data=df.male)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  
  plotCentiles(model=fit.male.no, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  summary(fit.male.no)
  
  ## female ##
  fit.female.no <- gamlss(volLiver ~ cs(age,6), sigma.formula= ~cs(age,2), family=NO, data=df.female)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.female.no, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
}

## volLiverkg vs. age ######################################
if (dataset == 'volLiverkg_age'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  ## all ##
  fit.all.no <- gamlss(volLiverkg ~ cs(age,3), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.all.no, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.no <- gamlss(volLiverkg ~ cs(age,2), sigma.formula= ~cs(age,1), family=NO, data=df.male)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.male.no, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  summary(fit.male.no)
  
  ## female ##
  fit.female.no <- gamlss(volLiverkg ~ cs(age,2), sigma.formula= ~cs(age,1), family=NO, data=df.female)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.female.no, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
}

## volLiver vs. BSA ######################################
if (dataset == 'volLiver_BSA'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  ## all ##
  # fit.all.no <- gamlss(volLiver ~ cs(BSA,3), sigma.formula= ~cs(BSA,3), family=NO, data=df.all)
  fit.all.bccg <- gamlss(volLiver ~ cs(BSA,3), sigma.formula= ~cs(BSA,3), nu.formula= ~cs(BSA,1) family=BCCG, data=df.all)
  plotCentiles(model=fit.all.bccg, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.no <- gamlss(volLiver ~ cs(BSA,2), family=NO, data=df.male)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.male.no, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  summary(fit.male.no)
  
  ## female ##
  fit.female.no <- gamlss(volLiver ~ cs(BSA,1), family=NO, data=df.female)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.female.no, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
}

## volLiver vs. bodyweight ######################################
if (dataset == 'volLiver_bodyweight'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  head(df.all)
  ## all ##
  # fit.all.no <- gamlss(volLiver ~ cs(BSA,3), sigma.formula= ~cs(BSA,3), family=NO, data=df.all)
  fit.all.no <- gamlss(volLiver ~ cs(bodyweight,2), sigma.formula= ~cs(bodyweight,2), family=NO, data=df.all)
  plotCentiles(model=fit.all.no, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.no <- gamlss(volLiver ~ cs(bodyweight,2), family=NO, data=df.male)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.male.no, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  summary(fit.male.no)
  
  ## female ##
  fit.female.no <- gamlss(volLiver ~ cs(bodyweight,2), family=NO, data=df.female)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.female.no, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
}

## flowLiver vs. age ######################################
if (dataset == 'flowLiver_age'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  head(df.all)
  ## all ##
  fit.all.bccg <- gamlss(flowLiver ~ cs(age,2), sigma.formula= ~cs(age,2), family=BCCG, data=df.all)
  plotCentiles(model=fit.all.bccg, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  
  ## male ##
  fit.male.bccg <- gamlss(flowLiver ~ cs(age,2), sigma.formula= ~cs(age,1), family=BCCG, data=df.male)
  plotCentiles(model=fit.male.bccg, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  summary(fit.male.no)
  
  ## female ##
  fit.female.bccg <- gamlss(flowLiver ~ cs(age,2), sigma.formula= ~cs(age,1), family=BCCG, data=df.female)
  # fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
  # fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
  plotCentiles(model=fit.female.bccg, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
}

## flowLiver vs. volLiver ######################################
if (dataset == 'flowLiver_volLiver'){
  startDevPlot(width=2000, height=1000)
  par(mfrow=c(1,3))
  head(df.all)
  ## all ##
  fit.all.no <- gamlss(flowLiver ~ cs(volLiver,1), sigma.formula= ~cs(volLiver,2), family=NO, data=df.all)
  plotCentiles(model=fit.all.no, d=df.all, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['all']])
  ## male ##
  fit.male.no <- gamlss(flowLiver ~ cs(volLiver,1), sigma.formula= ~cs(volLiver,1), family=NO, data=df.male)
  plotCentiles(model=fit.male.no, d=df.male, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['male']])
  ## female ##
  fit.female.no <- gamlss(flowLiver ~ cs(volLiver,1), sigma.formula= ~cs(volLiver,1), family=NO, data=df.female)
  plotCentiles(model=fit.female.no, d=df.female, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[['female']])
  par(mfrow=c(1,1))
  stopDevPlot()
}

#######################################################
# GAMLSS - Model selection
#######################################################


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







summary(fit.all.no)
plot(fit.all.no)
centiles(fit.all.no,  xvar=df.all$age)
fittedPlot(fit.all.no, x=df.all$age)

# using LMS based link distribution (BCCG - Box-Cox, Cole and Green)
fit.all.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df.all)
fit.all.bccg.1 <- gamlss(bsa ~ cs(age,6), 
                         sigma.formula= ~cs(age,3), nu.formula= ~cs(age,3), 
                         family=BCCG, data=df.all)

summary(fit.all.bccg)
plot(fit.all.bccg)
centiles(fit.all.bccg,  xvar=df.all$age)
fittedPlot(fit.all.bccg, x=df.all$age)
summary(fit.all.bccg.1)
plot(fit.all.bccg.1)
centiles(fit.all.bccg.1,  xvar=df.all$age)
fittedPlot(fit.all.bccg.1, x=df.all$age)

# final models after selection
fit.all.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df.all)
centiles(fit.all.bccg,  xvar=df.all$age)

fit.male.bccg <- gamlss(bsa ~ cs(age,6), sigma.formula= ~cs(age,3), family=BCCG, data=df.male)
centiles(fit.male.bccg,  xvar=df.male$age)

fit.female.bccg <- gamlss(bsa ~ cs(age,9), sigma.formula= ~cs(age,3), family=BCCG, data=df.female)
centiles(fit.female.bccg,  xvar=df.female$age)

fit.final <- list(fit.all.bccg, fit.male.bccg, fit.female.bccg) 
