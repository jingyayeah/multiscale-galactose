################################################################################
# Prediction Evaluation
################################################################################
# Classification of liver status for individual subjects based on their GEC or
# GECkg result. The prediction via the multiscale-model is compared to 
# standard logistic regression models on the same datasets.
#
# author: Matthias Koenig
# date: 2015-02-19
################################################################################
# TODO: set seed for final calculation


rm(list=ls())
library('MultiscaleAnalysis')
library('ROCR')
setwd(ma.settings$dir.base)

############################################
# Classification data
############################################
# Creating the datasets fr prediction consisting of GEC/GECkg values, 
# binary liver disease status (disease/healthy) and additional 
# subsets of anthropomorphic information.
# Classification data consists of a series of digitized publications and
# the retrospective evaluation of the data from Marchesini et al.

# Data for GEC [mmol/min] & GECkg [mmol/min/kgbw] 
# tyg1963 (age, bodyweight, [GEC, GECkg])
# sch1986.tab1 (sex, age, bodyweight, [GEC, GECkg])
# win1965 (sex, age, bodyweight, BSA, flowLiver, [GEC, GECkg] [NOT USED]
# duc1979 (sex, age, bodyweight BSA, [GEC, GECkg])
# duf2005 (sex, age, [GEC, GECkg])
# sch1968.fig1 (age, [GECkg])
# lan2011 (age, [GECkg])
names <- c('mar1988', 'tyg1963', 'sch1986.tab1', 'duc1979', 'duf1992', 'sch1986.fig1', 'lan2011')
df <- classification_data_raw(names)
save_classification_data(data=df, name='GEC_classification') # save the data for reuse
head(df)

# Marchesini data
# Load Marchesini classification data & integrate with remaining classification data
load(file=file.path(ma.settings$dir.base, 'results', 'classification', 'GEC_marchesini.Rdata'))
df2 <- pdata[, c('sex', 'age', 'bodyweight', 'GEC', 'status', 'disease')]
df2$study <- 'marexp'
df2[, c('height', 'BSA', 'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg')] <- NA
df2$GECkg <- df2$GEC/df2$bodyweight
df2$sex <- process_sex(df2)
head(df2)

# Combining datasets
names <- c('study', 'sex', 'age', 'bodyweight', 'height', 'BSA', 'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg', 'GEC', 'GECkg', 'status', 'disease')
data <- rbind( df[, names], df2[,names])
rm(df, df2, pdata, names)
summary(data)

# Test if classifier disease if really binary (disease = 0/1)
table(data$disease)
save_classification_data(data=data, name='GEC_prediction')

#----------------------------
# Overview complete dataset
#----------------------------
create_GEC_histogram(data)
summary(data)

##############################################
#   Logistic regression GEC
##############################################
#------------------------------
# Model and data preparation
#------------------------------
# Create logistic regression models with different predictors.
# Sex was never significant so is not used in any of the models.
formula <- list(
  'disease ~ GEC', 
  'disease ~ GEC + age',
  'disease ~ GEC + bodyweight', 
  'disease ~ GEC + age + bodyweight')

  # 'disease ~ GEC + bodyweight + sex',
  # 'disease ~ GEC + age + sex',
  # 'disease ~ GEC + age + bodyweight + sex')

# model ids
ids <- paste('M', 1:length(formula), sep='')
names(formula) <- ids
formula
# model colors
cols <- c('darkgreen', 'darkorange', 'red', 'blue', 'magenta', 'brown', 'black')
# cols <- add.alpha(cols, 0.7)
names(cols) <- ids

# data subsets corresponding to formulas
subsets <- create_data_subset(data, formula)
d <- subsets$d              # data subset
indices <- subsets$indices  # indices in the full dataset
rm(subsets)

# overview table for data subsets
d.table <- create_subset_table(d, formula)
write.table(d.table, file=file.path(ma.settings$dir.base, 'results', 'classification', 'GEC_regression_overview.csv'), 
            sep="\t", quote=FALSE, row.names=FALSE)
print(d.table)

#------------------------------
# Best case model
#------------------------------
# Create logistic regression models from formula
# These are the best case scenarios, overfitted to the full dataset
m.best <- list()
for (k in seq_along(formula)){
  m.best[[k]] <- glm(formula[[k]], data=d[[k]], family="binomial")  
}
names(m.best) <- ids
lapply(m.best, summary)

# Overview baseline prediction (m1)
create_m1_plot(m.best, d)

#------------------------------
# ROC curves
#------------------------------
# http://rocr.bioinf.mpi-sb.mpg.de/
# ROC curves:
#  measure="tpr", x.measure="fpr".
# Precision/recall graphs:
#  measure="prec", x.measure="rec".
# Sensitivity/specificity plots:
#  measure="sens", x.measure="spec".
# Lift charts:
#  measure="lift", x.measure="rpp".

short_formula <- function(formula){
  # do all the replacements
  sf <- formula
  sf = gsub('disease', 'LD', formula)
  for (k in 1:length(formula)){
    sf[k] = gsub('LD', sprintf('%s : LD', names(formula)[k]), sf[k])  
  }
  return(sf)
}

plot_empty_roc <- function(){
  plot(numeric(0), numeric(0),
       # main="ROC Curve for Logistic:  GEC", 
       type='n', xlim=c(0,1), ylim=c(0,1),
       font.lab=2,
       xlab="False positive rate",
       ylab="True positive rate")
  abline(a=0,b=1,lwd=2,lty=1,col="gray")
  abline(h=1, lwd=2,lty=1,col="gray")
  abline(v=0, lwd=2,lty=1,col="gray")
  Nm = length(formula)
  legend('bottomright', 
         legend=c(short_formula(formula), rep('LD multiscale', Nm)), 
         lty=c(rep(2,Nm), rep(1,Nm)), 
         lwd=c(rep(1,Nm), rep(2, Nm)), 
         col=c(cols[1:Nm], cols[1:Nm]), 
         cex=0.7, bty='n')
}
plot_empty_roc()

plot_best_roc <- function(){
 auc <- list()
 for (k in seq_along(ids)){
  id <- ids[k]
  # ROC
  fitpreds = predict(m.best[[id]], newdata=d[[id]], type="response")
  fitpred = prediction(fitpreds, (d[[id]])$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col=cols[k], add=TRUE, lwd=1, lty=2)
  # AUC
  aucperf = performance(fitpred,"auc")
  auc[[k]] = attr(aucperf, 'y.values')[[1]]
  cat('Best-AUC', auc[[k]], ' : ', ids[k], formula[[k]], '\n' )
 }
 names(auc) <- names(formula)
 return(auc)
}

plot_empty_roc()
auc_best <- plot_best_roc()
auc_best

#--------------------------------------------
# Model evaluation (logistic regression)
#--------------------------------------------
# Various methods available for testing the predictive capability 
# * split sample (training & test data)
# * cross-validation (k-fold)
# * bootstrapping

# (Steyerberg2001) We found that split-sample analyses gave overly pessimistic estimates of performance,
# with large variability. Cross-validation on 10% of the sample had low bias and low variability, 
# but was not suitable for all performance measures. Internal validity could best be estimated with bootstrapping, 
# which provided stable estimates with low bias. We conclude that split-sample validation
# is inefficient, and recommend bootstrapping for estimation of internal validity of a predictive logistic 
# regression model.
# Note that the following functions in the rms package facilitates cross-validation and bootstrapping 
# for validating models: ols, validate, calibrate.
#
# => Bootstrap as method of choice

#------------------------------
# Bootstrap
#------------------------------
plot_bootstrap <- function(df, formula, B=100, col='gray'){
  m.boot <- m_bootstrap(df, formula, B=B)
  pp <- as.list(rep(NA, B)) # predictions
  ll <- as.list(rep(NA, B)) # labels
  for (k in 1:B){
    pp[[k]] = predict(m.boot[[k]], newdata=df, type="response")
    ll[[k]] = df$disease
  }
    
  pred<- prediction(pp, ll)
  perf <- performance(pred, "tpr", "fpr")
  
  # single bootstrap curves
  # plot(perf, lty=1, col=add.alpha(col,0.2), add=T)
  # average bootstrap curve
  plot(perf, avg= "threshold", colorize=F, lwd=1, col=col, add=T, lty=2)
  auc = performance(pred,"auc")
}

plot_bootstrap_roc <- function(){
  auc <- list()
  for (k in seq_along(formula)){
    col = add.alpha(cols[k], 0.5)
    auc_k = plot_bootstrap(d[[k]], formula[[k]], B=100, col)  
    auc[[k]] = as.numeric(attr(auc_k, 'y.values') )
    cat('Bootstrap-AUC', mean(auc[[k]]), ' : ', ids[k], formula[[k]], '\n')
  }
  names(auc) <- names(formula)
  return(auc)
}

plot_empty_roc()
best_auc <- plot_best_roc()
bootstrap_auc <- plot_bootstrap_roc()
# Calculate the bootstrap mean and SD
bootstrap_auc.m <- lapply(bootstrap_auc, mean)
bootstrap_auc.sd <- lapply(bootstrap_auc, sd)


#------------------------------
# Split sample
#------------------------------
plot_split_sample <- function(df, formula, B=100, col='gray'){
  res <- m_split_sample(df, formula, B=B)
  m.split <- res$m.split
  splits <- res$splits
  pp <- as.list(rep(NA, B)) # predictions
  ll <- as.list(rep(NA, B)) # labels
  for (k in 1:B){
    pp[[k]] = predict(m.split[[k]], newdata=splits[[k]]$testset, type="response")
    ll[[k]] = (splits[[k]]$testset)$disease
  }
  pred<- prediction(pp, ll)
  perf <- performance(pred, "tpr", "fpr")
  # plot(perf, lty=1, col=rgb(0.5,0.5,0.5,0.2), add=T)
  plot(perf, avg= "threshold", colorize=F, lwd=1, col=col, add=T, lty=2)
  auc = performance(pred,"auc")
}

plot_split_roc <- function(){
  auc <- list()
  for (k in seq_along(formula)){
    col = add.alpha(cols[k], 0.5)
    auc_k <- plot_split_sample(d[[k]], formula[[k]], B=100, col)  
    auc[[k]] = as.numeric(attr(auc_k, 'y.values') )
    cat('SplitSample-AUC', mean(auc[[k]]), ' : ', ids[k], formula[[k]], '\n')
  }
  names(auc) <- names(formula)
  auc
}

plot_empty_roc()
split_auc <- plot_split_roc()
# Calculate the bootstrap mean and SD
split_auc.m <- lapply(split_auc, mean)
split_auc.sd <- lapply(split_auc, sd)


#########################################################
# Multiscale Model GEC Predictions (GEC App)
#########################################################
# GEC range based on predicted distributions of liver volumes,
# blood flows and GEC age function is calculated.

# TODO: why NAs in some prediction (fix bug, probably due to certain combinations
#   of anthropomorphic features)


# -------------------------------------------------------
# Predict distributions of liver volumes & blood flows
# -------------------------------------------------------
# GAMLSS models
fit.models <- load_models_for_prediction()
# Predict the full dataset (one predictor can handle all the information)
liver.info <- predict_liver_people(data, Nsample=2000, Ncores=11, sex_split=FALSE, debug=TRUE)
# save(liver.info, file=file.path(ma.settings$dir.base, 'results', 'classification', 'liver.info.Rdata'))
# load(file=file.path(ma.settings$dir.base, 'results', 'classification', 'liver.info.Rdata'))

# ---------------------------------------------
# Predict GEC based on Multiscale-Model
# ---------------------------------------------
# load latest GEC function
fname <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
load(file=fname)

# perform prediction
pGEC <- predict_GEC(f_GE, 
                       volLiver=liver.info$volLiver, 
                       flowLiver=liver.info$flowLiver,
                       ages=data$age)

# plot the ROC curves for the prediction
plot_multiscale_roc <- function(pGEC){
  auc <- list()
  for (k in seq_along(formula)){
    res <- disease_predictor(d[[k]]$GEC, GEC[indices[[k]], ], q=0.1)
    fitpreds = res$predictor
    fitpred = prediction(fitpreds, d[[k]]$disease)
    fitperf = performance(fitpred,"tpr","fpr")
    plot(fitperf, col=cols[k], add=TRUE, lwd=2)
    auc_k = performance(fitpred,"auc")
    auc[[k]] = as.numeric(attr(auc_k, 'y.values'))[[1]]
    cat('GEC predictor-AUC', auc[[k]], ' : ', ids[k], formula[[k]], '\n' )
  }
  names(auc) <- names(formula)
  return(auc)
}

# ---------------------------------------------
# Create AUC table
# ---------------------------------------------
# AUC & data table for evaluation
auc_best
auc_bootstrap.m <- lapply(auc_bootstrap, mean)
auc_bootstrap.sd <- lapply(auc_bootstrap, sd)
auc_split.m <- lapply(auc_split, mean)
auc_split.sd <- lapply(auc_split, sd)

rdigits <- 3
dids <- paste('D', 1:4, sep='')
d.table <- create_subset_table(d, formula)
auc_table <- data.frame(data=dids)
auc_table[,c('N', 'H', 'LD')] <- d.table[, c('N', 'H', 'LD')]
auc_table$AUC_multiscale <- round(as.numeric(auc_multiscale), rdigits)
auc_table$M <- ids
# auc_table$AUC_M_best <- round(as.numeric(auc_best), rdigits)
auc_table$M_bootstrap <- round(as.numeric(auc_bootstrap.m), rdigits)
auc_table$M_bootstrapSd <- round(as.numeric(auc_bootstrap.sd), rdigits)
auc_table

# ---------------------------------------------
# Full ROC curve
# ---------------------------------------------
# install.packages('plotrix')
library('plotrix')
do_plot = TRUE
if (do_plot){
  fname <- file.path(ma.settings$dir.base, 'results', 'classification', 'ROC.png')
  cat(fname, '\n')
  png(filename=fname, width=2000, height=2000, units = "px", bg = "white",  res = 300)
}
plot_empty_roc()
auc_bootstrap <- plot_bootstrap_roc()
# auc_split <- plot_split_roc()
# auc_best <- plot_best_roc()
auc_multiscale <- plot_multiscale_roc()
addtable2plot(0.3, 0.5, auc_table, cex=0.7)
if (do_plot){
  dev.off()
}

