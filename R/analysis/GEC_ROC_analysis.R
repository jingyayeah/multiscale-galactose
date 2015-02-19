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
 auc <- rep(NA, length(ids))
 names(auc) <- ids
 for (k in seq_along(ids)){
  id <- ids[k]
  # ROC
  fitpreds = predict(m.best[[id]], newdata=d[[id]], type="response")
  fitpred = prediction(fitpreds, (d[[id]])$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col=cols[k], add=TRUE, lwd=1, lty=2)
  # AUC
  aucperf = performance(fitpred,"auc")
  auc[k] = attr(aucperf, 'y.values')[[1]]
  cat('Best-AUC', auc[k], ' : ', ids[k], formula[[k]], '\n' )
 }
 return(auc)
}

plot_empty_roc()
auc_best <- plot_best_roc()
auc_best


##############################################################################
# Realistic case 
##############################################################################
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
plot_bootstrap <- function(df, formula, B=10, col='gray'){
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
lapply(bootstrap_auc, mean)
lapply(bootstrap_auc, sd)
ids

#------------------------------
# Split sample
#------------------------------
# splitdf function will return a list of training and testing sets
splitdf <- function(df, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(df)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- df[trainindex, ]
  testset <- df[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

# split sample
m_split_sample <- function(df, formula, B=100){
  # fit all the bootstrap models
  m.split <- as.list(rep(NA, B))
  splits <- as.list(rep(NA, B))
  
  # calculate split sample model
  N <- nrow(df)
  for (k in 1:B){
    splits[[k]] <- splitdf(df)
    m.split[[k]] <- glm(formula, data=splits[[k]]$trainset, family="binomial")
  }
  return(list(m.split=m.split, splits=splits))
}

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
  plot(perf, avg= "threshold", colorize=F, lwd=1, col=col, add=T, lty=1)
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
}


plot_best_roc()
plot_empty_roc()
auc <- plot_split_roc()

# TODO: color of bootstrap runs corresponding to average of runs &
# mean/se of the bootstraps (shading of regions)


#########################################################
# Predictions based on the GEC App
#########################################################
# prediction of GEC range for the persons
# Make a fair comparison on the same subset of data

# Calculate disease status based on the simulated GEC
# data and the actual experimental value.
# Here the predicted distribution of expected values is transformed into a predictor, i.e. 
# a numerical range of values.
# Depending on the cutoff different
disease_predictor <- function(GEC_exp, GEC, q=0.05){
  N <- length(GEC_exp)
  predictor <- rep(NA, N)
  mean_gec <- rep(NA, N)
  sd_gec <- rep(NA, N)
  q_gec <- rep(NA, N)
  
  # predict every row
  for (k in 1:length(GEC_exp)){
    # TODO: fix prediction bug => why single NA in special case???
    if (any(is.na(GEC[k, ])))
      warning('NAs in predicted GEC')
           
    q_gec[k] <- quantile(GEC[k, ], probs=q, na.rm = TRUE)
    
    mean_gec[k] <- mean(GEC[k, ])
    sd_gec[k] <- sd(GEC[k, ])
  }
  # predictor = abs(mean_gec - GEC_exp)/sd_gec
  # predictor = (q_gec - GEC_exp)/sd_gec 
  predictor = (q_gec - GEC_exp)
  return(list(predictor=predictor, gec_exp=GEC_exp, mean_gec=mean_gec, sd_gec=sd_gec))
}

# TODO: plots of the predictor, i.e. histogram of normal and diesease
# plots for optimization of decision

# ---------------------------------------------
# Prediction of liver volumes & blood flows
# ---------------------------------------------
# GAMLSS models
fit.models <- load_models_for_prediction()
# Predict
str(data)
liver.info <- predict_liver_people(data, Nsample=2000, Ncores=11, sex_split=FALSE, debug=TRUE)
# save(liver.info, file=file.path(ma.settings$dir.base, 'results', 'classification', 'liver.info.Rdata'))
# load(file=file.path(ma.settings$dir.base, 'results', 'classification', 'liver.info.Rdata'))


# ---------------------------------------------
# Calculation of GEC (multiscale-model)
# ---------------------------------------------
# load latest GEC function
fname <- file.path(ma.settings$dir.base, 'results', 'GEC_curves', 'latest.Rdata')
load(file=fname)
GEC <- predict_GEC(f_GE, 
                       volLiver=liver.info$volLiver, 
                       flowLiver=liver.info$flowLiver,
                       ages=data$age)
summary(data)
hist(GEC,
     xlab='GEC [mmol/min]')


# ---------------------------------------------
# Create the ROC curve
# ---------------------------------------------
do_plot = FALSE
if (do_plot){
  fname <- file.path(ma.settings$dir.base, 'results', 'classification', 'ROC.png')
  png(filename=fname, width=1000, height=1000, units = "px", bg = "white",  res = 150)
}
plot_empty_roc()
# plot_split_roc()
plot_bootstrap_roc()
# plot_best_roc()

# prediction for corresponding subsets of data
for (k in 1:length(formula)){
  res <- disease_predictor(d[[k]]$GEC, GEC[indices[[k]], ], q=0.01)
  fitpreds = res$predictor
  fitpred = prediction(fitpreds, d[[k]]$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col=cols[k], add=TRUE, lwd=2)
  auc = performance(fitpred,"auc")
  auc_value = attr(auc, 'y.values')[[1]]
  cat('GEC predictor-AUC', auc_value, ' : ', ids[k], formula[[k]], '\n' )
}
if (do_plot){
  dev.off()
}


# ROC for full data prediction
res <- disease_predictor(data$GEC, GEC, q=0.05)
fitpreds = res$predictor
fitpred = prediction(fitpreds, data$disease)
fitperf = performance(fitpred,"tpr","fpr")
plot(fitperf, col="black", add=TRUE, lwd=4)
auc = performance(fitpred,"auc")
print(auc)

test <- which(is.na(GEC[,1]))
print(test)
test[1] %in% indices[[1]]
