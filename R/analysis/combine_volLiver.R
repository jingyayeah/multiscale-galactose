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
f_d.volLiver <- function(age, sex='all', bodyweight=NULL, bsa=NULL){
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
 
 ## get density from volLiver ~ bodyweight ##
 d.volLiver_bodyweight = NULL
 if (!is.null(bodyweight)){
  load(file=file.path(dir, 'volLiver_bodyweight_models.Rdata'))
  m.volLiver_bodyweight <- models  
  mname <- paste('fit.', sex, sep="")
  dfname <- paste('df.', sex, sep="")
  m <- m.volLiver_age[[mname]]
  print(m)
  assign(dfname, m.volLiver_age[[dfname]])
  # create the density function from the fitted values
  newdata <- data.frame(bodyweight=bodyweight)
  mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname))
  sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname))
  nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname))
  d.volLiver_bodyweight <- function(x) dBCCG(x, mu=mu, sigma=sigma, nu=nu)
 }
 
 ## get density from volLiver ~ bsa ##
 
  
  return(list(d.volLiver_age=d.volLiver_age,
              d.volLiver_bodyweight=d.volLiver_bodyweight))
}


sex.types <- c('all', 'male', 'female')
sex.cols <- c('black', 'blue', 'red')
volLiver.grid <- seq(0, 3000, by=20)
age.test <- seq(1, 100, by=4)
f.test <- f_d.volLiver(age=40, sex='female', bodyweight=70)
f.test


par(mfrow=c(1,3))
for (k in seq(1:length(sex.types))){
  sex <- sex.types[k]
  col <- sex.cols[k]
  f.test <- f_d.volLiver(age=age.test[1], sex=sex)
  plot(volLiver.grid, f.test(volLiver.grid), type='l', col=col)
  for (age in age.test){
    print(age)
    f.test <- f_d.volLiver(age=age, sex=sex)
    points(volLiver.grid, f.test(volLiver.grid), type='l', col=col)
  }
}
par(mfrow=c(1,1))
