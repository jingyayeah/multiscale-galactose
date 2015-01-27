################################################################################
# Prediction Evaluation
################################################################################
# Classification of subjects based on available GEC or GECkg.
#
# author: Matthias Koenig
# date: 2014-12-05
################################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# 1. Create a prediction dataset consisting of GEC value & disease/health state
# i.e. dataset which can be used for classification.
# The classification is based on healthy / liver disease.

############################################
# Data Preparation Functions
############################################
# Read data into standard data frame for prediction.
prepare_data <- function(data, fields){
  df <- data.frame(matrix(NA, ncol=length(fields), nrow=nrow(data)) )
  names(df) <- fields
  for (k in 1:length(fields)){
    name <- fields[k]
    if (name %in% names(data)){
      df[ ,k] <- data[[name]] 
    }
  }
  return(df)
}

# Prepare data for the GEC prediction.
prepare_GEC_data <- function(name){
  fields <- c('study', 'gender', 'age', 'bodyweight', 'height', 'BSA', 
              'volLiver', 'volLiverkg', 'flowLiver', 'flowLiverkg', 'GEC', 'GECkg', 'status')
  data <- loadRawData(name)
  df <- prepare_data(data, fields)
}

############################################
# A Digitized data
############################################
# GEC [mmol/min] & GECkg [mmol/min/kgbw] 
# install.packages('reshape')

## tyg1963 (age, bodyweight, [GEC, GECkg])
## sch1986.tab1 (sex, age, bodyweight, [GEC, GECkg])
## win1965 (sex, age, bodyweight, BSA, flowLiver, [GEC, GECkg] [NOT USED]
## duc1979 (sex, age, bodyweight BSA, [GEC, GECkg])
## duf2005 (sex, age, [GEC, GECkg])
## sch1968.fig1 (age, [GECkg])
## lan2011 (age, [GECkg])

# create one combined data.frame
names <- c('mar1988', 'tyg1963', 'sch1986.tab1', 'duc1979', 'duf1992', 'sch1986.fig1', 'lan2011')
df.list <- list(length(names))
for (k in 1:length(names)){
  name <- names[k]
  df <- prepare_GEC_data(name)
  cat(nrow(df), '\n')
  df.list[[k]] <- df
}
library('reshape')
df <- reshape::merge_all(df.list)

# create the classification outcome (liver disease) & check that binary classifier
df$status <- as.factor(df$status)
df$disease = as.numeric(df$status != 'healthy')
summary(df)
table(df$disease)
# rename gender -> sex
names(df)[names(df)=='gender'] = 'sex'
table(df$sex)



# plot overview over the available data
par(mfrow = c(1,2))
bins = seq(from=0, to=5, by=0.25)
hist(df$GEC[df$disease==1], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(1,0,0,0.5), freq=FALSE)
hist(df$GEC[df$disease==0], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(0.5,0.5,0.5, 0.5), freq=FALSE, add=TRUE)

bins = seq(from=0, to=0.2, by=0.01)
hist(df$GECkg[df$disease==1], breaks=bins, xlim=c(0,0.2), xlab=lab[['GECkg']], freq=FALSE, col=rgb(1,0,0,0.5))
hist(df$GECkg[df$disease==0], breaks=bins, xlim=c(0,0.2), xlab=lab[['GECkg']], freq=FALSE, col=rgb(0.5,0.5,0.5, 0.5), add=TRUE)
par(mfrow = c(1,1))

### Logistic regression GEC
fit1 <- glm(disease ~ GEC, data = df, family = "binomial")
summary(fit1)

# Probability for disease
df$rankP <- predict(fit1, newdata = df, type = "response")


par(mfrow = c(1,2))
# Create plot of the predicted values from the data
fit1_c <- data.frame(GEC=seq(from=0, to=5, by=0.1))
fit1_c$rankP <- predict(fit1, newdata = fit1_c, type = "response")

plot(df$GEC, df$rankP, xlim=c(0,5), xlab=lab[['GEC']], ylim=c(-0.1,1.1),
     main='Logistic regression: disease ~ GEC',
     ylab='probability liver disease')
lines(fit1_c$GEC, fit1_c$rankP)
points(df$GEC, df$disease, pch=21, col="black", bg=rgb(0,0,1, 0.5))


# install.packages('ROCR')
library(ROCR)
# http://rocr.bioinf.mpi-sb.mpg.de/
fitpreds = predict(fit1, newdata=df, type="response")
fitpred = prediction(fitpreds, df$disease)
fitperf = performance(fitpred,"tpr","fpr")
plot(fitperf,col="darkgreen",lwd=2,main="ROC Curve for Logistic:  GEC")
abline(a=0,b=1,lwd=2,lty=2,col="gray")
par(mfrow = c(1,1))

x.values = c(0.03030303, 0.07070707, 0.09090909, 0.1515152, 0.2020202, 0.2828283, 0.3838384)
y.values = c(0.6153846, 0.7692308, 0.8461538, 0.8461538, 0.8461538,  1.0, 1.0)
points(x.values, y.values, pch=22, col='black', bg='red')
lines(x.values, y.values, col='red')

#########################################################
# Make the predictions based on the GEC App
#########################################################
# prediction of GEC range for the persons

# GAMLSS models
fit.models <- load_models_for_prediction()
# GEC function
GEC_f <- GEC_functions(task='T1')


# make the predictions
liver.info <- predict_liver_people(df, Nsample=2000, Ncores=1, debug=TRUE)
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



p1


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


