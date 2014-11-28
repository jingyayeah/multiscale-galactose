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
getAnywhere("predict.gamlss")
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
# Density factories
################################################################################
# A general factory to create the various probability densities
# from the individual models.
f_d.factory <- function(models, xname, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA, 
                        volLiver=NA, volLiverkg=NA){
  if (is.na(get(xname))){
    return(NA)
  }
  # data to predict
  newdata <- data.frame(get(xname))
  names(newdata) <- c(xname)
  
  # get link function from model, predict the necessary parameters & 
  # create respective density
  f_d = NA
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
f_d.factory.bodyweight <- function(models, xname, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA, volLiver=NA){
  # check if bodyweight and name is available
  if (is.na(get(xname))){
    return(NA)
  }
  if (is.na(bodyweight)){
    return(NA)
  }
  f_d.scale <- function(x) {
    f_d.tmp <- f_d.factory(models=models, xname=xname, 
                           sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiver=NA)
    return(f_d.tmp(x/bodyweight)/bodyweight)
  }
  return(f_d.scale)
}


# Some of the distributons are not available (return NA). 
prepare_fds <- function(f_ds){
  # For the calculation of the distributions these have to be put to the 1 function
  for (k in 1:length(f_ds)){   
    if (!is.function( f_ds[[k]] ) ){
      
      if(is.na(f_ds[[k]])){ 
        f_ds[[k]] <- function(x){1} 
      }
    }
  }
  return(f_ds)
}

################################################################################
## GAMLSS models
################################################################################
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

load(file=file.path(dir, 'flowLiver_volLiver_models.Rdata'))
models.flowLiver_volLiver <- models
load(file=file.path(dir, 'flowLiverkg_volLiverkg_models.Rdata'))
models.flowLiverkg_volLiverkg <- models
load(file=file.path(dir, 'flowLiver_age_models.Rdata'))
models.flowLiver_age <- models
load(file=file.path(dir, 'flowLiverkg_age_models.Rdata'))
models.flowLiverkg_age <- models
load(file=file.path(dir, 'flowLiver_bodyweight_models.Rdata'))
models.flowLiver_bodyweight <- models
load(file=file.path(dir, 'flowLiverkg_bodyweight_models.Rdata'))
models.flowLiverkg_bodyweight <- models
load(file=file.path(dir, 'flowLiver_BSA_models.Rdata'))
models.flowLiver_BSA <- models
load(file=file.path(dir, 'flowLiverkg_BSA_models.Rdata'))
models.flowLiverkg_BSA <- models

rm(models)

################################################################################
## Liver Volume (volLiver [ml])
################################################################################
# Combined density
f_d.volLiver.c <- function(x, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA){ 
    # Use all the single correlation density information to predict some combined density
    f_ds = list()
    f_ds[['volLiver_age']] <- f_d.factory(models=models.volLiver_age, xname='age', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiver_bodyweight']] <- f_d.factory(models=models.volLiver_bodyweight, xname='bodyweight', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiver_height']] <- f_d.factory(models=models.volLiver_height, xname='height', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiver_BSA']] <- f_d.factory(models=models.volLiver_BSA, xname='BSA', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    
    # volLiverkg info
    f_ds[['volLiverkg_age']] <- f_d.factory.bodyweight(models=models.volLiverkg_age, xname='age', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiverkg_bodyweight']] <- f_d.factory.bodyweight(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiverkg_height']] <- f_d.factory.bodyweight(models=models.volLiverkg_height, xname='height', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiverkg_BSA']] <- f_d.factory.bodyweight(models=models.volLiverkg_BSA, xname='BSA', 
                         sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds <- prepare_fds(f_ds)

    # unnormalized
    f_d.raw <- function(x) {
        f_ds[['volLiver_age']](x)*f_ds[['volLiver_bodyweight']](x)*f_ds[['volLiver_height']](x) *f_ds[['volLiver_BSA']](x) *
            f_ds[['volLiverkg_age']](x) *f_ds[['volLiverkg_bodyweight']](x) *f_ds[['volLiverkg_height']](x) *f_ds[['volLiverkg_BSA']](x)
    }
    # normalized
    # A <- integrate(f=f_d.raw, lower=0, upper=5000)
    # f_d <- function(x){f_d.raw(x)/A$value}
    return( list(f_d=f_d.raw, f_ds=f_ds,
                 sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA) ) 
}

################################################################################
## Liver Volume per bodyweight (volLiverkg [ml/kg])
################################################################################
# Combined density
f_d.volLiverkg.c <- function(x, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA){ 
    f_ds = list()
    f_ds[['volLiverkg_age']] <- f_d.factory(models=models.volLiverkg_age, xname='age', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiverkg_bodyweight']] <- f_d.factory(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiverkg_height']] <- f_d.factory(models=models.volLiverkg_height, xname='height', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['volLiverkg_BSA']] <- f_d.factory(models=models.volLiverkg_BSA, xname='BSA', 
                                    sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds <- prepare_fds(f_ds)
    
    # unnormalized
    f_d.raw <- function(x) {
        f_ds[['volLiverkg_age']](x) *f_ds[['volLiverkg_bodyweight']](x) *f_ds[['volLiverkg_height']](x) *f_ds[['volLiverkg_BSA']](x)
    }
    # normalized
    # A <- integrate(f=f_d.raw, lower=0, upper=150)
    # f_d <- function(x){f_d.raw(x)/A$value}
    return( list(f_d=f_d.raw, f_ds=f_ds,
                 sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA) ) 
}

################################################################################
## Liver Blood Flow (flowLiver [ml/min])
################################################################################
# combined density
f_d.flowLiver.c <- function(x, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA, volLiver=NA){
    f_ds = list()
    f_ds[['flowLiver_age']] <- f_d.factory(models=models.flowLiver_age, xname='age', 
                                            sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiver_bodyweight']] <- f_d.factory(models=models.flowLiver_bodyweight, xname='bodyweight', 
                                                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiver_BSA']] <- f_d.factory(models=models.flowLiver_BSA, xname='BSA', 
                                               sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiverkg_age']] <- f_d.factory.bodyweight(models=models.flowLiverkg_age, xname='age', 
                                           sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiverkg_bodyweight']] <- f_d.factory.bodyweight(models=models.flowLiverkg_bodyweight, xname='bodyweight', 
                                                  sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiverkg_BSA']] <- f_d.factory.bodyweight(models=models.flowLiverkg_BSA, xname='BSA', 
                                           sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiver_volLiver']] <- f_d.factory(models=models.flowLiver_volLiver, xname='volLiver', 
                                             sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiver=volLiver)
    f_ds <- prepare_fds(f_ds)
    
    # unnormalized
    f_d.raw <- function(x) {
        f_ds[['flowLiver_age']](x) *f_ds[['flowLiver_bodyweight']](x) *f_ds[['flowLiver_BSA']](x)*
            f_ds[['flowLiverkg_age']](x) *f_ds[['flowLiverkg_bodyweight']](x) *f_ds[['flowLiverkg_BSA']](x)*
            f_ds[['flowLiver_volLiver']](x)
    }
    # normalized
    # A <- integrate(f=f_d.raw, lower=0, upper=5000)
    # f_d <- function(x){f_d.raw(x)/A$value}
    return( list(f_d=f_d.raw, f_ds=f_ds,
                 sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver) ) 
}

################################################################################
## Liver Blood Flow per Bodyweight (flowLiverkg [ml/min/kg])
################################################################################
# combined density
f_d.flowLiverkg.c <- function(x, sex='all', age=NA, bodyweight=NA, height=NA, BSA=NA, volLiverkg=NA){
    f_ds = list()
    f_ds[['flowLiverkg_age']] <- f_d.factory(models=models.flowLiverkg_age, xname='age', 
                                           sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiverkg_bodyweight']] <- f_d.factory(models=models.flowLiverkg_bodyweight, xname='bodyweight', 
                                                  sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiverkg_BSA']] <- f_d.factory(models=models.flowLiverkg_BSA, xname='BSA', 
                                           sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    f_ds[['flowLiverkg_volLiverkg']] <- f_d.factory(models=models.flowLiverkg_volLiverkg, xname='volLiverkg', 
                                                        sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiverkg=volLiverkg)
    f_ds <- prepare_fds(f_ds)
    
    # unnormalized
    f_d.raw <- function(x) {
            f_ds[['flowLiverkg_age']](x) *f_ds[['flowLiverkg_bodyweight']](x) *f_ds[['flowLiverkg_BSA']](x)*
            f_ds[['flowLiverkg_volLiverkg']](x)
    }
    # normalized
    # A <- integrate(f=f_d.raw, lower=0, upper=80)
    # f_d <- function(x){f_d.raw(x)/A$value}
    return( list(f_d=f_d.raw, f_ds=f_ds,
                 sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver) ) 
}

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

# sex='male'; age=50; bodyweight=80; height=175; BSA=1.9;
# ptm <- proc.time()
# f_d1 <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight,
#                         height=height, BSA=BSA)
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
# hist(rs2$values, freq=FALSE, breaks =10)
# points(1:3000, f_d1$f_d(1:3000), col='red')
# 
# ptm <- proc.time()
# f_d1$f_d(1:1000)
# proc.time() - ptm
# 
# library(profr)
# p <- profr(
#   f_d.rejection_sample(f_d1$f_d, Nsim=10, interval=c(1, 4000)),
#   0.01
# )
# plot(p)


################################################################################
# Prediction function for liver volume and blood flow
################################################################################


# Combined prediction of liver volume and 
predict_liver_features <- function(people, Nsample){
  names <- colnames(people)
  if( !("sex" %in% names)) {warning("sex missing in data")}
  if( !("age" %in% names)) {warning("age missing in data")}
  if( !("bodyweight" %in% names)) {warning("bodyweight missing in data")}
  if( !("height" %in% names)) {warning("height missing in data")}
  if( !("BSA" %in% names)) {warning("BSA missing in data")}
  
  Np = nrow(people)
  # data has to have certain subfields
  
  # create empty matrix
  volLiver <- matrix(NA, nrow=Np, ncol=Nsample)
  flowLiver <- matrix(NA, nrow=Np, ncol=Nsample)
  for (k in 1:Np){
    ptm <- proc.time()
    cat(k, '\n')    
    # individual combined probability density for liver volume
    f_d1 <- f_d.volLiver.c(sex=people$sex[k], age=people$age[k], bodyweight=people$bodyweight[k],
                           height=people$height[k], BSA=people$BSA[k])
    # rejection sampling of liver volume
    rs1 <- f_d.rejection_sample(f_d1$f_d, Nsim=Nsample, interval=c(1, 4000))
    volLiver[k, ] <- rs1$values
    
    # now for ever liver volume the blood flow
    # individual combined probability density for blood flow
    for (i in 1:Nsample){
      f_d2 <- f_d.flowLiver.c(sex=people$sex[k], age=people$age[k], bodyweight=people$bodyweight[k], 
                           height=people$height[k], BSA=people$BSA[k], volLiver=volLiver[k, i])
      # rejection sampling
      rs2 <- f_d.rejection_sample(f_d2$f_d, Nsim=1, interval=c(1, 4000))
      flowLiver[k, i] <- rs2$values[1]
    }
    res <- proc.time() - ptm
    print(res)
  }  
  return(list(volLiver=volLiver, flowLiver=flowLiver))
}
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
nhanes <- data[, c('SEQN', 'sex', 'bodyweight', 'age', 'height', 'BSA')]
rm(data)
head(nhanes)

## predict liver volume and blood flow ##
set.seed(12345)
liver.info <- predict_liver_features(nhanes[1:5, ], 100)
liver.info$volLiver
liver.info$flowLiver

plot(liver.info$volLiver[1,], liver.info$flowLiver[1,], xlim=c(0,2000), ylim=c(0,2000))
plot(liver.info$volLiver[2,], liver.info$flowLiver[2,], xlim=c(0,2000), ylim=c(0,2000), col='red')

