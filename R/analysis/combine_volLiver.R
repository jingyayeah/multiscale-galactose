# Combine the different distributions for the volume of the liver
#
# volLiver ~ age
# volLiverkg ~ age
# volLiver ~ bodyweight
# volLiver ~ BSA
rm(list=ls())
library('MultiscaleAnalysis')
library('gamlss')
setwd('/home/mkoenig/multiscale-galactose/')
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))
dir <- file.path(ma.settings$dir.expdata, "processed")


# creates the density function of the liver volume for the 
# given antropomorphic details.
f_d.volLiver.1 <- function(age, sex='all', bodyweight=NULL, BSA=NULL){
 ## get density from volLiver ~ age ##
 d.volLiver_age = NULL
 if (!is.null(age)){
  load(file=file.path(dir, 'volLiver_age_models.Rdata'))
  m.volLiver_age <- models  
  # get model and data for evaluation
  mname <- paste('fit.', sex, sep="")
  dfname <- paste('df.', sex, sep="")
  m <- m.volLiver_age[[mname]]
  assign(dfname, m.volLiver_age[[dfname]])
  # create the density function from the fitted values
  newdata <- data.frame(age=age)
  mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
  sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
  nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
  d.volLiver_age <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
 }
  return(d.volLiver_age)
}

f_d.volLiver.2 <- function(age=NULL, sex='all', bodyweight, BSA=NULL){
  ## get density from volLiver ~ bodyweight ##
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

# ! In the density generating functions the boundary
# conditions have to be tested.
f_d.volLiver.3 <- function(age=NULL, sex='all', bodyweight=NULL, BSA){
  ## get density from volLiver ~ bsa ##
  d.volLiver_BSA = NULL
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
    d.volLiver_BSA <- function(x) dNO(x, mu=mu, sigma=sigma)
  }
  return(d.volLiver_BSA)
}

## get density from volLiver ~ bsa ##

sex.types <- c('all', 'male', 'female')
sex.cols <- c('black', 'blue', 'red')
volLiver.grid <- seq(0, 3000, by=20)
age.test <- seq(1, 100, by=4)
bodyweight.test <- seq(1, 120, by=6)

par(mfrow=c(3,1))
age<-60; sex<-'male'; bodyweight<-70; BSA<-1.8
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], BSA=%s [m^2]', age, sex, bodyweight, BSA )
f.test.1 <- f_d.volLiver.1(age=age, sex=sex, bodyweight=bodyweight, BSA=BSA)
f.test.2 <- f_d.volLiver.2(age=age, sex=sex, bodyweight=bodyweight, BSA=BSA)
f.test.3 <- f_d.volLiver.3(age=age, sex=sex, bodyweight=bodyweight, BSA=BSA)
plot(volLiver.grid, f.test.1(volLiver.grid), type='l', lty=2, ylim=c(0,0.007),
     main=info)
points(volLiver.grid, f.test.2(volLiver.grid), type='l', lty=3)
points(volLiver.grid, f.test.3(volLiver.grid), type='l', lty=4)
legend("topright", legend=c('volLiver~age', 'volLiver~bodyweight', 'volLiver~BSA'), lty=c(2,3,4))

# combined normalized 
f_d.volLiver.raw <- function(x){
  return( f.test.1(x) * f.test.2(x) * f.test.3(x)  ) 
  #return( f_q1(p)*f_q2(p) ) 
}
A <- integrate(f=f_d.volLiver.raw, lower=0, upper=5000)
f_d.volLiver <- function(x){
  return( f_d.volLiver.raw(x)/A$value  ) 
  #return( f_q1(p)*f_q2(p) ) 
}
points(volLiver.grid, f_d.volLiver(volLiver.grid), type='l', lty=1, col='red', lwd=2)
legend("topright", legend=c('volLiver~age', 'volLiver~bodyweight', 'volLiver~BSA', 'combined'), lty=c(2,3,4,1),
       col=c('black', 'black', 'black', 'red'))

par(mfrow=c(1,1))

# age dependency
par(mfrow=c(1,3))
for (k in seq(1:length(sex.types))){
  sex <- gender.levels[k]
  col <- gender.cols[k]
  f_d <- f_d.volLiver.1(age=age.test[1], sex=sex, bodyweight=NULL, BSA=NULL)
  plot(volLiver.grid, f_d(volLiver.grid), type='l', col=col, main=gender.levels[k])
  legend("topright", legend=c('volLiver~age'), lty=c(1),
         col=col)
  for (age in age.test){
    print(age)
    f_d <- f_d.volLiver.1(age=age, sex=sex, bodyweight=NULL, BSA=NULL)
    points(volLiver.grid, f_d(volLiver.grid), type='l', col=col)
  }
}
par(mfrow=c(1,1))

# bodyweight dependency
par(mfrow=c(1,3))
for (k in seq(1:length(sex.types))){
  sex <- gender.levels[k]
  col <- gender.cols[k]
  f_d <- f_d.volLiver.2(age=NULL, sex=sex, bodyweight=bodyweight.test[1], BSA=NULL)
  plot(volLiver.grid, f_d(volLiver.grid), type='l', col=col, main=gender.levels[k])
  legend("topright", legend=c('volLiver~bodyweight'), lty=c(1),
         col=col)
  for (bodyweight in bodyweight.test){
    print(bodyweight)
    f_d <- f_d.volLiver.2(age=NULL, sex=sex, bodyweight=bodyweight, BSA=NULL)
    points(volLiver.grid, f_d(volLiver.grid), type='l', col=col)
  }
}
par(mfrow=c(1,1))


