################################################################################
# Use the fitted models for the predictions
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
# load models
####################################################
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

m1 <- models.GEC_age$fit.all
summary(models.GEC_age)
df.all <- models.GEC_age$df.all
head(d1)

plotCentiles(model=m1, d=df.all, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['all']])

#########################################################
# make predictions with the model
#########################################################
# simple predictions with fit models
# predict the values
age.grid <- 20:100
summary(m1)

# The function BCCG defines the Box-Cox Cole and Green distribution (Box-Cox normal), a three parameter distribution, for a gamlss.family object to be used in GAMLSS fitting using the function gamlss(). The functions dBCCG, pBCCG, qBCCG and rBCCG define the density, distribution function, quantile function and random generation for the specific parameterization of the Box-Cox Cole and Green distribution.
qBCCG()

GEC.mu <- predict(m1, what = "mu", type = "response", newdata=data.frame(age=age.grid))
GEC.sigma <- predict(m1, what = "sigma", type = "response", newdata=data.frame(age=age.grid))

points(age.grid, GEC.mu, col='blue', xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim)
for (i in 1:10){
    for (k in 1:length(age)){
        points(age[k], rnorm(n=1, mean=GEC.mu[k], sd=GEC.sigma[k]), col='red')
    }
}

# Now calculate the GEC distribution based on 
# molecular derived GEC curve with fitted distributions of liver volume 
# and blood flow variation
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
nhanes <- data
rm(data)
head(nhanes)


# GEC per volume liver tissue for given perfusion
# function coming from the underlying detailed kinetic model
GEC_per_vol <- function(perfusion){
    GEC = log((perfusion*10 + 1)) # mmol/min/ml(liver)
    return(GEC)
}
perfusion.grid <- seq(from=0.3, to=1.5, by=0.05)
plot(perfusion.grid, GEC_per_vol(perfusion.grid), xlim=c(0,1.5), ylim=c(0, 3.5))

# population analysis
# create some examples
volLiver = 1800 # ml
flowLiver = 1500 # ml/min
perfusion = flowLiver/volLiver
perfusion

# [1] Get the liver volume via information
# (age, sex)
# get the liver volume fit functions
dataset <- 'volLiver_age'
name.parts <- strsplit(dataset, '_')
xname <- name.parts[[1]][2]
yname <- name.parts[[1]][1]
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)
rm(name.parts)
r_fname <- file.path(dir, sprintf('%s_%s_models.Rdata', yname, xname))
load(file=r_fname)
models.volLiver_age <- models

m.volLiver_age.male <- models.volLiver_age$fit.male
summary(m.volLiver_age.male)
df.male <- models.volLiver_age$df.male

plotCentiles(model=m.volLiver_age.male, d=df.male, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=df.cols[['male']])

# calculate the liver volumes based on age and gender
head(nhanes)
names(nhanes)[names(nhanes)=='RIDAGEYR'] <- 'age'
names(nhanes)[names(nhanes)=='RIAGENDR'] <- 'sex'
names(nhanes)[names(nhanes)=='BMXWT'] <- 'bodyweight'
nhanes.f <- nhanes[nhanes$sex=='female', ]
nhanes.m <- nhanes[nhanes$sex=='male', ]
names(nhanes)

newdata <- data.frame(age=nhanes.m$age)
head(newdata)

volLiver.mu <- predict(m.volLiver_age.male, what = "mu", type = "response", newdata=newdata )
volLiver.sigma <- predict(m.volLiver_age.male, what = "sigma", type = "response", newdata=newdata)
# plot(newdata$age, volLiver.mu)
plot(newdata$age, rBCCG(n=1, mu=volLiver.mu, sigma=volLiver.sigma, nu=1.0))

# prediction in liver volume for NHANES
volLiver <- rep(NA, nrow(newdata)
for (k in 1:nrow(newdata)){
    n = 1
    # test <- rBCCG(n=n, mu=volLiver.mu[k], sigma=volLiver.sigma[k], nu=0)
    # points(rep(newdata$age[k], n),test, col='red', cex=0.5)
    volLiver[k] <- rBCCG(n=n, mu=volLiver.mu[k], sigma=volLiver.sigma[k], nu=0)
}
points(newdata$age, volLiver, col='red', cex=0.5)

nhanes.m$volLiver <- volLiver    

# [2] Get the blood flow via information
age.grid, volLiver

# [3] Calculate the perfusion

# [4] Calculate GEC for perfusion

# [5] Scale to whole liver


