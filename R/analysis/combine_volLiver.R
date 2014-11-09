# Combine the different distributions for the volume of the liver.
# creates the density function of the liver volume for the 
# given antropomorphic details.
# 
# TODO: fix the problems with the volLiver ~ age function
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
# methods(predict)
# getAnywhere("predict.gamlss")

# load the necessary models once
load(file=file.path(dir, 'volLiver_age_models.Rdata'))
models.volLiver_age <- models
load(file=file.path(dir, 'volLiver_bodyweight_models.Rdata'))
models.volLiver_bodyweight <- models
load(file=file.path(dir, 'volLiver_BSA_models.Rdata'))
models.volLiver_BSA <- models
load(file=file.path(dir, 'volLiverkg_age_models.Rdata'))
models.volLiverkg_age <- models

# some test data
age<-60; sex<-'male'; bodyweight<-50; BSA<-1.7

## get density from volLiver ~ age ##
f_d.volLiver.1 <- function(sex='all', age=NULL, bodyweight=NULL, BSA=NULL){
 f_d = NULL
 if (!is.null(age)){
  mname <- paste('fit.', sex, sep="")
  dfname <- paste('df.', sex, sep="")
  m <- models.volLiver_age[[mname]]
  assign(dfname, models.volLiver_age[[dfname]])
  
  # create the density function from the fitted values
  newdata <- data.frame(age=age)
  capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
  capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
  capture.output({ nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname)) })
  f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
 }
  return(f_d)
}
f_d.volLiver.1(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)

## get density from volLiver ~ bodyweight ##
f_d.volLiver.2 <- function(sex='all', age=NULL, bodyweight=NULL, BSA=NULL){
  d.volLiver_bodyweight = NULL
  if (!is.null(bodyweight)){
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models.volLiver_bodyweight[[mname]]
    assign(dfname, models.volLiver_bodyweight[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(bodyweight=bodyweight)
    capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
    capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
    d.volLiver_bodyweight <- function(x) dNO(x, mu=mu, sigma=sigma)
  }
  return(d.volLiver_bodyweight)
}
f_d.volLiver.2(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)

## get density from volLiver ~ bsa ##
f_d.volLiver.3 <- function(sex='all', age=NULL, bodyweight=NULL, BSA){
  f_d = NULL
  if (!is.null(BSA)){
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models.volLiver_BSA[[mname]]
    assign(dfname, models.volLiver_BSA[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(BSA=BSA)
    capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
    capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
    f_d <- function(x) dNO(x, mu=mu, sigma=sigma)
  }
  return(f_d)
}
f_d.volLiver.3(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)

## get density from volLiverkg ~ age ##
f_d.volLiver.4 <- function(sex='all', age=NULL, bodyweight, BSA=NULL){
  f_d = NULL
  if (!is.null(bodyweight) & !is.null(age)){
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models.volLiverkg_age[[mname]]
    assign(dfname, models.volLiverkg_age[[dfname]])
    
    # create the density function from the fitted values
    newdata <- data.frame(age=age)
    capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
    capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
    capture.output({ nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname)) })
    
    # scaling of the distribution (function works with volLiver, but takes volLiverkg as input)
    f_d <- function(x) dBCCG(x/bodyweight, mu=mu, sigma=sigma, nu=nu)/bodyweight
  }
  return(f_d)
}
f_d.volLiver.4(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)

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
f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)

# Evaluate the distribution functions
volLiver.grid <- seq(10, 3000, by=20)

# some example values
age<-60; sex<-'male'; bodyweight<-50; BSA<-1.7; volLiver<-2000
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
legend("topright", legend=c('combined', 'volLiver~age', 'volLiver~bodyweight', 'volLiver~BSA', 'volLiverkg~age'), lty=c(1,2,3,4,5), col=c(gender.base_cols[[sex]], 'black', 'black', 'black', 'black'))

######################################
## Liver Blood Flow
######################################
# flowLiver ~ age
# flowLiver ~ volLiver
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
f_d.flowLiver.1 <- function(sex='all', age=NULL, bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(age)){
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
f_d.flowLiver.2 <- function(sex='all', age=NULL, bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(volLiver)){
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
f_d.flowLiver.3 <- function(sex='all', age=NULL, bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(age) & !is.null(bodyweight) & age>17){
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
f_d.flowLiver.4 <- function(sex='all', age=NULL,  bodyweight=NULL, volLiver=NULL){
  f_d = NULL
  if (!is.null(bodyweight)){
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
f_d.flowLiver.c <- function(x, sex='all', age=NULL, bodyweight=NULL, volLiver=NULL){
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
age<-10; sex<-'male'; bodyweight<-30; volLiver<-600
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

# sex="male"; age=15.25; bodyweight=65; BSA=1.76778526997496; volLiver=1502.32225603063;
# f_d2 <- f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)


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
  s.interval = c(max(interval[1], f_d.max_x - 3*sd), min(interval[2], f_d.max_x + 3*sd)) 
  
  # normalization constant for rejection sampling,
  # so that the second function is above the sample function
  m <- 1.01 * f_d.max_y / (1/(sd*sqrt(2*pi)))
  funct1 <- function(x) {m*dnorm(x, mean=f_d.max_x, sd=sd)}
  
  # rejection sampling
  values <- NULL
  while(length(values) < Nsim){
    x <- rnorm(n=Nsim, mean=f_d.max_x, sd=sd)
    u <- runif(n=Nsim)
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
# Predict NHANES
##############################################################################
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
nhanes.all <- data
rm(data)
head(nhanes.all)

# create a reduced nhanes dataset
nhanes <- nhanes.all[, c('sex', 'bodyweight', 'age', 'height', 'BSA')]
head(nhanes)

# predict liver volume and blood flow
interval.volLiver <- c(1, 4000)
interval.flowLiver <- c(1, 4000)
  
volLiver <- rep(NA, nrow(nhanes))
flowLiver <- rep(NA, nrow(nhanes))
for (k in seq(1,nrow(nhanes))){
# for (k in seq(1,10)){
  cat(k, '\n')
  sex <- nhanes$sex[k]
  age <- nhanes$age[k]
  bodyweight <- nhanes$bodyweight[k]
  BSA <- nhanes$BSA[k]
  
  # get the combined distribution for the liver volumes
  f_d1 <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
  # rejection sampling
  rs1 <- f_d.rejection_sample(f_d1$f_d, Nsim=1, interval=interval.volLiver)
  volLiver[k] <- rs1$values[1]
  
  # get the combined distribution for liver blood flow
  f_d2 <- f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver[k])
  # rejection sampling
  rs2 <- f_d.rejection_sample(f_d2$f_d, Nsim=1, interval=interval.flowLiver)
  flowLiver[k] <- rs2$values[1]
  
  #cat(sprintf('sex=%s, age=%2.1f [year], bodyweight=%2.1f [kg], BSA=%1.2f [m^2], volLiver=%4.1f [ml], flowLiver=%4.1f [ml/min]', sex, age, bodyweight, BSA, volLiver[k], flowLiver[k]))
}
nhanes$volLiver <- volLiver
nhanes$flowLiver <- flowLiver
head(nhanes)
# save('nhanes', file='nhanes_liverData.Rdata')

##############################################################################
# Control plots
##############################################################################
# TODO: generate the control plots for nhanes prediction
# Check if the predicted distributions are in line with the measured 
# simple correlations
m <- models.flowLiver_volLiver$fit.all
df.all <- models.flowLiver_volLiver$df.all
plotCentiles(model=m, d=df.all, xname='volLiver', yname='flowLiver',
             main='Test', xlab='liver volume', ylab='liver bloodflow', xlim=c(0,3000), ylim=c(0,3000), 
             pcol='blue')
points(nhanes$volLiver[nhanes$sex=='female'], flowLiver[nhanes$sex=='female'], xlim=c(0,3000), ylim=c(0,2500), col='red', cex=0.2)
points(nhanes$volLiver[nhanes$sex=='male'], flowLiver[nhanes$sex=='male'], xlim=c(0,3000), ylim=c(0,2500), col='black', cex=0.2)


plotCentiles(model=m, d=df.all, xname='volLiver', yname='flowLiver',
             main='Test', xlab='liver volume', ylab='liver bloodflow', xlim=c(0,3000), ylim=c(0,3000), 
             pcol='blue')
points(nhanes$volLiver[nhanes$age>18], flowLiver[nhanes$age>18], xlim=c(0,3000), ylim=c(0,2500), col='black', cex=0.2)


plot(nhanes$age[nhanes$sex=='female'], nhanes$volLiver[nhanes$sex=='female'], xlim=c(0,100), ylim=c(0,2500), col='red', cex=0.2)
points(nhanes$age[nhanes$sex=='male'], nhanes$volLiver[nhanes$sex=='male'], xlim=c(0,100), ylim=c(0,2500), col='blue', cex=0.2)

plot(nhanes$age[nhanes$sex=='female'], nhanes$flowLiver[nhanes$sex=='female'], xlim=c(0,100), ylim=c(0,2500), col='red', cex=0.2)
points(nhanes$age[nhanes$sex=='male'], nhanes$flowLiver[nhanes$sex=='male'], xlim=c(0,100), ylim=c(0,2500), col='blue', cex=0.2)

##############################################################################
# Calculate GEC & GECkg
##############################################################################
# TODO: missing calculation of GEC based on the local distribution 
load(file=file.path(ma.settings$dir.expdata, 'processed', 'GEC_curve_T53_bootstrap.Rdata'))
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

calculate_GEC <- function(volLiver, flowLiver){
  # perfusion
  perfusion <- flowLiver/volLiver # [ml/min/ml]
  # GEC per volume based on perfusion
  GEC_per_vol <- rnorm(1, mean=GEC_f$f_GEC(perfusion), sd=GEC_f$f_GEC.se(perfusion)) # mmol/min/ml
  # GEC based on volume
  GEC <- GEC_per_vol * volLiver # mmol/min
  return(list(perfusion=perfusion, GEC_per_vol=GEC_per_vol, GEC=GEC))
}

GEC <- calculate_GEC(nhanes$volLiver, nhanes$flowLiver)

I.male <- (nhanes$sex=='male')
I.female <- (nhanes$sex=='female')
par(mfrow=c(2,2))
plot(nhanes$age[I.male], GEC$GEC[I.male], col='blue', cex=0.3, ylim=c(0,6))
plot(nhanes$age[I.female], GEC$GEC[I.female], col='red', cex=0.3, ylim=c(0,6))
plot(nhanes$age[I.male], GEC$GEC[I.male]/nhanes$bodyweight[I.male], col='blue', cex=0.3, ylim=c(0,0.1))  
plot(nhanes$age[I.female], GEC$GEC[I.female]/nhanes$bodyweight[I.female], col='red', cex=0.3, ylim=c(0,0.1))  
par(mfrow=c(1,1))



############################################
# GEC [mmol/min] prediction from data
############################################
rm(list=ls())
loadRawData <- function(name, dir=NULL){
  if (is.null(dir)){
    dir <- file.path(ma.settings$dir.expdata, "processed")
    print(dir)
  }
  r_fname <- file.path(dir, sprintf('%s.Rdata', name))
  print(r_fname)
  load(file=r_fname)
  return(data)
}

# load data for prediction
mar1988 <- loadRawData('mar1988')
head(mar1988) # age, volLiver, [GEC]

tyg1962 <- loadRawData('tyg1962')
head(tyg1962) # age, bodyweight, [GEC]

sch1986.tab1 <- loadRawData('sch1986.tab1')
head(sch1986.tab1) # sex, age, bodyweight, [GEC]

win1965 <- loadRawData('win1965')
head(win1965) # sex, age, bodyweight, flowLiver, BSA, [GEC]

duc1979 <- loadRawData('duc1979')
head(duc1979) # age, bodyweight, BSA, [GEC]

# [1] create empty prediction table
# prediction table
# study, age, gender, bodyweight, BSA, 
# volLiver, volLiver.predicted, flowLiver, flowLiver.predicted
# GEC, GEC.predicted, GECkg, GECkg.predicted

# [2] perform the predictions
# TODO implement
predict_GEC <- function(s


############################################
# GECkg [mmol/min/kgbw] vs. age [years]
############################################
lan2011 <- loadRawData('lan2011')
head(lan2011) # age, [GECkg]

duc1979 <- loadRawData('duc1979')
head(duc1979) # age, bodyweight, BSA, [GECkg]

tyg1962 <- loadRawData('tyg1962')
head(tyg1962) # age, bodyweight, [GECkg]

sch1986.fig1 <- loadRawData('sch1986.fig1')
head(sch1986.fig1) # age, [GECkg]

sch1986.tab1 <- loadRawData('sch1986.tab1')
head(sch1986.tab1) # sex, age, bodyweight [GECkg]

duf2005 <- loadRawData('duf2005')
head(duf2005) # sex, age, [GECkg]



