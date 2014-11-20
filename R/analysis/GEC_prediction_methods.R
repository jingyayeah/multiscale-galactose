################################################################################
# Prediction methods
################################################################################
# Combines the information from multiple pair-wise correlation to create the
# best prediction for liver volume, blood flow and GEC.
# Creates density functions based on given antropomorphic details.
# 
# TOOD: flowLiverkg prediction from data
#
# author: Matthias Koenig
# date: 2014-11-20
################################################################################
# methods(predict)
# getAnywhere("predict.gamlss")

rm(list=ls())
library('MultiscaleAnalysis')
library('gamlss')
setwd('/home/mkoenig/multiscale-galactose/')
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))
dir <- file.path(ma.settings$dir.expdata, "processed")

######################################
## Liver Volume
######################################
# volLiver ~ age
# volLiverkg ~ age
# volLiver ~ bodyweight
# volLiverkg ~ bodyweight
# volLiver ~ height
# volLiverkg ~ height
# volLiver ~ BSA
# volLiverkg ~ BSA
######################################
# load GAMLSS models
load(file=file.path(dir, 'volLiver_age_models.Rdata'))
models.volLiver_age <- models
load(file=file.path(dir, 'volLiverkg_age_models.Rdata'))

models.volLiverkg_age <- models
load(file=file.path(dir, 'volLiver_bodyweight_models.Rdata'))
models.volLiver_bodyweight <- models
load(file=file.path(dir, 'volLiverkg_bodyweight_models.Rdata'))
models.volLiverkg_bodyweight <- models

load(file=file.path(dir, 'volLiver_height_models.Rdata'))
models.volLiver_height <- models
load(file=file.path(dir, 'volLiverkg_height_models.Rdata'))
models.volLiverkg_height <- models

load(file=file.path(dir, 'volLiver_BSA_models.Rdata'))
models.volLiver_BSA <- models
load(file=file.path(dir, 'volLiverkg_BSA_models.Rdata'))
models.volLiverkg_BSA <- models
rm(models)

#########################################
# Density factories
#########################################
# A general factory to create the various probability densities
# from the individual models.
f_d.factory <- function(models, xname, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA){
    if (is.na(get(xname))){
        return(NULL)
    }
    # data to predict
    newdata <- data.frame(get(xname))
    names(newdata) <- c(xname)
    
    # get link function from model, predict the necessary parameters & 
    # create respective density
    f_d = NULL
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    link = m$family[1]  
    if (link == 'BCCG'){
        capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname)) })
        f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
    } else if (link =='NO'){
        capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
        f_d <- function(x) dNO(x, mu=mu, sigma=sigma)
    }
    return(f_d)
}

# Wrapper around the factory to use the per bodyweight data for prediction
f_d.factory.bodyweight <- function(models, xname, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA){
    # check if bodyweight and name is available
    if (is.na(bodyweight) | is.na(xname)){
        return(NULL)
    }
    f_d.scale <- function(x) {
        f_d.tmp <- f_d.factory(models=models, xname=xname, 
                               sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
        return(f_d.tmp(x/bodyweight)/bodyweight)
    }
    return(f_d.scale)
}

#########################################
# volLiver densities
#########################################
# test data
age=60; sex='male'; bodyweight=50; height=170;  BSA=1.7

xlimits=c(0,4000); ylimits=c(0,0.002)
plot(numeric(0), numeric(0), type='n', xlim=xlimits, ylim=ylimits, 
     xlab='volLiver [ml]', ylab='probability', font.lab=2)
# volLiver ~ age
tmp <- f_d.factory(models=models.volLiver_age, xname='age', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiver ~ bodyweight
tmp <- f_d.factory(models=models.volLiver_bodyweight, xname='bodyweight', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiver ~ height
tmp <- f_d.factory(models=models.volLiver_height, xname='height', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiver ~ bsa
tmp <- f_d.factory(models=models.volLiver_BSA, xname='BSA', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)

# volLiverkg ~ age
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_age, xname='age', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bodyweight
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ height
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_height, xname='height', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bsa
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_BSA, xname='BSA', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)


# combined density
# Use all the single correlation density information to predict some combined density
f_d.volLiver.c <- function(x, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA){ 
    # volLiver info
    f_d.1 <- f_d.factory(models=models.volLiver_age, xname='age', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.2 <- f_d.factory(models=models.volLiver_bodyweight, xname='bodyweight', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.3 <- f_d.factory(models=models.volLiver_height, xname='height', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.4 <- f_d.factory(models=models.volLiver_BSA, xname='BSA', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    # volLiverkg info
    f_d.5 <- f_d.factory.bodyweight(models=models.volLiverkg_age, xname='age', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.6 <- f_d.factory.bodyweight(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.7 <- f_d.factory.bodyweight(models=models.volLiverkg_height, xname='height', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.8 <- f_d.factory.bodyweight(models=models.volLiverkg_BSA, xname='BSA', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    
    # handle cases that distribution function is not available
    if (is.null(f_d.1)){ f_d.1 <- function(x){1} }
    if (is.null(f_d.2)){ f_d.2 <- function(x){1} }
    if (is.null(f_d.3)){ f_d.3 <- function(x){1} }
    if (is.null(f_d.4)){ f_d.4 <- function(x){1} }
    if (is.null(f_d.5)){ f_d.5 <- function(x){1} }
    if (is.null(f_d.6)){ f_d.6 <- function(x){1} }
    if (is.null(f_d.7)){ f_d.7 <- function(x){1} }
    if (is.null(f_d.8)){ f_d.8 <- function(x){1} }
    # unnormalized
    f_d.raw <- function(x) {f_d.1(x)*f_d.2(x)*f_d.3(x)*f_d.4(x)*f_d.5(x)*f_d.6(x)*f_d.7(x)*f_d.8(x)}
    A <- integrate(f=f_d.raw, lower=0, upper=5000)
    # normalized
    f_d <- function(x){f_d.raw(x)/A$value}
    return( list(f_d=f_d, f_d.raw=f_d.raw, 
                 f_d.1=f_d.1, f_d.2=f_d.2, f_d.3=f_d.3, f_d.4=f_d.4,
                 f_d.5=f_d.5, f_d.6=f_d.6, f_d.7=f_d.7, f_d.8=f_d.8,
                 sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA) ) 
}

# Example
age<-80; sex<-'male'; bodyweight<-55; BSA<-1.6; height=170; volLiver<-2000
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], BSA=%s [m^2]', age, sex, bodyweight, BSA)
f_d.volLiver <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
summary(f_d.volLiver)

# plot single contributions and resulting density
# png(filename='/home/mkoenig/multiscale-galactose/presentations/volLiver_estimation_02.png', width=1000, height=1000, units = "px", bg = "white",  res = 150)
volLiver.grid <- seq(10, 3000, by=20)
plot(volLiver.grid, f_d.volLiver$f_d(volLiver.grid), type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, main=info, xlab='liver volume [ml]', ylab='estimated probability density', font.lab=2)
points(volLiver.grid, f_d.volLiver$f_d.1(volLiver.grid), type='l', lty=1, col='red', lwd=2)
points(volLiver.grid, f_d.volLiver$f_d.2(volLiver.grid), type='l', lty=1, col='orange', lwd=2)
points(volLiver.grid, f_d.volLiver$f_d.3(volLiver.grid), type='l', lty=1, col='gray', lwd=2)
points(volLiver.grid, f_d.volLiver$f_d.4(volLiver.grid), type='l', lty=1, col='black', lwd=2)
points(volLiver.grid, f_d.volLiver$f_d.5(volLiver.grid), type='l', lty=2, col='red', lwd=2)
points(volLiver.grid, f_d.volLiver$f_d.6(volLiver.grid), type='l', lty=2, col='orange', lwd=2)
points(volLiver.grid, f_d.volLiver$f_d.7(volLiver.grid), type='l', lty=2, col='gray', lwd=2)
points(volLiver.grid, f_d.volLiver$f_d.8(volLiver.grid), type='l', lty=2, col='black', lwd=2)
legend("topright", legend=c('combined', 'volLiver~age', 'volLiver~bodyweight', 'volLiver~height', 'volLiver~BSA', 
                                        'volLiverkg~age', 'volLiverkg~bodyweight', 'volLiverkg~height', 'volLiverkg~BSA'), 
       lty=c(rep(1,5), rep(2,4)), 
       col=c(gender.base_cols[[sex]], 'red', 'orange', 'gray', 'black', 'red', 'orange', 'gray', 'black'), lwd=rep(2,9))
# dev.off()


######################################
## Liver Volume per bodyweight
######################################
# volLiverkg
xlimits=c(0,80); ylimits=c(0,0.15)
plot(numeric(0), numeric(0), type='n', xlim=xlimits, ylim=ylimits, 
     xlab='volLiverkg [ml/kg]', ylab='probability', font.lab=2)
# volLiverkg ~ age
tmp <- f_d.factory(models=models.volLiverkg_age, xname='age', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bodyweight
tmp <- f_d.factory(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ height
tmp <- f_d.factory(models=models.volLiverkg_height, xname='height', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bsa
tmp <- f_d.factory(models=models.volLiverkg_BSA, xname='BSA', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)

# Combined function
f_d.volLiverkg.c <- function(x, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA){ 
    # volLiverkg info
    f_d.1 <- f_d.factory(models=models.volLiverkg_age, xname='age', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.2 <- f_d.factory(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.3 <- f_d.factory(models=models.volLiverkg_height, xname='height', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_d.4 <- f_d.factory(models=models.volLiverkg_BSA, xname='BSA', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    
    # handle cases that distribution function is not available
    if (is.null(f_d.1)){ f_d.1 <- function(x){1} }
    if (is.null(f_d.2)){ f_d.2 <- function(x){1} }
    if (is.null(f_d.3)){ f_d.3 <- function(x){1} }
    if (is.null(f_d.4)){ f_d.4 <- function(x){1} }
    
    # unnormalized
    f_d.raw <- function(x) {f_d.1(x)*f_d.2(x)*f_d.3(x)*f_d.4(x)}
    A <- integrate(f=f_d.raw, lower=0, upper=150)
    # normalized
    f_d <- function(x){f_d.raw(x)/A$value}
    return( list(f_d=f_d, f_d.raw=f_d.raw, 
                 f_d.1=f_d.1, f_d.2=f_d.2, f_d.3=f_d.3, f_d.4=f_d.4,
                 sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA) ) 
}

# plot single contributions and resulting density
f_d.volLiverkg <- f_d.volLiverkg.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
summary(f_d.volLiverkg)
volLiverkg.grid <- seq(1, 80, by=0.1)
plot(volLiverkg.grid, f_d.volLiverkg$f_d(volLiverkg.grid), type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, main=info, xlab='liver volume per bodyweight [ml/kg]', ylab='estimated probability density', font.lab=2)

points(volLiverkg.grid, f_d.volLiverkg$f_d.1(volLiverkg.grid), type='l', lty=2, col='red', lwd=2)
points(volLiverkg.grid, f_d.volLiverkg$f_d.2(volLiverkg.grid), type='l', lty=2, col='orange', lwd=2)
points(volLiverkg.grid, f_d.volLiverkg$f_d.3(volLiverkg.grid), type='l', lty=2, col='gray', lwd=2)
points(volLiverkg.grid, f_d.volLiverkg$f_d.4(volLiverkg.grid), type='l', lty=2, col='black', lwd=2)

legend("topright", legend=c('combined', 'volLiver~age', 'volLiver~bodyweight', 'volLiver~height', 'volLiver~BSA'), 
       lty=c(1, rep(2,4)), 
       col=c(gender.base_cols[[sex]], 'red', 'orange', 'gray', 'black'), lwd=rep(2,5))
# dev.off()


######################################
## Liver Blood Flow
######################################
# flowLiver ~ volLiver

# flowLiver ~ age
# flowLiverkg ~ age
# flowLiverkg ~ bodyweight
######################################
load(file=file.path(dir, 'flowLiver_age_models.Rdata'))
models.flowLiver_age <- models
load(file=file.path(dir, 'flowLiver_volLiver_models.Rdata'))
models.flowLiver_volLiver <- models
load(file=file.path(dir, 'flowLiverkg_age_models.Rdata'))
models.flowLiverkg_age <- models
load(file=file.path(dir, 'flowLiverkg_bodyweight_models.Rdata'))
models.flowLiverkg_bodyweight <- models

## density from flowLiver ~ age ##
f_d.flowLiver.1 <- function(sex='all', age=NA, bodyweight=NA, volLiver=NA){
    f_d = NULL
    if (!is.na(age)){
        load(file=file.path(dir, 'flowLiver_age_models.Rdata'))
        mname <- paste('fit.', sex, sep="")
        dfname <- paste('df.', sex, sep="")
        m <- models.flowLiver_age[[mname]]
        assign(dfname, models.flowLiver_age[[dfname]])
        
        # create the density function from the fitted values
        newdata <- data.frame(age=age)
        capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname)) })
        f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
    }
    return(f_d)
}
f_d.flowLiver.1(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)

## density from flowLiver ~ volLiver ##
f_d.flowLiver.2 <- function(sex='all', age=NA, bodyweight=NA, volLiver=NA){
    f_d = NULL
    if (!is.na(volLiver)){
        mname <- paste('fit.', sex, sep="")
        dfname <- paste('df.', sex, sep="")
        m <- models.flowLiver_volLiver[[mname]]
        assign(dfname, models.flowLiver_volLiver[[dfname]])
        
        # create the density function from the fitted values
        newdata <- data.frame(volLiver=volLiver)
        capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
        f_d <- function(x) dNO(x, mu=mu, sigma=sigma)
    }
    return(f_d)
}
f_d.flowLiver.2(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)

## density from flowLiverkg ~ age ##
f_d.flowLiver.3 <- function(sex='all', age=NA, bodyweight=NA, volLiver=NA){
    f_d = NULL
    if (!is.na(age) & !is.na(bodyweight) & age>17){
        mname <- paste('fit.', sex, sep="")
        dfname <- paste('df.', sex, sep="")
        m <- models.flowLiverkg_age[[mname]]
        assign(dfname, models.flowLiverkg_age[[dfname]])
        
        # create the density function from the fitted values
        newdata <- data.frame(age=age)
        capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
        # transformation to flowLiver necessary
        f_d <- function(x) {dNO(x/bodyweight, mu=mu, sigma=sigma)/bodyweight}
    }
    return(f_d)
}
f_d.flowLiver.3(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)

## density from flowLiverkg ~ bodyweight ##
f_d.flowLiver.4 <- function(sex='all', age=NA,  bodyweight=NA, volLiver=NA){
    f_d = NULL
    if (!is.na(bodyweight)){
        mname <- paste('fit.', sex, sep="")
        dfname <- paste('df.', sex, sep="")
        m <- models.flowLiverkg_bodyweight[[mname]]
        assign(dfname, models.flowLiverkg_bodyweight[[dfname]])
        
        # create the density function from the fitted values
        newdata <- data.frame(bodyweight=bodyweight)
        capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
        capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
        # transformation to flowLiver necessary
        f_d <- function(x) {dNO(x/bodyweight, mu=mu, sigma=sigma)/bodyweight}
    }
    return(f_d)
}
f_d.flowLiver.4(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)

## combined density ##
f_d.flowLiver.c <- function(x, sex='all', age=NA, bodyweight=NA, volLiver=NA){
    f_d.1 <- f_d.flowLiver.1(age=age, sex=sex, bodyweight=bodyweight, volLiver=volLiver)
    
    
    f_d.2 <- f_d.flowLiver.2(age=age, sex=sex, bodyweight=bodyweight, volLiver=volLiver)
    f_d.3 <- f_d.flowLiver.3(age=age, sex=sex, bodyweight=bodyweight, volLiver=volLiver)
    f_d.4 <- f_d.flowLiver.4(age=age, sex=sex, bodyweight=bodyweight, volLiver=volLiver)
    # handle cases that distribution function is not available
    if (is.null(f_d.1)){ f_d.1 <- function(x){1} }
    if (is.null(f_d.2)){ f_d.2 <- function(x){1} }
    if (is.null(f_d.3)){ f_d.3 <- function(x){1} }
    if (is.null(f_d.4)){ f_d.4 <- function(x){1} }
    # unnormalized
    f_d.raw <- function(x) {f_d.1(x) * f_d.2(x) * f_d.3(x) * f_d.4(x)}
    # normalized
    A <- integrate(f=f_d.raw, lower=0, upper=5000)
    f_d <- function(x){f_d.raw(x)/A$value}
    return( list(f_d=f_d, f_d.raw=f_d.raw, f_d.1=f_d.1, 
                 f_d.2=f_d.2, f_d.3=f_d.3, f_d.4=f_d.4,
                 sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver) ) 
}
f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)

# Evaluate the distribution functions
flowLiver.grid <- seq(10, 3000, by=10)

# some example values
age<-80; sex<-'male'; bodyweight<-30; volLiver<-600
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], volLiver=%s [ml]', age, sex, bodyweight, volLiver)

f_d.flowLiver <- f_d.flowLiver.c(age=age, sex=sex, bodyweight=bodyweight, volLiver=volLiver)
summary(f_d.flowLiver)
# plot single contributions and resulting density
plot(flowLiver.grid, f_d.flowLiver$f_d(flowLiver.grid), type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, main=info)
points(flowLiver.grid, f_d.flowLiver$f_d.1(flowLiver.grid), type='l', lty=2)
points(flowLiver.grid, f_d.flowLiver$f_d.2(flowLiver.grid), type='l', lty=3)
points(flowLiver.grid, f_d.flowLiver$f_d.3(flowLiver.grid), type='l', lty=4)
points(flowLiver.grid, f_d.flowLiver$f_d.4(flowLiver.grid), type='l', lty=5)
legend("topright", legend=c('combined', 'flowLiver~age', 'flowLiver~volLiver', 'flowLiverkg~age', 'flowLiverkg~bodyweight'), lty=c(1,2,3,4,5), col=c(gender.base_cols[[sex]], 'black', 'black', 'black', 'black'))

# sex="male"; age=15.25; bodyweight=65; BSA=1.76778526997496; volLiver=1502.32225603063;
# f_d2 <- f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)

png(filename='/home/mkoenig/multiscale-galactose/presentations/flowLiver_80years_male.png', width=1000, height=1000, units = "px", bg = "white",  res = 200)
plot(flowLiver.grid, f_d.flowLiver$f_d.1(flowLiver.grid), type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, main=sprintf('age=%s [y], sex=%s', age, sex), xlab='liver bloodflow [ml/min]', ylab='estimated probability density', font.lab=2)
dev.off()

######################################
## Liver Blood Flow per bodyweight
######################################
# TOOD implement the flowLiverkg

##############################################################################
# Test some of the functions
# age dependency
age.test <- seq(1, 100, by=4)
par(mfrow=c(1,3))
bodyweight=70
BSA=NA
for (k in seq(1:length(gender.levels))){
    sex <- gender.levels[k]
    col <- gender.cols[k]
    f_d.f <- f_d.volLiver.c(sex=sex, age=age.test[1], bodyweight=bodyweight, BSA=BSA)
    
    plot(volLiver.grid, f_d.f$f_d(volLiver.grid), type='l', col=col, main=gender.levels[k])
    legend("topright", legend=c('volLiver~age'), lty=c(1),
           col=col)
    for (age in age.test){
        print(age)
        f_d.f <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
        points(volLiver.grid, f_d.f$f_d(volLiver.grid), type='l', col=col)
    }
}
par(mfrow=c(1,1))

# bodyweight dependency
bodyweight.test <- seq(1, 120, by=6)
par(mfrow=c(1,3))
for (k in seq(1:length(gender.levels))){
    sex <- gender.levels[k]
    col <- gender.cols[k]
    f_d.f <- f_d.volLiver.c(sex=sex, age=NA, bodyweight=bodyweight.test[1], BSA=NA)
    plot(volLiver.grid, f_d.f$f_d(volLiver.grid), type='l', col=col, main=gender.levels[k])
    legend("topright", legend=c('volLiver~bodyweight'), lty=c(1),
           col=col)
    for (bodyweight in bodyweight.test){
        print(bodyweight)
        f_d.f <- f_d.volLiver.c(sex=sex, age=NA, bodyweight=bodyweight, BSA=NA)
        points(volLiver.grid, f_d.f$f_d(volLiver.grid), type='l', col=col)
    }
}
par(mfrow=c(1,1))

############################################################
# Rejection sampling for testing
############################################################

## find proper approximation of density ##
# get density
sex = 'male'; age=50; bodyweight=80; BSA=1.8;
f_d <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)$f_d
plot(f_d, from=0, to=3000, col="blue", ylab="")

# define 
interval <- c(1,3000) # interval for sampling (no sampling in zero regions)

# find maximum value
f_d.max_x <- optimize(f_d, interval=interval, maximum=TRUE)$maximum
f_d.max_y <- f_d(f_d.max_x)
f_d.max_x
f_d.max_y

# find half maximal value
f_d.half <- function(x){f_d(x)-0.5*f_d.max_y}
f_d.half_x1 <- uniroot(f_d.half, interval=c(interval[1], f_d.max_x))$root
f_d.half_x2 <- uniroot(f_d.half, interval=c(f_d.max_x, interval[2]))$root
sd <- max(f_d.max_x-f_d.half_x1, f_d.half_x2-f_d.max_x)

# sample within 3*sds within the interval
s.interval = c(max(interval[1], f_d.max_x - 3*sd), min(interval[2], f_d.max_x + 3*sd)) 
s.interval

# normalization constant for rejection sampling,
# so that the second function is above the sample function
m <- 1.01 * f_d.max_y / (1/(sd*sqrt(2*pi)))
m

funct1 <- function(x) {m*dnorm(x, mean=f_d.max_x, sd=sd)}
plot(funct1, from=s.interval[1], to=s.interval[2], col="blue", ylab="")
curve(f_d, from=s.interval[1], to=s.interval[2], col="red", add=T)

set.seed(1); Nsim <- 1e5
s.values <- NULL
while(length(s.values) < Nsim){
    x <- rnorm(n=Nsim, mean=f_d.max_x, sd=sd)
    u <- runif(n=Nsim)
    ratio <- f_d(x) / (m*dnorm(x, mean=f_d.max_x, sd=sd))
    ind <- I(u<ratio)
    s.values <- c(s.values, x[ind==1])
}
s.values=s.values[1:Nsim]
length(s.values) # as a check to make sure we have enough


plot(density(s.values))
hist(betas, freq=FALSE, add=T)
curve(funct1, from=s.interval[1], to=s.interval[2], col="red", lwd=2, add=T)
curve(f_d, from=s.interval[1], to=s.interval[2], col="blue", ylab="", add=T)

####################################################
# function for rejection sampling of f_d
####################################################
f_d.rejection_sample <- function(f_d, Nsim, interval){
    # find maximum value
    f_d.max_x <- optimize(f_d, interval=interval, maximum=TRUE)$maximum
    f_d.max_y <- f_d(f_d.max_x)
    
    # find half maximal value
    f_d.half <- function(x){f_d(x)-0.5*f_d.max_y}
    f_d.half_x1 <- uniroot(f_d.half, interval=c(interval[1], f_d.max_x))$root
    f_d.half_x2 <- uniroot(f_d.half, interval=c(f_d.max_x, interval[2]))$root
    sd <- max(f_d.max_x-f_d.half_x1, f_d.half_x2-f_d.max_x)
    
    # sample within 3*sds in the provided interval
    s.interval = c(max(interval[1], f_d.max_x-3*sd), min(interval[2], f_d.max_x+3*sd)) 
    
    # normalization constant for rejection sampling,
    # so that the second function is above the sample function
    m <- 1.01 * f_d.max_y / (1/(sd*sqrt(2*pi)))
    funct1 <- function(x) {m*dnorm(x, mean=f_d.max_x, sd=sd)}
    
    # rejection sampling
    values <- NULL
    while(length(values) < Nsim){
        x <- rnorm(n=Nsim, mean=f_d.max_x, sd=sd)
        x <- x[x>0]   # guarantee that > 0, otherwise the f_d will break
        u <- runif(n=length(x))
        ratio <- f_d(x)/funct1(x)
        ind <- I(u<ratio)
        values <- c(values, x[ind==1]) 
    }
    values = values[1:Nsim]
    
    return(list(values=values, f_d=f_d, funct1=funct1, s.interval=s.interval) )
}

sex = 'male'; age=40; bodyweight=90; BSA=1.8; volLiver=2500;

f_d1 <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)$f_d
f_d2 <- f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)$f_d

# rejection sampling
rs1 <- f_d.rejection_sample(f_d1, 1000, interval=c(1,3000))
plot(f_d1, from=0, to=3000, col="blue", ylab="")
hist(rs1$values, freq=FALSE, add=TRUE)

rs2 <- f_d.rejection_sample(f_d2, 1000, interval=c(1,3000))
plot(f_d2, from=0, to=3000, col="blue", ylab="")
hist(rs2$values, freq=FALSE, add=TRUE)

##############################################################################
# GEC curves
##############################################################################
task <- 'T54'
load(file=file.path(ma.settings$dir.expdata, 'processed', paste('GEC_curve_', task,'.Rdata', sep="")))
str(GEC_curves)

# make the GEC fit function
d.mean <- GEC_curves$d2
d.se <- GEC_curves$d2.se

GEC_functions <- function(d.mean, d.se){
    # create spline fits
    x <- d.mean$Q_per_vol_units      # perfusion [ml/min/ml]
    y <- d.mean$R_per_vol_units     # GEC clearance [mmol/min/ml]
    y.se <- d.se$R_per_vol_units  # GEC standard error (bootstrap) [mmol/min/ml]
    f <- splinefun(x, y)
    f.se <- splinefun(x, y.se)  
    
    plot(x,y, ylim=c(0,0.003))
    curve(f, from=0, to=3.5, col='red', add=T)
    curve(f.se, from=0, to=3.5, col='blue', add=T)
    
    return(list(f_GEC=f, f_GEC.se=f.se)) 
}
GEC_f <- GEC_functions(d.mean, d.se)
GEC_f

calculate_GEC <- function(volLiver, flowLiver, f_tissue=0.8){  
    # perfusion
    perfusion <- flowLiver/volLiver # [ml/min/ml]
    # GEC per volume based on perfusion
    GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
    # GEC for complete liver
    # GEC curves are for liver tissue. No correction for the large vessel structure
    # has been applied. Here the metabolic capacity of combined sinusoidal units.
    GEC <- GEC_per_vol * f_tissue * volLiver # mmol/min
    return(list(perfusion=perfusion, GEC_per_vol=GEC_per_vol, GEC=GEC, f_tissue=f_tissue))
}

calculate_GECkg <- function(volLiverkg, flowLiverkg, f_tissue=0.8){  
    # perfusion
    perfusion <- flowLiverkg/volLiverkg # [ml/min/ml]
    # GEC per volume based on perfusion
    GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
    # GEC for liver per kg
    # GEC curves are for liver tissue. No correction for the large vessel structure
    # has been applied. Here the metabolic capacity of combined sinusoidal units.
    GECkg <- GEC_per_vol * f_tissue * volLiver # mmol/min
    return(list(perfusion=perfusion, GEC_per_vol=GEC_per_vol, GECkg=GECkg, f_tissue=f_tissue))
}