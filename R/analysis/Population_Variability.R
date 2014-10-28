################################################################################
# Predict Population & Dataset variability in response
################################################################################
# Calculate the GEC population clearance capacity.
#
# author: Matthias Koenig
# date: 24-10-2014
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd('/home/mkoenig/multiscale-galactose/')
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))
dir <- file.path(ma.settings$dir.expdata, "processed")

####################################################
# GEC_age model 
####################################################
# simple example to test the prediction and data 
# generation from given model
dataset <- 'GEC_age'
name.parts <- strsplit(dataset, '_')
xname <- name.parts[[1]][2]
yname <- name.parts[[1]][1]
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)
rm(name.parts)
r_fname <- file.path(dir, sprintf('%s_%s_models.Rdata', yname, xname))
load(file=r_fname)
models.GEC_age <- models

# model and data
m1 <- models.GEC_age$fit.all
df.all <- models.GEC_age$df.all
plotCentiles(model=m1, d=df.all, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['all']])

# make predictions with the model
# via the respective 
summary(m1) # NO link
age.grid <- 20:100
GEC.mu <- predict(m1, what = "mu", type = "response", newdata=data.frame(age=age.grid))
GEC.sigma <- predict(m1, what = "sigma", type = "response", newdata=data.frame(age=age.grid))
points(age.grid, GEC.mu, col='blue', xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim)
for (k in 1:length(age.grid)){
    n=10
    points(rep(age.grid[k],n), rNO(n=n, mu=GEC.mu[k], sigma=GEC.sigma[k]), col='red', cex=0.4)
    # points(age[k], rnorm(n=1, mean=GEC.mu[k], sd=GEC.sigma[k]), col='red')
}

####################################################
# Population prediction NHANES
####################################################
# Now calculate the GEC distribution based on 
# molecular derived GEC curve with fitted distributions of liver volume 
# and blood flow variation
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
nhanes.all <- data
rm(data)
head(nhanes.all)
head(nhanes.all)
names(nhanes.all)[names(nhanes.all)=='RIDAGEYR'] <- 'age'
names(nhanes.all)[names(nhanes.all)=='RIAGENDR'] <- 'sex'
names(nhanes.all)[names(nhanes.all)=='BMXWT'] <- 'bodyweight'
nhanes.female <- nhanes.all[nhanes.all$sex=='female', ]
nhanes.male <- nhanes.all[nhanes.all$sex=='male', ]
names(nhanes.all)

f_GECml_perfusion <- function(perfusion){
  # GEC per volume liver tissue for given perfusion
  # function coming from the underlying detailed kinetic model
    GEC = log((perfusion*10 + 1)) # mmol/min/ml(liver)
    return(GEC)
}
perfusion.grid <- seq(from=0.3, to=1.5, by=0.05)
plot(perfusion.grid, f_GECml_perfusion(perfusion.grid), xlim=c(0,1.5), ylim=c(0, 3.5))

# population analysis
# create some examples
volLiver = 1800 # ml
flowLiver = 1500 # ml/min
perfusion = flowLiver/volLiver
perfusion

################################################################################
## [1] liver Volume ######
################################################################################
dataset <- 'volLiver_age'
name.parts <- strsplit(dataset, '_')
xname <- name.parts[[1]][2]
yname <- name.parts[[1]][1]
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)
rm(name.parts)
## load models ##
r_fname <- file.path(dir, sprintf('%s_%s_models.Rdata', yname, xname))
load(file=r_fname)
models.volLiver_age <- models
# all
m.volLiver_age.all <- models.volLiver_age$fit.all # BCCG
summary(m.volLiver_age.all)
df.all <- models.volLiver_age$df.all
plotCentiles(model=m.volLiver_age.all, d=df.all, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['all']])
# male
m.volLiver_age.male <- models.volLiver_age$fit.male # BCCG
summary(m.volLiver_age.male)
df.male <- models.volLiver_age$df.male
plotCentiles(model=m.volLiver_age.male, d=df.male, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['male']])
# female
m.volLiver_age.female <- models.volLiver_age$fit.female # BCCG
summary(m.volLiver_age.female)
df.female <- models.volLiver_age$df.female
plotCentiles(model=m.volLiver_age.female, d=df.female, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['female']])

# function to calculate liver Volume from age
f_volLiver_age <- function(age, sex, mean.value=FALSE){
  # Get model for sex
  if (sex == 'all'){
   m <- m.volLiver_age.all 
  }else if (sex == 'male'){
    m <- m.volLiver_age.male 
  }else if (sex == 'female'){
    m <- m.volLiver_age.female 
  }
  newdata <- data.frame(age=age)
  
  mu <- predict(m, what = "mu", type = "response", newdata=newdata)
  sigma <- predict(m, what = "sigma", type = "response", newdata=newdata)
  nu <- predict(m, what = "nu", type = "response", newdata=newdata)
  if (mean.value == TRUE){
    # calculate the predicted mean volume
    volLiver <- mu
  } else {
    volLiver <- rBCCG(n=nrow(newdata), mu=mu, sigma=sigma, nu=nu)
  }
  return(volLiver)
}

# Nhanes volume predictions
par(mfrow=c(1,3))
for (sex in c('all', 'male', 'female')){
  mname <- paste('m.volLiver_age.', sex, sep="")
  dname <- paste('df.', sex, sep="")
  rname <- paste('volLiver.', sex, sep="")
  rname.mu <- paste('volLiver.', sex, '.mu', sep="")
  m <- get(mname)
  d <- get(dname)
  newdata <- get(paste('nhanes.', sex, sep="") ) 
  
  # calculate the liver volumes based on age and gender
  plotCentiles(model=m, d=d, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[[sex]])
  # random selection from distribution
  assign(rname, f_volLiver_age(age=newdata$age, sex=sex, mean.value=FALSE) )
  points(newdata$age, get(rname), cex=0.5, col='orange')
  # mean value
  assign(rname.mu, f_volLiver_age(age=newdata$age, sex=sex, mean.value=TRUE) )
  points(newdata$age, get(rname.mu), col='red')
}
par(mfrow=c(1,1))

# set the volume
summary(volLiver.male)
str(volLiver.male)
nhanes.male$volLiver <- volLiver.male
nhanes.female$volLiver <- volLiver.female
# all liver volume is predicted from male & female
nhanes.all$volLiver <- NA
nhanes.all$volLiver[nhanes.all$sex=='male'] <- volLiver.male
nhanes.all$volLiver[nhanes.all$sex=='female'] <- volLiver.female
head(nhanes.all)
plot(nhanes.all$age, nhanes.all$volLiver, col=nhanes.all$sex)


################################################################################
## [1] liver bloodflow ######
################################################################################
dataset <- 'flowLiver_age'
name.parts <- strsplit(dataset, '_')
xname <- name.parts[[1]][2]
yname <- name.parts[[1]][1]
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)
rm(name.parts)
## load models ##
r_fname <- file.path(dir, sprintf('%s_%s_models.Rdata', yname, xname))
load(file=r_fname)
models.flowLiver_age <- models
# all
m.flowLiver_age.all <- models.flowLiver_age$fit.all # BCCG
summary(m.flowLiver_age.all)
df.all <- models.flowLiver_age$df.all
plotCentiles(model=m.flowLiver_age.all, d=df.all, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['all']])

# male
m.flowLiver_age.male <- models.flowLiver_age$fit.male # BCCG
summary(m.flowLiver_age.male)
df.male <- models.flowLiver_age$df.male
plotCentiles(model=m.flowLiver_age.male, d=df.male, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['male']])

## here

# female
m.volLiver_age.female <- models.volLiver_age$fit.female # BCCG
summary(m.volLiver_age.female)
df.female <- models.volLiver_age$df.female
plotCentiles(model=m.volLiver_age.female, d=df.female, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['female']])

# function to calculate liver Volume from age
f_volLiver_age <- function(age, sex, mean.value=FALSE){
  # Get model for sex
  if (sex == 'all'){
    m <- m.volLiver_age.all 
  }else if (sex == 'male'){
    m <- m.volLiver_age.male 
  }else if (sex == 'female'){
    m <- m.volLiver_age.female 
  }
  newdata <- data.frame(age=age)
  
  mu <- predict(m, what = "mu", type = "response", newdata=newdata)
  sigma <- predict(m, what = "sigma", type = "response", newdata=newdata)
  nu <- predict(m, what = "nu", type = "response", newdata=newdata)
  if (mean.value == TRUE){
    # calculate the predicted mean volume
    volLiver <- mu
  } else {
    volLiver <- rBCCG(n=nrow(newdata), mu=mu, sigma=sigma, nu=nu)
  }
  return(volLiver)
}

# Nhanes volume predictions
par(mfrow=c(1,3))
for (sex in c('all', 'male', 'female')){
  mname <- paste('m.volLiver_age.', sex, sep="")
  dname <- paste('df.', sex, sep="")
  rname <- paste('volLiver.', sex, sep="")
  rname.mu <- paste('volLiver.', sex, '.mu', sep="")
  m <- get(mname)
  d <- get(dname)
  newdata <- get(paste('nhanes.', sex, sep="") ) 
  
  # calculate the liver volumes based on age and gender
  plotCentiles(model=m, d=d, xname=xname, yname=yname,
               main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
               pcol=df.cols[[sex]])
  # random selection from distribution
  assign(rname, f_volLiver_age(age=newdata$age, sex=sex, mean.value=FALSE) )
  points(newdata$age, get(rname), cex=0.5, col='orange')
  # mean value
  assign(rname.mu, f_volLiver_age(age=newdata$age, sex=sex, mean.value=TRUE) )
  points(newdata$age, get(rname.mu), col='red')
}
par(mfrow=c(1,1))





# [3] Calculate the perfusion

# [4] Calculate GEC for perfusion

# [5] Scale to whole liver


