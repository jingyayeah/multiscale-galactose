# Combine the different distributions for the volume of the liver.
# creates the density function of the liver volume for the 
# given antropomorphic details.
#
# author: Matthias Koenig
# date: 2014-11-06
################################################################################
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
# volLiver ~ BSA
######################################
# TODO: Check for boundary conditions of the predictions !
# Especially for the age ! 

## get density from volLiver ~ age ##
f_d.volLiver.1 <- function(sex='all', age=NULL, bodyweight=NULL, BSA=NULL){
 f_d = NULL
 if (!is.null(age)){
  load(file=file.path(dir, 'volLiver_age_models.Rdata'))
  mname <- paste('fit.', sex, sep="")
  dfname <- paste('df.', sex, sep="")
  m <- models[[mname]]
  assign(dfname, models[[dfname]])
  
  # create the density function from the fitted values
  newdata <- data.frame(age=age)
  mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
  sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
  nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
  f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
 }
  return(f_d)
}

## get density from volLiver ~ bodyweight ##
f_d.volLiver.2 <- function(sex='all', age=NULL, bodyweight=NULL, BSA=NULL){
  d.volLiver_bodyweight = NULL
  if (!is.null(bodyweight)){
    load(file=file.path(dir, 'volLiver_bodyweight_models.Rdata'))
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(bodyweight=bodyweight)
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    d.volLiver_bodyweight <- function(x) dNO(x, mu=mu, sigma=sigma)
  }
  return(d.volLiver_bodyweight)
}

## get density from volLiver ~ bsa ##
f_d.volLiver.3 <- function(sex='all', age=NULL, bodyweight=NULL, BSA){
  f_d = NULL
  if (!is.null(BSA)){
    load(file=file.path(dir, 'volLiver_BSA_models.Rdata'))
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(BSA=BSA)
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    f_d <- function(x) dNO(x, mu=mu, sigma=sigma)
  }
  return(f_d)
}

## get density from volLiverkg ~ age ##
f_d.volLiver.4 <- function(sex='all', age=NULL, bodyweight, BSA=NULL){
  f_d = NULL
  if (!is.null(bodyweight) & !is.null(age)){
    load(file=file.path(dir, 'volLiverkg_age_models.Rdata'))
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(age=age)
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
    
    # scaling of the distribution (function works with volLiver, 
    # but takes volLiverkg as input    
    f_d <- function(x) dBCCG(x/bodyweight, mu=mu, sigma=sigma, nu=nu)/bodyweight
  }
  return(f_d)
}

## combined density ##
f_d.volLiver.c <- function(x, sex='all', age=NULL, bodyweight=NULL, BSA=NULL){ 
  f_d.1 <- f_d.volLiver.1(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
  f_d.2 <- f_d.volLiver.2(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
  f_d.3 <- f_d.volLiver.3(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
  f_d.4 <- f_d.volLiver.4(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
  # handle cases that distribution function is not available
  if (is.null(f_d.1)){ f_d.1 <- function(x){1} }
  if (is.null(f_d.2)){ f_d.2 <- function(x){1} }
  if (is.null(f_d.3)){ f_d.3 <- function(x){1} }
  if (is.null(f_d.4)){ f_d.4 <- function(x){1} }
  # unnormalized
  f_d.raw <- function(x) {f_d.1(x) * f_d.2(x) * f_d.3(x) * f_d.4(x)}
  A <- integrate(f=f_d.raw, lower=0, upper=5000)
  # normalized
  f_d <- function(x){f_d.raw(x)/A$value}
  return( list(f_d=f_d, f_d.raw=f_d.raw, f_d.1=f_d.1, 
               f_d.2=f_d.2, f_d.3=f_d.3, f_d.4=f_d.4,
               sex=sex, age=age, bodyweight=bodyweight, BSA=BSA) ) 
}


# Evaluate the distribution functions
volLiver.grid <- seq(0, 3000, by=20)

par(mfrow=c(3,1))
# some example values
age<-60; sex<-'male'; bodyweight<-50; BSA<-1.3
# age<-60; sex<-'male'; bodyweight<-NULL; BSA<-NULL
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], BSA=%s [m^2]', age, sex, bodyweight, BSA)

# create the distribution functions for the subject/subjects
f_d.volLiver <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
summary(f_d.volLiver)
# plot single contributions and resulting density
plot(volLiver.grid, f_d.volLiver$f_d(volLiver.grid), type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, main=info)
points(volLiver.grid, f_d.volLiver$f_d.1(volLiver.grid), type='l', lty=2)
points(volLiver.grid, f_d.volLiver$f_d.2(volLiver.grid), type='l', lty=3)
points(volLiver.grid, f_d.volLiver$f_d.3(volLiver.grid), type='l', lty=4)
points(volLiver.grid, f_d.volLiver$f_d.4(volLiver.grid), type='l', lty=5)
legend("topright", legend=c('combined', 'volLiver~age', 'volLiver~bodyweight', 'volLiver~BSA', 'volLiverkg~age'), lty=c(1,2,3,4,5),
       col=c(gender.base_cols[[sex]], 'black', 'black', 'black', 'black'))
par(mfrow=c(1,1))


######################################
## Liver Blood Flow
######################################
# flowLiver ~ age
# flowLiver ~ volLiver
# flowLiverkg ~ age
# flowLiverkg ~ bodyweight
######################################
## density from flowLiver ~ age ##
f_d.flowLiver.1 <- function(age, sex='all', bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(age)){
    load(file=file.path(dir, 'flowLiver_age_models.Rdata'))
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(age=age)
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
    f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
  }
  return(f_d)
}

## density from flowLiver ~ volLiver ##
f_d.flowLiver.2 <- function(age, sex='all', bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(volLiver)){
    load(file=file.path(dir, 'flowLiver_volLiver_models.Rdata'))
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(volLiver=volLiver)
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    # nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
    # f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
    f_d <- function(x) dNO(x, mu=mu, sigma=sigma)
  }
  return(f_d)
}

## density from flowLiverkg ~ age ##
f_d.flowLiver.3 <- function(age, sex='all', bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(age) & !is.null(bodyweight)){
    load(file=file.path(dir, 'flowLiverkg_age_models.Rdata'))
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(age=age)
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    # transformation to flowLiver necessary
    f_d <- function(x) {dNO(x/bodyweight, mu=mu, sigma=sigma)/bodyweight}
  }
  return(f_d)
}

## density from flowLiverkg ~ bodyweight ##
f_d.flowLiver.4 <- function(age, sex='all', bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(bodyweight)){
    load(file=file.path(dir, 'flowLiverkg_bodyweight_models.Rdata'))
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models[[mname]]
    assign(dfname, models[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(bodyweight=bodyweight)
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    # transformation to flowLiver necessary
    f_d <- function(x) {dNO(x/bodyweight, mu=mu, sigma=sigma)/bodyweight}
  }
  return(f_d)
}

## combined density ##
f_d.flowLiver.c <- function(x, sex='all', age, bodyweight=NULL, volLiver=NULL){
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

# Evaluate the distribution functions
flowLiver.grid <- seq(0, 3000, by=10)

# some example values
age<-10; sex<-'all'; bodyweight<-30; volLiver<-600
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], volLiver=%s [ml]', age, sex, bodyweight, volLiver)

f_d.flowLiver <- f_d.flowLiver.c(age=age, sex=sex, bodyweight=bodyweight, volLiver=volLiver)
summary(f_d.flowLiver)
# plot single contributions and resulting density
plot(flowLiver.grid, f_d.flowLiver$f_d(flowLiver.grid), type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, main=info)
points(flowLiver.grid, f_d.flowLiver$f_d.1(flowLiver.grid), type='l', lty=2)
points(flowLiver.grid, f_d.flowLiver$f_d.2(flowLiver.grid), type='l', lty=3)
points(flowLiver.grid, f_d.flowLiver$f_d.3(flowLiver.grid), type='l', lty=4)
points(flowLiver.grid, f_d.flowLiver$f_d.4(flowLiver.grid), type='l', lty=5)
legend("topright", legend=c('combined', 'flowLiver~age', 'flowLiver~volLiver', 'flowLiverkg~age', 'flowLiverkg~bodyweight'), lty=c(1,2,3,4,5),
       col=c(gender.base_cols[[sex]], 'black', 'black', 'black', 'black'))

##############################################################################
# Test some of the functions
# age dependency
age.test <- seq(1, 100, by=4)
par(mfrow=c(1,3))
bodyweight=70
BSA=NULL
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
  f_d.f <- f_d.volLiver.c(sex=sex, age=NULL, bodyweight=bodyweight.test[1], BSA=NULL)
  plot(volLiver.grid, f_d.f$f_d(volLiver.grid), type='l', col=col, main=gender.levels[k])
  legend("topright", legend=c('volLiver~bodyweight'), lty=c(1),
         col=col)
  for (bodyweight in bodyweight.test){
    print(bodyweight)
    f_d.f <- f_d.volLiver.c(sex=sex, age=NULL, bodyweight=bodyweight, BSA=NULL)
    points(volLiver.grid, f_d.f$f_d(volLiver.grid), type='l', col=col)
  }
}
par(mfrow=c(1,1))


