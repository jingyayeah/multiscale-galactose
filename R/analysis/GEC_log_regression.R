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
  v <- complete.cases(data[, subset])
  return(data[v,])
}

# get the data subsets corresponding to the data
d <- list()
for (k in seq_along(formula)){
  f <- formula[[k]]
  ss <- subset_from_formula(f)  
  d.tmp <- d_subset(data, ss)
  # if sex part of model, remove the all (only male/female)
  if ('sex' %in% ss){
    d.tmp <- d.tmp[d.tmp$sex != 'all', ]
  }
  d[[k]] <- d.tmp
}
names(d) <- ids
summary(d)

# Create an overview table of the data
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

# save csv
d.table
write.table(d.table, file=file.path(ma.settings$dir.base, 'results', 'classification', 'GEC_regression_overview.csv'), 
            sep="\t", quote=FALSE, row.names=FALSE)

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
lapply(m.all, summary)


# plot the simple regression model
# Probability for disease



# Create plot of the predicted values from the data
d_m1 <- list()
d_m1$rankP <- predict(m1, newdata = d1, type = "response")
d1_c <- data.frame(GEC=seq(from=0, to=5, by=0.1))
d1_c$rankP <- predict(m1, newdata = d1_c, type = "response")

plot(d1$GEC, d1$rankP, xlim=c(0,5), xlab=lab[['GEC']], ylim=c(-0.1,1.1),
     main='Logistic regression: disease ~ GEC',
     ylab='probability liver disease')
lines(d1_c$GEC, d1_c$rankP)
points(d1$GEC, d1$disease, pch=21, col="black", bg=rgb(0,0,1, 0.5))



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

plot_best_roc <- function(){
 plot(numeric(0), numeric(0),main="ROC Curve for Logistic:  GEC", 
     type='n', xlim=c(0,1), ylim=c(0,1),
     xlab="False positive rate",
     ylab="True positive rate")
 abline(a=0,b=1,lwd=2,lty=2,col="gray")
 for (id in ids){
  fitpreds = predict(m.all[[id]], newdata=d[[id]], type="response")
  fitpred = prediction(fitpreds, (d[[id]])$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col=cols[[id]], add=TRUE, lwd="2")
 }
 legend('bottomright', legend=as.character(formula), 
       lty=rep(1,length(ids)), lwd=rep(2, length(ids)), col=cols)
}
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
  # plot(perf, lty=1, col=rgb(0.5,0.5,0.5,0.2), add=T)
  plot(perf, avg= "threshold", colorize=F, lwd=3, col=col, add=T)
}

plot_best_roc()
for (k in seq_along(formula)){
  col = add.alpha(cols[k], 0.5)
  plot_bootstrap(d[[k]], formula[[k]], B=100, col)  
}

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
  plot(perf, avg= "threshold", colorize=F, lwd=3, col=col, add=T, lty=2)
}

plot_best_roc()
plot(numeric(0), numeric(0),main="ROC Curve for Logistic:  GEC", 
     type='n', xlim=c(0,1), ylim=c(0,1),
     xlab="False positive rate",
     ylab="True positive rate")

for (k in seq_along(formula)){
  col = add.alpha(cols[k], 0.5)
  plot_split_sample(d[[k]], formula[[k]], B=100, col)  
  plot_bootstrap(d[[k]], formula[[k]], B=100, col)  
}





# TODO: color of bootstrap runs corresponding to average of runs &
# mean/se of the bootstraps (shading of regions)

x.values = c(0.03030303, 0.07070707, 0.09090909, 0.1515152, 0.2020202, 0.2828283, 0.3838384)
y.values = c(0.6153846, 0.7692308, 0.8461538, 0.8461538, 0.8461538,  1.0, 1.0)
points(x.values, y.values, pch=22, col='black', bg='red')
lines(x.values, y.values, col='red', lwd=3)


#########################################################
# Make the predictions based on the GEC App
#########################################################
# prediction of GEC range for the persons
# Make a fair comparison on the same subset of data (delete additional information?)

# GAMLSS models
fit.models <- load_models_for_prediction()
# GEC function
GEC_f <- GEC_functions(task='T1')


# make the predictions

liver.info <- predict_liver_people(df2[1:10, ], Nsample=2000, Ncores=1, debug=TRUE)
GEC.info <- calculate_GEC(GEC_f, 
                          volLiver=liver.info$volLiver,
                          flowLiver=liver.info$flowLiver)
GEC <- GEC.info$values

# Calculate disease status based on the simulated GEC
# data and the actual experimental value.
predict_disease_status <- function(GECexp, GEC, probs=c(0.025, 0.05, 0.1, 0.15, 0.2, 0.3, 0.4)){
    disease <- matrix(NA, nrow=length(GECexp), ncol=length(probs))
    colnames(disease) = probs
    
    # predict every row
    for (k in 1:length(GECexp)){
      q <- quantile(GEC[k, ], probs=probs)
      # cat('q=', q, '\tGEC=', GECexp[k], '\n')
    
      if (!is.na(GECexp[k])){
        disease[k, ] = as.numeric(GECexp[k]<q)
      }
    }
    return(list(disease=disease, probs=probs))
}
res <- predict_disease_status(df$GEC, GEC.info$values)
res
head(res$disease, 20)
pred <- as.data.frame(res$disease)
index <- complete.cases(pred)
index

# Now predicted and calculate values which can be used for the contingency table
# calculate the contingency table & ROC curve


x.values = c(0.03030303, 0.07070707, 0.09090909, 0.1515152, 0.2020202, 0.2828283, 0.3838384)
y.values = c(0.6153846, 0.7692308, 0.8461538, 0.8461538, 0.8461538,  1.0, 1.0)
plot(x.values, y.values)



real <- matrix( rep(df$disease[index], ncol(pred)), ncol=ncol(pred) )

fitpred = prediction(pred[index, ], real)
fitperf = performance(fitpred,"tpr","fpr")
fitperf

attr(fitperf, 'x.values')

plot(attr(fitperf, 'x.values'),attr(fitperf, 'y.values'), col="darkgreen",lwd=2,main="ROC Curve for Logistic:  GEC")


hist(GEC)
abline(v=p1$GEC, lwd=2, col="red")
quantile(GEC, probs = c(0.05))


# TODO: now with the full Marchesini dataset


#########################################################

disease.fit1 <- predict(fit1, type = "response", newdata=df)
head(disease.fit1)
head(df)


### Logistic regression GECkg
fit2 <- glm(healthy ~ GECkg, data = df, family = "binomial")
summary(fit2)

# http://rocr.bioinf.mpi-sb.mpg.de/
fitpreds = predict(fit2, newdata=df, type="response")

fitpred = prediction(fitpreds, df$healthy)
fitperf = performance(fitpred,"tpr","fpr")

plot(fitperf,col="darkgreen",lwd=2,main="ROC Curve for Logistic:  GECkg")
abline(a=0,b=1,lwd=2,lty=2,col="gray")
abline(v=0,lwd=2,lty=1,col="gray")
abline(v=1,lwd=2,lty=1,col="gray")
abline(h=0,lwd=2,lty=1,col="gray")
abline(h=1,lwd=2,lty=1,col="gray")


