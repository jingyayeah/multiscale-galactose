################################################################################
# Prediction methods
################################################################################
# Combines the information from multiple pair-wise correlation to create the
# best prediction for liver volume, blood flow and GEC.
# Creates density functions based on given antropomorphic details.
# Prediction models are applicable in the normal range of anthropomporhpic
# features.
#
# methods(predict)
# getAnywhere("predict.gamlss")
#
# author: Matthias Koenig
# date: 2014-11-27
################################################################################
# rm(list=ls())
library('MultiscaleAnalysis')
library('gamlss')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))
dir <- file.path(ma.settings$dir.base, "results", 'gamlss')

################################################################################
## GAMLSS models
################################################################################
fit.models <- list()
load(file=file.path(dir, 'volLiver_age_models.Rdata'))
fit.models$volLiver_age <- models
load(file=file.path(dir, 'volLiverkg_age_models.Rdata'))
fit.models$volLiverkg_age <- models
load(file=file.path(dir, 'volLiver_bodyweight_models.Rdata'))
fit.models$volLiver_bodyweight <- models
load(file=file.path(dir, 'volLiverkg_bodyweight_models.Rdata'))
fit.models$volLiverkg_bodyweight <- models
load(file=file.path(dir, 'volLiver_height_models.Rdata'))
fit.models$volLiver_height <- models
load(file=file.path(dir, 'volLiverkg_height_models.Rdata'))
fit.models$volLiverkg_height <- models
load(file=file.path(dir, 'volLiver_BSA_models.Rdata'))
fit.models$volLiver_BSA <- models
load(file=file.path(dir, 'volLiverkg_BSA_models.Rdata'))
fit.models$volLiverkg_BSA <- models

load(file=file.path(dir, 'flowLiver_volLiver_models.Rdata'))
fit.models$flowLiver_volLiver <- models
load(file=file.path(dir, 'flowLiverkg_volLiverkg_models.Rdata'))
fit.models$flowLiverkg_volLiverkg <- models
load(file=file.path(dir, 'flowLiver_age_models.Rdata'))
fit.models$flowLiver_age <- models
load(file=file.path(dir, 'flowLiverkg_age_models.Rdata'))
fit.models$flowLiverkg_age <- models
load(file=file.path(dir, 'flowLiver_bodyweight_models.Rdata'))
fit.models$flowLiver_bodyweight <- models
load(file=file.path(dir, 'flowLiverkg_bodyweight_models.Rdata'))
fit.models$flowLiverkg_bodyweight <- models
load(file=file.path(dir, 'flowLiver_BSA_models.Rdata'))
fit.models$flowLiver_BSA <- models
load(file=file.path(dir, 'flowLiverkg_BSA_models.Rdata'))
fit.models$flowLiverkg_BSA <- models
rm(models)
names(fit.models)

################################################################################
# Density factories
################################################################################
# A general factory to create the various probability densities
# from the individual models. 
# The prediction is computational expensive. The parameters for the distribution
# have to be predicted exactely once per given person information.
f_d.parameters <- function(models, xname, person){
  if (is.na(person[[xname]])){
    return(list(link='None', person=person))
  }
  # Create dataset to predict
  newdata <- data.frame( person[[xname]] )
  names(newdata) <- c(xname)
  
  # get link function from model, predict the necessary parameters & 
  # create respective density
  mname <- paste('fit.', person$sex, sep="")
  dfname <- paste('df.', person$sex, sep="")
  m <- models[[mname]]
  assign(dfname, models[[dfname]])
  link = m$family[1]
  if (link == 'BCCG'){
    capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
    capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
    capture.output({ nu <- predict(m, what = "nu", type = "response", newdata=newdata, data=get(dfname)) })
  } else if (link =='NO'){
    capture.output({ mu <- predict(m, what = "mu", type = "response", newdata=newdata, data=get(dfname)) })
    capture.output({ sigma <- predict(m, what = "sigma", type = "response", newdata=newdata, data=get(dfname)) })
    nu <- NA
  }
  return( list(link=link, mu=mu, sigma=sigma, nu=nu, 
              xname=xname, person=person) )
}

f_d.factory <- function(pars){
  if (pars$link == 'BCCG'){
    f_d <- function(x) dBCCG(x, mu=pars$mu, sigma=pars$sigma, nu=pars$nu)
  } else if (pars$link =='NO'){
    f_d <- function(x) dNO(x, mu=pars$mu, sigma=pars$sigma)
  } else if (pars$link =='None'){
    f_d <- NA
  }
  return(f_d)
}
f_d.factory.bodyweight <- function(pars){
  bodyweight <- (pars$person)$bodyweight
  if (pars$link == 'BCCG'){
    f_d <- function(x) dBCCG(x/bodyweight, mu=pars$mu, sigma=pars$sigma, nu=pars$nu)/bodyweight
  } else if (pars$link =='NO'){
    f_d <- function(x) dNO(x/bodyweight, mu=pars$mu, sigma=pars$sigma)/bodyweight
  } else if (pars$link =='None'){
    f_d <- NA
  }
  return(f_d)
}

# Some of the distributons are not available (return NA). 
prepare_fds <- function(f_ds){
  # For the calculation of the distributions these have to be put to the 1 function
  for (k in 1:length(f_ds)){   
    if (!is.function( f_ds[[k]] ) ){
      if(is.na(f_ds[[k]])){ 
        message(sprintf('Link function not available: %s', names(f_ds)[k]))
        f_ds[[k]] <- function(x){1} 
      }
    }
  }
  return(f_ds)
}

# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=NA, volLiverkg=NA) 
# p1
# f_d.parameters(models=fit.models$volLiver_age, xname='age', p1)
# pars <- f_d.parameters(models=fit.models$volLiver_bodyweight, xname='bodyweight', p1)
# ftmp <- f_d.factory(pars=pars)
# plot(1:4000, ftmp(1:4000))
# # the bodyweight
# pars1 <- f_d.parameters(models=fit.models$volLiverkg_bodyweight, xname='bodyweight', p1)
# pars1
# ftmp1 <- f_d.factory.bodyweight(pars=pars1)
# ftmp1
# ftmp1(10)
# plot(1:4000, ftmp1(1:4000))

# Combined density
f_d.combined <- function(x, pars, yname){ 
  # get single correlation densities
  f_ds = list()
  for(name in names(pars)){
    if (grepl(sprintf("^%s_", yname), name) & !grepl("kg_", yname) ){
      f_ds[[name]] <- f_d.factory(pars[[name]])
    } 
    if (grepl(sprintf("^%skg_", yname), name)){
      f_ds[[name]] <- f_d.factory.bodyweight(pars[[name]])
    }
  }
  f_ds <- prepare_fds(f_ds)
  
  # unnormalized combined density
  f_d.raw <- function(x) {
    # return the product (independence) of the individual densities
    values <- lapply(f_ds, function(f) f(x))
    y <- Reduce( "*", values, accumulate=FALSE )
  }
  return( list(f_d=f_d.raw, f_ds=f_ds, pars) ) 
}

################################################################################
## Liver Volume (volLiver [ml])
################################################################################
# calculate volLiver parameter
f_d.volLiver.pars <- function(person){ 
  pars = list()
  # volLiver 
  for(xname in c('age', 'bodyweight', 'height', 'BSA')){
    name <- sprintf('volLiver_%s', xname)
    pars[[name]] = f_d.parameters(models=fit.models[[name]], xname=xname, person=person)
  }
  # volLiverkg
  for(xname in c('age', 'bodyweight', 'height', 'BSA')){
    name <- sprintf('volLiverkg_%s', xname)
    pars[[name]] = f_d.parameters(models=fit.models[[name]], xname=xname, person=person)
  }
  return(pars)
}

f_d.volLiver.c <- function(x, pars){
   return (f_d.combined(x, pars, yname='volLiver') )
}

# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=NA, volLiverkg=NA) 
# pars <- f_d.volLiver.pars(p1)
# ftest <- f_d.volLiver.c(pars=pars)
# x <- 1:4000
# plot(x,ftest$f_d(x))

################################################################################
## Liver Volume per bodyweight (volLiverkg [ml/kg])
################################################################################
# calculate volLiverkg parameter
f_d.volLiverkg.pars <- function(person){ 
  pars = list()
  # volLiverkg
  for(xname in c('age', 'bodyweight', 'height', 'BSA')){
    name <- sprintf('volLiverkg_%s', xname)
    pars[[name]] = f_d.parameters(models=fit.models[[name]], xname=xname, person=person)
  }
  return(pars)
}

f_d.volLiverkg.c <- function(x, pars){
  return (f_d.combined(x, pars, yname='volLiverkg') )
}

# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=NA, volLiverkg=NA) 
# pars <- f_d.volLiverkg.pars(p1)
# ftest <- f_d.volLiverkg.c(pars=pars)
# x <- 1:80
# plot(x,ftest$f_d(x))

################################################################################
## Liver Blood Flow (flowLiver [ml/min])
################################################################################
# calculate flowLiver parameter
f_d.flowLiver.pars <- function(person){ 
  pars = list()
  # flowLiver
  for(xname in c('age', 'bodyweight', 'BSA', 'volLiver')){
    name <- sprintf('flowLiver_%s', xname)
    pars[[name]] = f_d.parameters(models=fit.models[[name]], xname=xname, person=person)
  }
  # flowliverkg
  for(xname in c('age', 'bodyweight', 'BSA')){
    name <- sprintf('flowLiverkg_%s', xname)
    pars[[name]] = f_d.parameters(models=fit.models[[name]], xname=xname, person=person)
  }
  return(pars)
}

f_d.flowLiver.c <- function(x, pars){
  return (f_d.combined(x, pars, yname='flowLiver') )
}
# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=NA, volLiverkg=NA)
# pars <- f_d.flowLiver.pars(p1)
# ftest <- f_d.flowLiver.c(pars=pars)
# x <- 1:4000
# plot(x,ftest$f_d(x))
# 
# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=1400, volLiverkg=NA)
# pars <- f_d.flowLiver.pars(p1)
# ftest <- f_d.flowLiver.c(pars=pars)
# x <- 1:4000
# plot(x,ftest$f_d(x))

################################################################################
## Liver Blood Flow per Bodyweight (flowLiverkg [ml/min/kg])
################################################################################
# flowLiverkg parameter
f_d.flowLiverkg.pars <- function(person){ 
  pars = list()
  # flowLiverkg
  for(xname in c('age', 'bodyweight', 'BSA', 'volLiverkg')){
    name <- sprintf('flowLiverkg_%s', xname)
    pars[[name]] = f_d.parameters(models=fit.models[[name]], xname=xname, person=person)
  }
  return(pars)
}

f_d.flowLiverkg.c <- function(x, pars){
  return (f_d.combined(x, pars, yname='flowLiverkg') )
}

# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=NA, volLiverkg=NA) 
# pars <- f_d.flowLiverkg.pars(p1)
# ftest <- f_d.flowLiverkg.c(pars=pars)
# x <- 1:80
# plot(x,ftest$f_d(x))
# 
# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=NA, volLiverkg=20) 
# pars <- f_d.flowLiverkg.pars(p1)
# ftest <- f_d.flowLiverkg.c(pars=pars)
# x <- 1:80
# plot(x,ftest$f_d(x))


################################################################################
# Rejection sampling of f_d
################################################################################
# Sampling from distributions via rejection sampling of good guess of
# probability distribution.
f_d.rejection_sample <- function(f_d, Nsim, interval){
    # find maximum value
    #   f_d.max_x <- optimize(f_d, interval=interval, maximum=TRUE)$maximum
    #   f_d.max_y <- f_d(f_d.max_x)
    #  factor 10 faster:
    x = seq(from=interval[1], to=interval[2], length.out=400)
    y = f_d(x)
    ind.max <- which.max(y)
    x.max <- x[ind.max]
    y.max <- y[ind.max]
  
    # estimation of sd via half maximal values
    # f_d.half <- function(x){f_d(x)-0.5*f_d.max_y}
    # f_d.half_x1 <- uniroot(f_d.half, interval=c(interval[1], f_d.max_x))$root
    # f_d.half_x2 <- uniroot(f_d.half, interval=c(f_d.max_x, interval[2]))$root
    # sd <- max(f_d.max_x-f_d.half_x1, f_d.half_x2-f_d.max_x)
    ind.sdleft <- tail(which(y[1:ind.max]<=0.5*y.max),1)
    ind.sdright <- which(y[ind.max:length(y)]<=0.5*y.max)[1] + ind.max -1
    sd.left <- x.max - x[ind.sdleft] 
    sd.right <- x[ind.sdright]-x.max 
    sd <- max(sd.left, sd.right)
    
    # sample within 3*sds in the provided interval
    # s.interval = c(max(interval[1], x.max-3*sd), min(interval[2], x.max+3*sd)) 
    
    # normalization constant for rejection sampling,
    # so that the second function is above the sample function
    m <- 1.1 * y.max / (1/(sd*sqrt(2*pi)))
    funct1 <- function(x) {m*dnorm(x, mean=x.max, sd=sd)}
    
    # rejection sampling
    values <- NULL
    while(length(values) < Nsim){
        x <- rnorm(n=Nsim*2, mean=x.max, sd=sd)
        x <- x[x>0]   # guarantee that > 0, otherwise the f_d will break
        u <- runif(n=length(x))
        ratio <- f_d(x)/funct1(x)
        ind <- I(u<ratio)
        values <- c(values, x[ind==1]) 
    }
    values = values[1:Nsim]
    
    return(list(values=values, f_d=f_d, funct1=funct1) )
}


# p1 <- data.frame(age=60, sex='male', bodyweight=50, height=170, BSA=1.7, volLiver=NA, volLiverkg=NA) 
# ptm <- proc.time()
# pars.volLiver <- f_d.volLiver.pars(p1)
# # pars.volLiverkg <- f_d.volLiverkg.pars(p1)
# pars.flowLiver <- f_d.flowLiver.pars(p1)
# # pars.flowLiverkg <- f_d.flowLiverkg.pars(p1)
# proc.time() - ptm
# 
# 
# ptm <- proc.time()
# f_d1 <- f_d.volLiver.c(pars=pars.volLiver)
# proc.time() - ptm
# 
# # rm(list=ls())
# ptm <- proc.time()
# rs2 <- f_d.rejection_sample(f_d1$f_d, Nsim=500, interval=c(1, 4000))
# proc.time() - ptm
# 
# 
# # normalization for plots
# A <- integrate(f=f_d1$f_d, lower=1000, upper=3000)
# A$value
# plot(1:3000, 1/A$value*f_d1$f_d(1:3000), col='red')
# hist(rs2$values, add=TRUE, freq=FALSE, breaks=10)
# 
# 
# ptm <- proc.time()
# f_d1$f_d(1:1000)
# proc.time() - ptm
# 
# library(profr)
# p <- profr(
#   pars.volLiver <- f_d.volLiver.pars(p1),
#   0.01
# )
# plot(p)


################################################################################
# Prediction function for liver volume and blood flow
################################################################################

# Combined prediction of liver volume and 
predict_liver_person <- function(person, Nsample){
  
  pars.volLiver <- f_d.volLiver.pars(person)
  # pars.volLiverkg <- f_d.volLiverkg.pars(p1)
  # pars.flowLiver <- f_d.flowLiver.pars(p1)
  # pars.flowLiverkg <- f_d.flowLiverkg.pars(p1)

  
  volLiver = rep(NA, Nsample)
  flowLiver = rep(NA, Nsample)
  
  # individual combined probability density for liver volume
  f_d1 <- f_d.volLiver.c(pars=pars.volLiver)
  # rejection sampling of liver volume
  rs1 <- f_d.rejection_sample(f_d1$f_d, Nsim=Nsample, interval=c(1, 4000))
  volLiver <- rs1$values
    
  # now for ever liver volume the blood flow
  # individual combined probability density for blood flow  
  for (i in 1:Nsample){
    # set volLiver & predict parameters
    person$volLiver <- volLiver[i]
    pars.flowLiver <- f_d.flowLiver.pars(person)
    # sample from distribution
    f_d2 <- f_d.flowLiver.c(pars=pars.flowLiver)
    rs2 <- f_d.rejection_sample(f_d2$f_d, Nsim=1, interval=c(1, 4000))
    flowLiver[i] <- rs2$values[1]
  }
  return(list(volLiver=volLiver, flowLiver=flowLiver))
}
# predict_liver_person(person=nhanes[1,], Nsample=3)


predict_liver_people <- function(people, Nsample, Ncores=1){
  names <- colnames(people)
  if( !("sex" %in% names)) {warning("sex missing in data")}
  if( !("age" %in% names)) {warning("age missing in data")}
  if( !("bodyweight" %in% names)) {warning("bodyweight missing in data")}
  if( !("height" %in% names)) {warning("height missing in data")}
  if( !("BSA" %in% names)) {warning("BSA missing in data")}
  
  # create empty matrix
  Np = nrow(people)
  volLiver <- matrix(NA, nrow=Np, ncol=Nsample)
  flowLiver <- matrix(NA, nrow=Np, ncol=Nsample)
  
  workerFunc <- function(i){
    predict_liver_person(people[i, ], Nsample)
  }
  
  if (Ncores == 1){
    for (k in 1:Np){
      ptm <- proc.time()
      cat(k, '\n') 
      res <- workerFunc(k)
      volLiver[k, ] <- res$volLiver
      flowLiver[k, ] <- res$flowLiver
      time <- proc.time() - ptm
      print(time)
    }
  } else {
    library(parallel)
    res <- mclapply(1:Np, workerFunc, mc.cores=Ncores)
    for (k in 1:Np){
       volLiver[k, ] <- res[[k]]$volLiver
       flowLiver[k, ] <- res[[k]]$flowLiver
    }
  }
  return(list(volLiver=volLiver, flowLiver=flowLiver))
}


# load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
# nhanes <- data[, c('SEQN', 'sex', 'bodyweight', 'age', 'height', 'BSA')]
# rm(data)
# head(nhanes)
# 
# ## predict liver volume and blood flow ##
# set.seed(12345)
# cat('# serial #\n')
# ptm <- proc.time()
# liver.info <- predict_liver_people(nhanes[1:5, ], 1)
# proc.time() - ptm
# 
# cat('# parallel #\n')
# ptm <- proc.time()
# liver.info <- predict_liver_people(nhanes[1:5, ], 1, Ncores=12)
# proc.time() - ptm
# 
# liver.info$volLiver
# liver.info$flowLiver
# 
# plot(liver.info$volLiver[1,], liver.info$flowLiver[1,], xlim=c(0,2000), ylim=c(0,2000))
# plot(liver.info$volLiver[2,], liver.info$flowLiver[2,], xlim=c(0,2000), ylim=c(0,2000), col='red')
# boxplot(t(liver.info$volLiver))



