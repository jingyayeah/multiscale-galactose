################################################################################
# Prediction Evaluation
################################################################################
# Classification of subjects based on available GEC or GECkg.
# Comparison of multiscale model based classification prediction vs. standard
# methods of logistic regression.
#
# author: Matthias Koenig
# date: 2014-02-03
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
print(packageVersion('MultiscaleAnalysis'))
setwd(ma.settings$dir.base)

############################################
# Classification data
############################################
# 1. Create a prediction dataset consisting of GEC value & disease/health state
# i.e. dataset which can be used for classification.
# The classification is based on healthy / liver disease.
#

##  All Digitized data for GEC & GECkg ##

# GEC [mmol/min] & GECkg [mmol/min/kgbw] 
## tyg1963 (age, bodyweight, [GEC, GECkg])
## sch1986.tab1 (sex, age, bodyweight, [GEC, GECkg])
## win1965 (sex, age, bodyweight, BSA, flowLiver, [GEC, GECkg] [NOT USED]
## duc1979 (sex, age, bodyweight BSA, [GEC, GECkg])
## duf2005 (sex, age, [GEC, GECkg])
## sch1968.fig1 (age, [GECkg])
## lan2011 (age, [GECkg])
names <- c('mar1988', 'tyg1963', 'sch1986.tab1', 'duc1979', 'duf1992', 'sch1986.fig1', 'lan2011')
df <- classification_data_raw(names)
save_classification_data(data=df, name='GEC_classification') # save the data for reuse
head(df)

##  Marchesini data  ##
# Load the Marchesini classification data & integrate with remaining classification data
load(file=file.path(ma.settings$dir.base, 'results', 'classification', 'GEC_marchesini.Rdata'))
df2 <- pdata[, c('sex', 'age', 'bodyweight', 'GEC', 'status', 'disease')]
df2$study <- 'marexp'
df2[, c('height', 'BSA', 'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg')] <- NA
df2$GECkg <- df2$GEC/df2$bodyweight
df2$sex <- process_sex(df2)
head(df2)

##  combine datasets ##
names <- c('study', 'sex', 'age', 'bodyweight', 'height', 'BSA', 'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg', 'GEC', 'GECkg', 'status', 'disease')
data <- rbind( df[, names], df2[,names])
rm(df, df2, pdata, names)
summary(data)

# binary classifier (disease = 0/1)
table(data$disease)

################
#   Plots        
################
# overview available data
par(mfrow = c(1,2))
bins = seq(from=0, to=5, by=0.07)
hist(data$GEC[data$disease==1], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(1,0,0,0.5), freq=FALSE)
hist(data$GEC[data$disease==0], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(0.5,0.5,0.5, 0.5), freq=FALSE, add=TRUE)

bins = seq(from=0, to=0.12, by=0.001)
hist(data$GECkg[data$disease==1], breaks=bins, xlim=c(0,0.12), xlab=lab[['GECkg']], freq=FALSE, col=rgb(1,0,0,0.5))
hist(data$GECkg[data$disease==0], breaks=bins, xlim=c(0,0.12), xlab=lab[['GECkg']], freq=FALSE, col=rgb(0.5,0.5,0.5, 0.5), add=TRUE)
par(mfrow = c(1,1))
rm(bins)
summary(data)


##############################################
#   Logistic regression GEC
##############################################
# Create logistic regression models using different subsets of the data.
# m1 : disease ~ GEC
# m2 : disease ~ GEC + bodyweight
# m3 : disease ~ GEC + bodyweight + sex
# m4 : disease ~ GEC + bodyweight + age
# m5 : disease ~ GEC + bodyweight + sex + age

#------------------------------
# Model and data preparation
#------------------------------
# formulas
formula <- list('disease ~ GEC', 
             'disease ~ GEC + bodyweight', 
             'disease ~ GEC + bodyweight + sex',
             'disease ~ GEC + bodyweight + age',
             'disease ~ GEC + bodyweight + sex + age')
# model ids
ids <- paste('m', 1:length(formula), sep='')
names(formula) <- ids
formula

## Data subsets ##
# get the necessary subset from the formula
subset_from_formula <- function(f){
  s <- strsplit(f, '~')[[1]]
  left <- trim(s[1])
  if (grepl('+', s[2])){
    right <- trim(strsplit(s[2], '\\+')[[1]])
  } else {
    right <- trim(s[2])
  }
  return(c(left, right))
}

# Create data subsets for the respective models, so that a fair comparison on the same datasets can be made
d_subset <- function(data, subset){
  indices <- complete.cases(data[, subset])
  list(df=data[indices,], 
       indices=indices)
}

# get the data subsets corresponding to the data
create_data_subset <- function(data, formula){
  d <- list()
  indices <- list()
  for (k in seq_along(formula)){
    f <- formula[[k]]
    ss <- subset_from_formula(f)  
    d.ss <- d_subset(data, ss)
    d.tmp <- d.ss$df
    indices[[k]] <- d.ss$indices
    # if sex part of model, remove the all (only male/female)
    if ('sex' %in% ss){
      d.tmp <- d.tmp[d.tmp$sex != 'all', ]
    }
    d[[k]] <- d.tmp
  }
  names(d) <- ids
  names(indices) <- ids
  list(d=d, indices=indices)
}
subsets <- create_data_subset(data, formula)
d <- subsets$d
indices <- subsets$indices
rm(subsets)


# Create an overview table of the data
create_subset_table <- function(d, formula){
  tmp <- rep(NA, length(formula))
  d.table <- data.frame(id=ids, formula=as.character(formula), H=tmp, D=tmp, C=tmp)
  rm(tmp)
  rownames(d.table) <- ids
  for (k in seq_along(d)){
    d.tmp <- d[[k]]
    H <- sum(d.tmp$disease == 0)
    D <- sum(d.tmp$disease == 1)
    C = nrow(d.tmp)
    d.table[k, c('H', 'D', 'C')] <- c(H, D, C)
  }
  d.table  
}
# save csv
d.table <- create_subset_table(d, formula)
write.table(d.table, file=file.path(ma.settings$dir.base, 'results', 'classification', 'GEC_regression_overview.csv'), 
            sep="\t", quote=FALSE, row.names=FALSE)
print(d.table)

#------------------------------
# Best case model
#------------------------------
# Create binomial models with full dataset
# These are the best case scenarios, overfitted to the full dataset
m.all <- list()
for (k in seq_along(formula)){
  m.all[[k]] <- glm(formula[[k]], data=d[[k]], family="binomial")  
}
names(m.all) <- ids
# lapply(m.all, summary)


# Create plot of the predicted values from the data
create_m1_plot <- function(){
  d_m1 <- list()
  d_m1$rankP <- predict(m.all[[1]], newdata = d[[1]], type = "response")
  d1_c <- data.frame(GEC=seq(from=0, to=5, by=0.1))
  d1_c$rankP <- predict(m.all[[1]], newdata = d1_c, type = "response")
  
  plot(d[[1]]$GEC, d[[1]]$rankP, xlim=c(0,5), xlab=lab[['GEC']], ylim=c(-0.1,1.1),
       main='Logistic regression: disease ~ GEC',
       ylab='probability liver disease')
  lines(d1_c$GEC, d1_c$rankP)
  points(d[[1]]$GEC, d[[1]]$disease, pch=21, col="black", bg=rgb(0,0,1, 0.5))  
}
create_m1_plot()

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

# install.packages('ROCR')
library(ROCR)
cols <- c('darkgreen', 'darkorange', 'darkred', 'darkblue', 'darkmagenta')
cols <- add.alpha(cols, 0.7)
names(cols) <- ids

plot_empty_roc <- function(){
  plot(numeric(0), numeric(0),main="ROC Curve for Logistic:  GEC", 
       type='n', xlim=c(0,1), ylim=c(0,1),
       xlab="False positive rate",
       ylab="True positive rate")
  abline(a=0,b=1,lwd=2,lty=2,col="gray")
  legend('bottomright', legend=as.character(formula), 
         lty=rep(1,length(ids)), lwd=rep(2, length(ids)), col=cols)
}

plot_best_roc <- function(){
 for (k in seq_along(ids)){
  id <- ids[k]
  fitpreds = predict(m.all[[id]], newdata=d[[id]], type="response")
  fitpred = prediction(fitpreds, (d[[id]])$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col=cols[k], add=TRUE, lwd="2")
 }
}

plot_empty_roc()
plot_best_roc()
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
# bootstrap model fitting based on data and formula
m_bootstrap <- function(df, formula, B=100){
  # fit all the bootstrap models
  m.boot <- as.list(rep(NA, B))
  
  # calculate for bootstrap samples
  N <- nrow(df)
  for (k in 1:B){
    inds <- sample(seq(1,N), size=N, replace=TRUE)
    # create the bootstrap data.frame
    df.boot <- df[inds, ]
    # fit model with bootstrap data
    m.boot[[k]] <- glm(formula, data=df.boot, family="binomial")
  }
  return(m.boot)
}

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
  plot(perf, lty=1, col=rgb(0.5,0.5,0.5,0.05), add=T)
  plot(perf, avg= "threshold", colorize=F, lwd=3, col=col, add=T)
}

plot_bootstrap_roc <- function(){
  for (k in seq_along(formula)){
    col = add.alpha(cols[k], 0.5)
    plot_bootstrap(d[[k]], formula[[k]], B=100, col)  
  }
}

plot_empty_roc()
plot_best_roc()
plot_bootstrap_roc()

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
  plot(perf, lty=1, col=rgb(0.5,0.5,0.5,0.2), add=T)
  plot(perf, avg= "threshold", colorize=F, lwd=3, col=col, add=T, lty=2)
}


plot_split_roc <- function(){
  for (k in seq_along(formula)){
    col = add.alpha(cols[k], 0.5)
    plot_split_sample(d[[k]], formula[[k]], B=100, col)  
  }
}


plot_best_roc()
plot_empty_roc()
plot_split_roc()

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
    cat(k, '\n')
    
    # TODO: fix prediction bug => why single NA in special case???
    q_gec[k] <- quantile(GEC[k, ], probs=q, na.rm = TRUE)
    
    mean_gec[k] <- mean(GEC[k, ])
    sd_gec[k] <- sd(GEC[k, ])
    cat('mean:', mean_gec[k], 'sd:', sd_gec[k], 'GEC:', GEC_exp[k], '\n')
  }
  # predictor = abs(mean_gec - GEC_exp)/sd_gec
  # predictor = (q_gec - GEC_exp)/sd_gec 
  predictor = (q_gec - GEC_exp)
  return(list(predictor=predictor, gec_exp=GEC_exp, mean_gec=mean_gec, sd_gec=sd_gec))
}

# TODO: plots of the predictor, i.e. histogram of normal and diesease
# plots for optimization of decision

# GAMLSS models
fit.models <- load_models_for_prediction()
# GEC function
GEC_f <- GEC_functions(task='T1')

# -------------------------------
# Prediction with GEC app
# -------------------------------
str(data)
liver.info <- predict_liver_people(data, Nsample=2000, Ncores=1, debug=TRUE)
GEC.info <- calculate_GEC(GEC_f, 
                          volLiver=liver.info$volLiver,
                          flowLiver=liver.info$flowLiver)
GEC <- GEC.info$values


# plot all
plot_empty_roc()
plot_split_roc()
# plot_bootstrap_roc()
# plot_best_roc()

# ROC for full data prediction
res <- disease_predictor(data$GEC, GEC, q=0.05)
fitpreds = res$predictor
fitpred = prediction(fitpreds, data$disease)
fitperf = performance(fitpred,"tpr","fpr")
plot(fitperf, col="black", add=TRUE, lwd="2")

# prediction for corresponding subsets of data
for (k in 1:length(formula)){
  indices <- inds[[k]]
  res <- disease_predictor(d[[k]]$GEC, GEC[indices, ], q=0.05)
  
  fitpreds = res$predictor
  fitpred = prediction(fitpreds, d[[k]]$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col=cols[k], add=TRUE, lwd="2")
}
