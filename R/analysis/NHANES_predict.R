################################################################################
# NHANES prediction 
################################################################################
# Predict liver volume, blood flow and metabolic functions for the
# NHANES cohort. 
# Based on the individual samples of blood flow an liver the GEC clearance
# is calculated.
#
# author: Matthias Koenig
# date: 2014-12-01
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
library('methods')
setwd(ma.settings$dir.base)
source(file.path(ma.settings$dir.code, 'analysis', 'GAMLSS_predict_functions.R'))
source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))


##############################################################################
# Predict NHANES liver volume & flow
##############################################################################
# Predicting liver volume and blod flow
Nsample <- 1000  # number of Monte Carlo predictions
Ncores <- 11     # number of cores
out_dir <- file.path(ma.settings$dir.base, 'results', 'nhanes')
do_nhanes = TRUE
if (do_nhanes){
  # load empty NHANES data
  load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
  nhanes <- data[, c('SEQN', 'sex', 'bodyweight', 'age', 'height', 'BSA')]
  nhanes$volLiver <- NA
  nhanes$volLiverkg <- NA
  rm(data)
  head(nhanes)
  nrow(nhanes)
  # Reduce to subset
  nhanes <- nhanes[1:2000, ]
  
  # predict liver volume and blood flow
  set.seed(12345)   # only working for serial simulations
  ptm <- proc.time()
  # liver.info <- predict_liver_people(nhanes[1:10,], 1000, Ncores=4)
  liver.info <- predict_liver_people(nhanes, Nsample, Ncores=Ncores)
  time <- proc.time() - ptm
  print(time)
  
  # save the results
  # save('nhanes', 'liver.info', file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_liver.Rdata'))
  volLiver <- liver.info$volLiver
  flowLiver <- liver.info$flowLiver
  cat('* Saving data *\n')
  save('volLiver', file=file.path(out_dir, 'nhanes_volLiver.Rdata'))
  save('flowLiver', file=file.path(out_dir, 'nhanes_flowLiver.Rdata'))
}

##############################################################################
# Predict GEC and GECkg
##############################################################################
cat('----------------------------------------------------------\n')
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_data.Rdata'))
nhanes <- data; rm(data)
nhanes <- nhanes[1:2000, ]
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_volLiver.Rdata'))
load(file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_flowLiver.Rdata'))
cat('# Liver Volume #')
head(volLiver[, 1:5])
cat('# Liver Blood Flow #')
head(flowLiver[, 1:5])
cat('----------------------------------------------------------\n')

# Predict GEC and GECkg for NHANES
source(file.path(ma.settings$dir.code, 'analysis', 'GEC_predict_functions.R'))
GEC_f <- GEC_functions(task='T54')
GEC <- calculate_GEC(volLiver, flowLiver)
GEC <- GEC$values
m.bodyweight <- matrix(rep(nhanes$bodyweight, ncol(GEC)),
                       nrow=nrow(GEC), ncol=ncol(GEC))
GECkg <- GEC/m.bodyweight
save(GEC, file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_GEC.Rdata'))
save(GECkg, file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_GECkg.Rdata'))


# Calculation and settings of the quantiles for the data
calc_quantiles <- function(data, q.values=c(0.025, 0.25, 0.5, 0.75, 0.975)){
  qdata <- apply(data, 1, quantile, q.values)
  return ( t(qdata) )
}
volLiver.q <- calc_quantiles(volLiver)
flowLiver.q <- calc_quantiles(flowLiver)
GEC.q <- calc_quantiles(GEC)
GECkg.q <- calc_quantiles(GECkg)

# # store in the NHANES data.frame
# for (name in colnames(volLiver.q)){
#   nhanes[[sprintf('volLiver_%s', name)]]  <- volLiver.q[, name]
#   nhanes[[sprintf('flowLiver_%s', name)]]  <- flowLiver.q[, name]
#   nhanes[[sprintf('GEC_%s', name)]]  <- GEC.q[, name]
#   nhanes[[sprintf('GECkg_%s', name)]]  <- GECkg.q[, name]
# }
# store some random samples in addition
for (k in 1:5){
  nhanes[[sprintf('volLiver_sample_%d', k)]] <- volLiver[, k]
  nhanes[[sprintf('flowLiver_sample_%d', k)]] <- flowLiver[, k]
  nhanes[[sprintf('GEC_sample_%d', k)]] <- GEC[, k]
  nhanes[[sprintf('GECkg_sample_%d', k)]] <- GECkg[, k]
}

head(nhanes)
save(nhanes, volLiver.q, flowLiver.q, GEC.q, GECkg.q, file=file.path(ma.settings$dir.base, 'results', 'nhanes', 'nhanes_GEC_quantiles.Rdata'))
