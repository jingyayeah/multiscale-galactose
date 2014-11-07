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
# load the necessary models once
load(file=file.path(dir, 'volLiver_age_models.Rdata'))
models.volLiver_age <- models
load(file=file.path(dir, 'volLiver_bodyweight_models.Rdata'))
models.volLiver_bodyweight <- models
load(file=file.path(dir, 'volLiver_BSA_models.Rdata'))
models.volLiver_BSA <- models
load(file=file.path(dir, 'volLiverkg_age_models.Rdata'))
models.volLiverkg_age <- models

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
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models.volLiver_bodyweight[[mname]]
    assign(dfname, models.volLiver_bodyweight[[dfname]])
    
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
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models.volLiver_BSA[[mname]]
    assign(dfname, models.volLiver_BSA[[dfname]])
    
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
    mname <- paste('fit.', sex, sep="")
    dfname <- paste('df.', sex, sep="")
    m <- models.volLiverkg_age[[mname]]
    assign(dfname, models.volLiverkg_age[[dfname]])
    
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
volLiver.grid <- seq(10, 3000, by=20)

# some example values
age<-60; sex<-'male'; bodyweight<-50; BSA<-1.7
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
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
    f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
  }
  return(f_d)
}

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
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    # nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
    # f_d <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
    f_d <- function(x) dNO(x, mu=mu, sigma=sigma)
  }
  return(f_d)
}

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
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    # transformation to flowLiver necessary
    f_d <- function(x) {dNO(x/bodyweight, mu=mu, sigma=sigma)/bodyweight}
  }
  return(f_d)
}

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
    mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
    sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
    # transformation to flowLiver necessary
    f_d <- function(x) {dNO(x/bodyweight, mu=mu, sigma=sigma)/bodyweight}
  }
  return(f_d)
}

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
sex = 'male'; age=50; bodyweight=80; BSA=1.8;
f_d <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)$f_d

# find proper approximation of density
a <- 5.5; b <- 5.5
m <- a/(a+b); s <- sqrt((a/(a+b))*(b/(a+b))/(a+b+1))
funct1 <- function(x) {dnorm(x, mean=m, sd=s)}
funct2 <- function(x) {dbeta(x, shape1=a, shape2=b)}
plot(funct1, from=0, to=1, col="blue", ylab="")
plot(funct2, from=0, to=1, col="red", add=T)


set.seed(1); nsim <- 1e5
x <- rnorm(n=nsim, mean=m, sd=s)
u <- runif(n=nsim)
ratio <- dbeta(x, shape1=a, shape2=b)/(1.3*dnorm(x, mean=m, sd=s))
ind <- I(u < ratio)
betas <- x[ind==1]
# as a check to make sure we have enough
length(betas) # gives 76836
funct2 <- function(x) {dbeta(x, shape1=a, shape2=b)}
plot(density(betas))
plot(funct2, from=0, to=1, col="red", lty=2, add=T)






Nsim=1000
M = 0.05*5000
y=runif(Nsim, min=0, max=5000)*M
plot(density(y))
lines(volLiver.grid, f_d$f_d(volLiver.grid))
y <- f_d$f_d(volLiver.grid)
summary(y)
head(y)


x = NULL



hist(y, freq=F)

while (length(x)<Nsim){
  y=runif(Nsim, min=0, max=5000)
  # get the accepted values
  x=c(x, y[runif(Nsim, min=0, max=5000)*M <f_d$f_d(y)])
  print(length(x))
}
x = x[1:Nsim]


##############################################################################
# Predict NHANES
##############################################################################
setwd('/home/mkoenig/multiscale-galactose/experimental_data/NHANES')
load(file='data/nhanes_data.dat')
nhanes.all <- data
rm(data)
head(nhanes.all)
nhanes <- nhanes.all[, c('sex', 'bodyweight', 'age', 'height', 'BSA')]
names(nhanes)
head(nhanes)
# predict the liver volume
system.time({
livVolume <- rep(0, nrow(nhanes))
for (k in seq(1,10)){
  print(k)
  sex <- nhanes$sex[k]
  age <- nhanes$age[k]
  bodyweight <- nhanes$bodyweight[k]
  BSA <- nhanes$BSA[k]
  f_d <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)
  # sample from the liver volume
  livVolume[k] <- NA
}
})
head(livVolume, 30)

nrow(nhanes)
8000/60/60





