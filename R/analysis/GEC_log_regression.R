################################################################################
# Prediction Evaluation
################################################################################
# Classification of subjects based on available GEC or GECkg.
# Comparison of multiscale model based classification prediction vs. standard
# methods of logistic regression.
#
# author: Matthias Koenig
# date: 2014-02-02
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
# All Digitized data for GEC & GECkg
# GEC [mmol/min] & GECkg [mmol/min/kgbw] 
# install.packages('reshape')

## tyg1963 (age, bodyweight, [GEC, GECkg])
## sch1986.tab1 (sex, age, bodyweight, [GEC, GECkg])
## win1965 (sex, age, bodyweight, BSA, flowLiver, [GEC, GECkg] [NOT USED]
## duc1979 (sex, age, bodyweight BSA, [GEC, GECkg])
## duf2005 (sex, age, [GEC, GECkg])
## sch1968.fig1 (age, [GECkg])
## lan2011 (age, [GECkg])

names <- c('mar1988', 'tyg1963', 'sch1986.tab1', 'duc1979', 'duf1992', 'sch1986.fig1', 'lan2011')
df <- classification_data_raw(names)
head(df)

# save the data for reuse
save_classification_data(data=df, name='GEC_classification')

# Load the Marchesini classification data & integrate with remaining classification
# data
load(file=file.path(ma.settings$dir.base, 'results', 'classification', 'GEC_marchesini.Rdata'))
head(pdata)
summary(as.factor(pdata$sex))

df2 <- pdata[, c('sex', 'age', 'bodyweight', 'GEC', 'status', 'disease')]
df2$study <- 'marexp'
df2[, c('height', 'BSA', 'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg')] <- NA
df2$GECkg <- df2$GEC/df2$bodyweight
df2$sex <- process_sex(df2)
head(df2)

# combine datasets
names <- c('study', 'sex', 'age', 'bodyweight', 'height', 'BSA', 'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg', 'GEC', 'GECkg', 'status', 'disease')
data <- rbind( df[, names], df2[,names])
summary(data)

# binary classifier (disease = 0/1)
table(data$disease)

################
#   Plots        
################
# plot overview over the available data
par(mfrow = c(1,2))
bins = seq(from=0, to=5, by=0.07)
hist(data$GEC[data$disease==1], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(1,0,0,0.5), freq=FALSE)
hist(data$GEC[data$disease==0], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(0.5,0.5,0.5, 0.5), freq=FALSE, add=TRUE)

bins = seq(from=0, to=0.12, by=0.001)
hist(data$GECkg[data$disease==1], breaks=bins, xlim=c(0,0.12), xlab=lab[['GECkg']], freq=FALSE, col=rgb(1,0,0,0.5))
hist(data$GECkg[data$disease==0], breaks=bins, xlim=c(0,0.12), xlab=lab[['GECkg']], freq=FALSE, col=rgb(0.5,0.5,0.5, 0.5), add=TRUE)
par(mfrow = c(1,1))

nrow(data)
summary(data)
summary(as.factor(data$sex))


##############################################
#   Logistic regression GEC
##############################################
# Create 3 logistic regression models using different subsets of the data.
# m1 : disease ~ GEC
# m2 : disease ~ GEC + bodyweight
# m3 : disease ~ GEC + bodyweight + sex
# m4 : disease ~ GEC + bodyweight + age
# m5 : disease ~ GEC + bodyweight + sex + age


## Formulas ##
formula <- list('disease ~ GEC', 
             'disease ~ GEC + bodyweight', 
             'disease ~ GEC + bodyweight + sex',
             'disease ~ GEC + bodyweight + age',
             'disease ~ GEC + bodyweight + sex + age')
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

# d1 <- d_subset(data, c('disease', "GEC"))
# head(d1, 20)
# d2 <- d_subset(data, c('disease', 'GEC', 'bodyweight'))
# d3 <- d_subset(data, c('disease', 'GEC', 'sex'))
# d3 <- d3[d3$sex != 'all', ]
# count(d3$disease)
# tmp <- d3[d3$disease == 0, c('disease', 'GEC', 'bodyweight', 'sex') ]
# 
# d4 <- d_subset(data, c('disease', 'GEC', 'bodyweight', 'age'))
# count(d4$disease)
#  # make sure that male/female subset
# d5 <- d_subset(data, c('disease', 'GEC', 'bodyweight', 'sex', 'age'))
# d5 <- d5[d5$sex != 'all', ]
# count(d5$disease)

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
d.table
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

## Logistic regression ##
# Here the full dataset is used, i.e. no split in trainings & validation dataset.
# Do some proper cross-validation => measure performance on validation data-set

# Create binomial models with full dataset
m <- list()
for (k in seq_along(formula)){
  # fit model with the full dataset
  m[[k]] <- glm(formula[[k]], data=d[[k]], family="binomial")  
}
names(m) <- ids

lapply(m, summary)

# confidence intervals, bootstrap, crossvalidation
d1 <- d[[1]]
f <- formula[[1]]
m1 <- glm(disease ~ GEC + bodyweight, data=d1, family="binomial")


##############################################################################
# Testing predictive value of model
##############################################################################
# Various methods available: 
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

## Cross-Validation (k-fold & leave-one-out) ##
# The drawback to leave-one-out CV is subtle but often decisive. Since each training
# set has n 􀀀 1 points, any two training sets must share n 􀀀 2 points. The models fit
# to those training sets tend to be strongly correlated with each other. Even though
# we are averaging n out-of-sample forecasts, those are correlated forecasts, so we are
# not really averaging away all that much noise. With k-fold CV, on the other hand,
# the fraction of data shared between any two training sets is just k􀀀2
# k􀀀1 , not n􀀀2 n􀀀1 , so even though the number of terms being averaged is smaller, they are less correlated.

## split-sample ##
# do a repeated split in training and test data 
# - fit the model
# - test the trainings data set

# splitdf function will return a list of training and testing sets
splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

#apply the function
splits <- splitdf(d1, seed=808)
summary(splits)
lapply(splits,nrow)
lapply(splits,head, 20)
fun_1 <- function(df){
  table(df$study)
}
lapply(splits, fun_1)

plot(numeric(0), numeric(0), col="darkgreen",lwd=2,main="ROC Curve for Logistic:  GEC", type='n',
     xlim=c(0,1), ylim=c(0,1))
abline(a=0,b=1,lwd=2,lty=2,col="gray")
m[[1]] <- glm(formula[[1]], data=d1, family="binomial")
fitpreds = predict(m1, newdata=d1, type="response")
fitpred = prediction(fitpreds, d1$disease)
fitperf = performance(fitpred,"tpr","fpr")
plot(fitperf, col='darkgreen', add=TRUE, lwd="2")

set.seed(1234)
N = 20
for (k in 1:20){
  splits <- splitdf(d1)
  m.cv <- glm(formula[[1]], data=splits$trainset, family="binomial")
  fitpreds = predict(m.cv, newdata=splits$testset, type="response")
  fitpred = prediction(fitpreds, splits$testset$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col='lightgreen', add=TRUE, lwd="1")
}

# Bootstrap Model fitting
library('boot')


# bootstrap calculation of function
m_bootstrap <- function(df, formula, B=100){
  # fit all the bootstrap models
  m <- as.list(rep(NA, B))
  
  # calculate for bootstrap samples
  N <- nrow(df)
  for (k in 1:B){
    inds <- sample(seq(1,N), size=N, replace=TRUE)
    # create the bootstrap data.frame
    df.boot <- df[inds, ]
    print(model with bootstrap data
    m[[k]] <- glm(formula, data=df.boot, family="binomial")
  }
  return(m)
}

plot_bootstrap <- function(df, formula, B=100, col='gray'){
  m.boot <- m_bootstrap(df, formula, B=B)
  for (m.b in m.boot){
    # prinds = predict(m.b, newdata=df, type="response")
    fitpred = prediction(fitpreds, df$disease)
    fitperf = performance(fitpred,"tpr","fpr")
    plot(fitperf, col=col, add=TRUE, lwd="1")  
  }
}

cols <- c('darkgreen', 'darkorange', 'darkred', 'darkblue', 'darkmagenta')

for (k in seq_along(formula)){
  col = add.alpha(cols[k], 0.2)
  plot_bootstrap(d[[k]], formula[[k]], B=100, cols[k]) 






# Calculate bootstrap sd for confidence intervals
d2.se <- ddply(parscl, c("gal_challenge", 'f_flow'), f_bootstrap, funct=sd, B=1000)




























# The predict() command can calculate confidence intervals for the predicted values
a <- predict(mod1, interval="confidence") 



# m1 analysis, i.e. plot of the probabilities

# Probability for disease
d1$rankP <- predict(m1, newdata = d1, type = "response")

par(mfrow = c(1,2))
# Create plot of the predicted values from the data
d1_c <- data.frame(GEC=seq(from=0, to=5, by=0.1))
d1_c$rankP <- predict(m1, newdata = d1_c, type = "response")

plot(d1$GEC, d1$rankP, xlim=c(0,5), xlab=lab[['GEC']], ylim=c(-0.1,1.1),
     main='Logistic regression: disease ~ GEC',
     ylab='probability liver disease')
lines(d1_c$GEC, d1_c$rankP)
points(d1$GEC, d1$disease, pch=21, col="black", bg=rgb(0,0,1, 0.5))


# install.packages('ROCR')
library(ROCR)
# http://rocr.bioinf.mpi-sb.mpg.de/

# store models & data in list

fitpreds = predict(m1, newdata=d1, type="response")
fitpred = prediction(fitpreds, d1$disease)
m1.perf = performance(fitpred,"tpr","fpr")

fitpreds = predict(fit3, newdata=data, type="response")
fitpred = prediction(fitpreds, data$disease)
fitperf = performance(fitpred,"tpr","fpr")

plot(m1.perf, col="darkgreen",lwd=2,main="ROC Curve for Logistic:  GEC", type='n',
     xlim=c(0,1), ylim=c(0,1))
abline(a=0,b=1,lwd=2,lty=2,col="gray")
plot(m1.perf, col='darkgreen', add=TRUE)



plot(fitperf, col='red', add=TRUE)

fitpreds = predict(fit2, newdata=data, type="response")
fitpred = prediction(fitpreds, data$disease)
fitperf = performance(fitpred,"tpr","fpr")
plot(fitperf, col='black', add=TRUE)


x.values = c(0.03030303, 0.07070707, 0.09090909, 0.1515152, 0.2020202, 0.2828283, 0.3838384)
y.values = c(0.6153846, 0.7692308, 0.8461538, 0.8461538, 0.8461538,  1.0, 1.0)
points(x.values, y.values, pch=22, col='black', bg='red')
lines(x.values, y.values, col='red')
par(mfrow = c(1,1))

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


