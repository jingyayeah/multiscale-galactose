################################################################################
# Predict GEC data
################################################################################
# Prediction of individual GEC data from anthropomorphic information.
# Here the methods are applied to datasets which are combinations of 
# antropomorphic information and GEC or GECkg measurements.
#
# author: Matthias Koenig
# date: 2015-02-17
################################################################################
# TODO: compare the availability of additional information, i.e. different 
# subsets of available information.

# Load all the necessary functions for predictions
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# ---------------------------------------------
# Prepare dataset for prediction
# ---------------------------------------------
data = load_classification_data('GEC_prediction')
str(data)
summary(data)
# Reduce to the healthy data and age has to be availble
dp <- data[!is.na(data$age),]
dp <- dp[dp$status %in% c('healthy', 'N'), ]
summary(dp)

# Dataset for prediction of GEC (127)
dp.GEC <- dp[!is.na(dp$GEC), ]
summary(dp.GEC)

# Dataset for prediction of GECkg (181)
dp.GECkg <- dp[!is.na(dp$GECkg), ]
summary(dp.GECkg)

# ---------------------------------------------
# Prediction of liver volumes & blood flows
# ---------------------------------------------
# GAMLSS models
fit.models <- load_models_for_prediction()
# Predict volLiver and flowLiver
liver.GEC <- predict_liver_people(dp.GEC, Nsample=2000, Ncores=1, debug=TRUE)
str(liver.GEC)

# Predict volLiverkg and flowLiverkg
liver.GECkg <- predict_liverkg_people(dp.GECkg, Nsample=2000, Ncores=1, debug=TRUE)
str(liver.GECkg)


# save(liver.info, file=file.path(ma.settings$dir.base, 'results', 'classification', 'liver.info.Rdata'))
# load(file=file.path(ma.settings$dir.base, 'results', 'classification', 'liver.info.Rdata'))

# ---------------------------------------------
# Calculation of GEC & GECkg (multiscale-model)
# ---------------------------------------------
# GEC function
file_GE_f <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
load(file=file_GE_f)
library('akima')
f_GE(gal=8.0, P=1, age=20)

GEC.mat <- predict_GEC(f_GE, 
                   volLiver=liver.GEC$volLiver, 
                   flowLiver=liver.GEC$flowLiver,
                   ages=dp.GEC$age)

GECkg.mat <- predict_GECkg(f_GE, 
                       volLiverkg=liver.GECkg$volLiverkg, 
                       flowLiverkg=liver.GECkg$flowLiverkg,
                       ages=dp.GECkg$age)

# Create prediction data frame
pred <- dp.GEC
pred$pGEC <- rowMeans(GEC.mat) # mean prediction
pred$pGECSd <- rowSds(GEC.mat) # mean prediction

predkg <- dp.GECkg
predkg$pGECkg <- rowMeans(GECkg.mat) # mean prediction
predkg$pGECkgSd <- rowSds(GECkg.mat) # mean prediction

plot(predkg$GECkg, predkg$pGECkg,
     xlim=c(0,0.10),
     ylim=c(0,0.10))
abline(a=0, b=1, col="gray")

# information for plotting
studies <- levels(as.factor(dp$study))
studies
exp_pchs <- rep(22,length(studies))
names(exp_pchs) <- studies
exp_bg <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3), 'magenta')
names(exp_bg) <- studies
exp_bg <- add.alpha(exp_bg, 0.5)
exp_cols <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3), 'magenta')
names(exp_cols) <- studies
exp_cols <- add.alpha(exp_cols, 0.5)

add_exp_legend <- function(loc="topleft", subset){
  legend(loc, legend=gsub("19", "", subset), col=exp_cols[subset], pt.bg=exp_bg[subset], pch=exp_pchs[subset], cex=0.8, bty='n')
}

labels <- list(
  GEC = 'GEC experiment [mmol/min]',
  pGEC = 'GEC predicted [mmol/min]',
  dGEC = 'GEC predicted - experiment [mmol/min]',
  GECkg = 'GECkg experiment [mmol/min/kg]',
  pGECkg = 'GECkg predicted [mmol/min/kg]',
  dGECkg = 'GEC predicted - experiment [mmol/min/kg]',
  
  age = 'Age [years]'
)
limits <- list(
  GEC = c(1,4.5),
  pGEC = c(1,4.5),
  dGEC = c(-2,2),
  GECkg = c(0,0.1),
  pGECkg = c(0,0.1),
  dGECkg = c(-0.05,0.05),
  age = c(0,100)
)

empty_plot <- function(xname, yname){
  plot(numeric(0), numeric(0), type='n', font.lab=2,
       xlab=labels[[xname]],
       ylab=labels[[yname]],
       xlim=limits[[xname]],
       ylim=limits[[yname]])
}

#########################
# GEC plot
########################
par(mfrow=c(2,2))

# GEC predicted ~ GEC experiment
empty_plot("GEC", "pGEC")
abline(a = 0, b=1, col="gray")
for (study in studies){
  d <- pred[pred$study==study, ]
  segments(d$GEC, d$pGEC-d$pGECSd, d$GEC, d$pGEC+d$pGECSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- pred[pred$study==study, ]
  points(d$GEC, d$pGEC,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(prediction$study))
add_exp_legend(subset=subset)

# GEC residues ~ GEC experiment
empty_plot("GEC", "dGEC")
abline(h=0, col="gray")
for (study in studies){
  d <- pred[pred$study==study, ]
  segments(d$GEC, d$pGEC-d$GEC-d$pGECSd, d$GEC, d$pGEC-d$GEC+d$pGECSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- pred[pred$study==study, ]
  points(d$GEC, d$pGEC-d$GEC,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(prediction$study))
add_exp_legend("topright", subset=subset)

# plot(dp.GEC$age, GEC.m-dp.GEC$GEC,
#      xlab='age',
#      ylab='GEC predicted-experiment',
#      xlim=c(0,100),
#      ylim=c(-2,2), pch=21, bg=rgb(0,0,1,0.5), cex=0.8)
# abline(h= 0, col="gray")
# segments(dp.GEC$age, GEC.m-dp.GEC$GEC-GEC.sd, dp.GEC$age, GEC.m-dp.GEC$GEC+GEC.sd, 
#          col=rgb(0,0,0,0.4))

# par(mfrow=c(1,1))

#########################
# GECkg plot
########################
# GEC predicted ~ GEC experiment
empty_plot("GECkg", "pGECkg")
abline(a = 0, b=1, col="gray")
for (study in studies){
  d <- predkg[predkg$study==study, ]
  segments(d$GECkg, d$pGECkg-d$pGECkgSd, d$GECkg, d$pGECkg+d$pGECkgSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- predkg[predkg$study==study, ]
  points(d$GECkg, d$pGECkg,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(predkg$study))
add_exp_legend(subset=subset)

# GEC residues ~ GEC experiment
empty_plot("GECkg", "dGECkg")
abline(h=0, col="gray")
for (study in studies){
  d <- predkg[predkg$study==study, ]
  segments(d$GECkg, d$pGECkg-d$GECkg-d$pGECkgSd, d$GECkg, d$pGECkg-d$GECkg+d$pGECkgSd,
           col=exp_cols[[study]])
}
for (study in studies){
  cat(study, '\n')
  d <- predkg[predkg$study==study, ]
  points(d$GECkg, d$pGECkg-d$GECkg,
         bg=exp_bg[[study]], col=exp_cols[[study]], pch=exp_pchs[[study]])  
}
subset=levels(as.factor(predkg$study))
add_exp_legend("topright", subset=subset)


par(mfrow=c(1,1))

