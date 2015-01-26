################################
## Logistic regression models ##
################################
# In statistics, deviance is a quality of fit statistic for a model that is 
# often used for statistical hypothesis testing. 
# It is a generalization of the idea of using the sum of squares of residuals 
# in ordinary least squares to cases where model-fitting is achieved by maximum likelihood.

# Application to GEC prediction to discriminate between healthy and disease person.
# - Use the trainings dataset to fit the model
# - Use the model to predict the dataset
# - Cross-Validation

# On the other hand use the personalized GEC prediction for cutoff, i.e. define the best cutoff quantile 
# via the trainingsset.


##########################
# ROC curves             #
##########################




# Basic logistic regression model#
rm(list=ls())
setwd("/home/mkoenig/multiscale-galactose/R/misc/logistic_regression")
cedegren <- read.table("cedegren.txt", header=T)
head(cedegren)
# You need to create a two-column matrix of success/failure counts for your response variable. You cannot
# just use percentages. (You can give percentages but then weight them by a count of success + failures.)
attach(cedegren)
ced.del <- cbind(sDel, sNoDel)
head(ced.del)

#------------------------------------------------------------------------
# R Data Analysis Examples: Logit Regression
#------------------------------------------------------------------------
rm(list=ls())

# http://statistics.ats.ucla.edu/stat/r/dae/logit.htm
install.packages('aod')
library('aod')
library('ggplot2')

# Example: A researcher is interested in how variables, such as GRE (Graduate Record Exam scores), 
# GPA (grade point average) and prestige of the undergraduate institution, effect admission into 
# graduate school. The response variable, admit/don't admit, is a binary variable.
mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
## view the first few rows of the data
head(mydata)

# This dataset has a binary response (outcome, dependent) variable called admit. 
# There are three predictor variables: gre, gpa and rank. 
# We will treat the variables gre and gpa as continuous. The variable rank takes on the values 1 through 4. 
# Institutions with a rank of 1 have the highest prestige, while those with a rank of 4 have the lowest. 
# We can get basic descriptives for the entire data set by using summary. 
# To get the standard deviations, we use sapply to apply the sd function to each variable in the dataset.
summary(mydata)
sapply(mydata, sd)

# two-way contingency table of categorical outcome and predictors we want
# to make sure there are not 0 cells
xtabs(~admit + rank, data = mydata)

## Using the logit model 
# The code below estimates a logistic regression model using the glm (generalized linear model) function. 
# First, we convert rank to a factor to indicate that rank should be treated as a categorical variable.
mydata$rank <- factor(mydata$rank)
mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")
summary(mylogit)

# * In the output above, the first thing we see is the call, this is R reminding us what the model we ran 
# was, what options we specified, etc.
# * Next we see the deviance residuals, which are a measure of model fit. This part of output shows the distribution of the deviance residuals 
# for individual cases used in the model. Below we discuss how to use summaries of the deviance statistic to assess model fit.
# * The next part of the output shows the coefficients, their standard errors, 
# the z-statistic (sometimes called a Wald z-statistic), and the associated p-values. 
# Both gre and gpa are statistically significant, as are the three terms for rank. The logistic regression coefficients give the change 
# in the log odds of the outcome for a one unit increase in the predictor variable. 

# We can use the confint function to obtain confidence intervals for the coefficient estimates. 
# Note that for logistic models, confidence intervals are based on the profiled log-likelihood function. 
# We can also get CIs based on just the standard errors by using the default method.
confint(mylogit)
## CIs using standard errors
confint.default(mylogit)

# you can also exponentiate the coefficients and interpret them as odds-ratios. 
# R will do this computation for you. To get the exponentiated coefficients, you tell R that you want to exponentiate (exp), 
# and that the object you want to exponentiate is called coefficients and it is part of mylogit (coef(mylogit)). 
# We can use the same logic to get odds ratios and their confidence intervals, by exponentiating the confidence intervals 
# from before. To put it all in one table, we use cbind to bind the coefficients and confidence intervals column-wise.

## odds ratios only
exp(coef(mylogit))
## odds ratios and 95% CI
exp(cbind(OR = coef(mylogit), confint(mylogit)))

# You can also use predicted probabilities to help you understand the model. 
# Predicted probabilities can be computed for both categorical and continuous predictor variables. 
# In order to create predicted probabilities we first need to create a new data frame with the values we want 
# the independent variables to take on to create our predictions.
newdata1 <- with(mydata, data.frame(gre = mean(gre), gpa = mean(gpa), rank = factor(1:4)))
newdata1

# make the prediction
newdata1$rankP <- predict(mylogit, newdata = newdata1, type = "response")
newdata1

newdata2 <- with(mydata, data.frame(gre = rep(seq(from = 200, to = 800, length.out = 100),
                                              4), gpa = mean(gpa), rank = factor(rep(1:4, each = 100))))
newdata3 <- cbind(newdata2, predict(mylogit, newdata = newdata2, type = "link",
                                    se = TRUE))
newdata3 <- within(newdata3, {
  PredictedProb <- plogis(fit)
  LL <- plogis(fit - (1.96 * se.fit))
  UL <- plogis(fit + (1.96 * se.fit))
})
head(newdata3)

# It can also be helpful to use graphs of predicted probabilities to understand and/or present the model. 
# We will use the ggplot2 package for graphing. Below we make a plot with the predicted probabilities, and 95% confidence intervals.
ggplot(newdata3, aes(x = gre, y = PredictedProb)) + geom_ribbon(aes(ymin = LL,
                                                                    ymax = UL, fill = rank), alpha = 0.2) + geom_line(aes(colour = rank),
                                                                                                                      size = 1)

# We may also wish to see measures of how well our model fits. This can be particularly useful when 
# comparing competing models. The output produced by summary(mylogit) included indices of fit 
# (shown below the coefficients), including the null and deviance residuals and the AIC. 
# One measure of model fit is the significance of the overall model. This test asks whether the model 
# with predictors fits significantly better than a model with just an intercept (i.e., a null model). 
# The test statistic is the difference between the residual deviance for the model with predictors and 
# the null model. The test statistic is distributed chi-squared with degrees of freedom equal to the 
# differences in degrees of freedom between the current and the null model 
# (i.e., the number of predictor variables in the model). To find the difference in deviance for the two models 
# (i.e., the test statistic) we can use the command: 

with(mylogit, null.deviance - deviance)

# The degrees of freedom for the difference between the two models is equal to the number of predictor 
# variables in the mode, and can be obtained using:
with(mylogit, df.null - df.residual)

# Finally, the p-value can be obtained using:
with(mylogit, pchisq(null.deviance - deviance, df.null - df.residual, lower.tail = FALSE))

# The chi-square of 41.46 with 5 degrees of freedom and an associated p-value of less than 0.001 
# tells us that our model as a whole fits significantly better than an empty model. 
# This is sometimes called a likelihood ratio test (the deviance residual is -2*log likelihood). 
# To see the model's log likelihood, we type:
logLik(mylogit)


# What is complete or quasi-complete separation in logistic/probit regression and how do we deal with them?
# http://statistics.ats.ucla.edu/stat/mult_pkg/faq/general/complete_separation_logit_models.htm

#------------------------------------------------------------------------
# HSAUR: A Handbook of Statistical Analyses Using R (1st Edition)
# Logistic regression
#------------------------------------------------------------------------
# http://cran.r-project.org/web/packages/HSAUR/
# http://cran.r-project.org/web/packages/HSAUR/vignettes/Ch_logistic_regression_glm.pdf

# Functions, data sets, analyses and examples from the book ‘A Handbook of Statistical Analyses Using R’
# (Brian S. Everitt and Torsten Hothorn, Chapman & Hall/CRC, 2006). The first chapter of the book, which 
# is entitled ‘An Introduction to R’, is completely included in this package, for all other chapters, 
# a vignette containing all data analyses is available.
rm(list=ls())
install.packages('HSAUR')
library('HSAUR')

## Plasma values ##
# We can now fit a logistic regression model to the data using the glm func-
#   tion. We start with a model that includes only a single explanatory variable,
# fibrinogen. The code to fit the model is
head(plasma)
summary(plasma)
with(plasma, plot(ESR, fibrinogen))
with(plasma, plot(ESR, globulin))

# fit the logistic regression
plasma_glm_1 <- glm(ESR ~ fibrinogen, data = plasma,
                       family = binomial())
summary(plasma_glm_1)
# An increase of one unit in this vari-
# able increases the log-odds in favour of an ESR value greater than 20 by an
# estimated 1.83 with 95% confidence interval
confint(plasma_glm_1, parm = "fibrinogen")


# These values are more helpful if converted to the corresponding values for the
# odds themselves by exponentiating the estimate
exp(coef(plasma_glm_1)["fibrinogen"])

# and the confidence interval
exp(confint(plasma_glm_1, parm = "fibrinogen"))

# conditional density plot of the erythrocyte sedimentation rate (ESR)
# given fibrinogen and globulin.
data("plasma", package = "HSAUR")
layout(matrix(1:2, ncol = 2))
cdplot(ESR ~ fibrinogen, data = plasma)
cdplot(ESR ~ globulin, data = plasma)


# The confidence interval is very wide because there are few observations overall
# and very few where the ESR value is greater than 20. Nevertheless it seems
# likely that increased values of fibrinogen lead to a greater probability of an
# ESR value greater than 20.
# We can now fit a logistic regression model that includes both explanatory
# variables using the code
plasma_glm_2 <- glm(ESR ~ fibrinogen + globulin, data = plasma, 
                    family = binomial())
summary(plasma_glm_2)

# The coefficient for gamma globulin is not significantly different from zero.
# Subtracting the residual deviance of the second model from the corresponding
# value for the first model we get a value of 1.87. Tested using a 2-distribution
# with a single degree of freedom this is not significant at the 5% level and so
# we conclude that gamma globulin is not associated with ESR level. In R, the
# task of comparing the two nested models can be performed using the anova
# function
anova(plasma_glm_1, plasma_glm_2, test = "Chisq")

# Plot probabilities
prob <- predict(plasma_glm_2, type = "response")
# The plot clearly shows the increasing probability of
# an ESR value above 20 (larger circles) as the values of fibrinogen, and to a
# lesser extent, gamma globulin, increase.

plot(globulin ~ fibrinogen, data = plasma, xlim = c(2, 6),
     ylim = c(25, 55), pch = ".")
symbols(plasma$fibrinogen, plasma$globulin, circles = prob, add = TRUE)


## Women's role ##
# Two explanatory variables, sex and education. To fit a logistic regression
# model to such grouped data using the glm function we need to specify the
# number of agreements and disagreements as a two-column matrix on the left
# hand side of the model formula. We first fit a model that includes the two
# explanatory variables using the code

data("womensrole", package = "HSAUR")
womensrole

fm1 <- cbind(agree, disagree) ~ sex + education
summary(fm1)

womensrole_glm_1 <- glm(fm1, data = womensrole, family = binomial())
summary(womensrole_glm_1)

role.fitted1 <- predict(womensrole_glm_1, type = "response")

myplot <- function(role.fitted) {
  f <- womensrole$sex == "Female"
  plot(womensrole$education, role.fitted, type = "n",
         ylab = "Probability of agreeing",
         xlab = "Education", ylim = c(0,1))
  lines(womensrole$education[!f], role.fitted[!f], lty = 1)
  lines(womensrole$education[f], role.fitted[f], lty = 2)
  lgtxt <- c("Fitted (Males)", "Fitted (Females)")
  legend("topright", lgtxt, lty = 1:2, bty = "n")
  y <- womensrole$agree / (womensrole$agree + womensrole$disagree)
  text(womensrole$education, y, ifelse(f, "\\VE", "\\MA"), family = "HersheySerif", cex = 1.25)
}

myplot(role.fitted1)

# The two curves for males and females in Figure 6.6 are almost the same
# reflecting the non-significant value of the regression coefficient for sex in womensrole_
# glm_1. But the observed values plotted on Figure 6.6 suggest that
# there might be an interaction of education and sex, a possibility that can be
# investigated by applying a further logistic regression model using
fm2 <- cbind(agree,disagree) ~ sex * education
womensrole_glm_2 <- glm(fm2, data = womensrole,
                           family = binomial())
role.fitted2 <- predict(womensrole_glm_2, type = "response")
myplot(role.fitted2)


#------------------------------------------------------------------------
# logistic regression with ROC curves
#------------------------------------------------------------------------
# http://scg.sdsu.edu/logit_r/
rm(list=ls())
source("http://scg.sdsu.edu/wp-content/uploads/2013/09/dataprep.r")
fit1 = glm(income ~ ., family = binomial(logit), data = data$train)
fit1sw = step(fit1)  # Keeps all variables

install.packages('car')
library(car)
vif(fit1)

fit2 = glm(income ~.-relationship, family = binomial(logit),
           data = data$train)
vif(fit2)
# VIF for fit2 finds no variables with a high VIF. 
# Therefore the model passes the multicollinearity test. 
# There are a few other tests we can give the model before declaring it valid. 
# The first is the Durbin Watson test, which tests for correlated residuals 
# (An assumption we make is for non-correllated residuals). We can also try the crPlots() 
# function. It plots the residuals against the predictors, allowing us to see which categorical 
# variables contributed the most to variance, or allowing us to spot possible patterns
# in the residuals on numerical variables.
durbinWatsonTest(fit2)
crPlots(fit2)

# We will see how well the model predicts on new data. In the dataprep() function 
# called in the source(…) line, we split the complete dataset into 2 parts: 
# the training dataset, and the validation dataset. We will now predict 
# based on the validation dataset, and use those predictions to build a ROC 
# curve to assess the performance of our model.
install.packages('ROCR')
library(ROCR)
# http://rocr.bioinf.mpi-sb.mpg.de/
fitpreds = predict(fit2,newdata=data$val,type="response")
fitpred = prediction(fitpreds, data$val$income)

fitperf = performance(fitpred,"tpr","fpr")

plot(fitperf,col="darkgreen",lwd=2,main="ROC Curve for Logistic:  Adult")
abline(a=0,b=1,lwd=2,lty=2,col="gray")
abline(v=0,lwd=2,lty=1,col="gray")
abline(v=1,lwd=2,lty=1,col="gray")
abline(h=0,lwd=2,lty=1,col="gray")
abline(h=1,lwd=2,lty=1,col="gray")
#------------------------------------------------------------------------
# ROC curves
#------------------------------------------------------------------------
# EPICALC #
# http://www.inside-r.org/packages/cran/epicalc/docs/ROC
rm(list=ls())
install.packages('epicalc')
library('epicalc')

head(infert)
summary(infert)
table(infert$case)

# Single ROC curve from logistic regression
# Note that 'induced' and 'spontaneous' are both originally continuous variables
model1 <- glm(case ~ induced + spontaneous, data=infert, family=binomial)
logistic.display(model1)

# Having two spontaneous abortions is quite close to being infertile!
# This is actually not a causal relationship
layout(matrix(1, ncol = 1))
lroc(model1, title=TRUE, auc.coords=c(.5,.1))

# For PowerPoint presentation, the graphic elements should be enhanced as followed 
lroc(model1, title=TRUE, cex.main=2, cex.lab=1.5, col.lab="blue", cex.axis=1.3, lwd=3)
lroc1 <- lroc(model1) # The main title and auc text have disappeared
model2 <- glm(case ~ spontaneous, data=infert, family=binomial)
logistic.display(model2)
lroc2 <- lroc(model2, add=TRUE, line.col="brown", lty=2)
legend("bottomright",legend=c(lroc1$model.description, lroc2$model.description),
       lty=1:2, col=c("red","brown"), bg="white")
title(main="Comparison of two logistic regression models")
lrtest(model1, model2) 
# Number of induced abortions is associated with increased risk for infertility

# Various form of logistic regression
# Case by case data
data(ANCdata)
use(ANCdata)
glm1 <- glm(death ~ anc + clinic, binomial, data=.data)
lroc(glm1)

# Frequency format
data(ANCtable)
ANCtable
use(ANCtable)
death <- factor (death)
levels (death) <- c("no","yes")
anc <- factor (anc)
levels (anc) <- c("old","new")
clinic <- factor (clinic)
levels (clinic) <- c("A","B")
pack()
glm2 <- glm(death ~ anc + clinic, binomial, weights=Freq, data=.data)
lroc(glm2)

# yes/no format
.data$condition <- c(1,1,2,2,3,3,4,4)
data2 <- reshape (.data, timevar="death", v.name="Freq", idvar="condition", direction="wide")
data2
glm3 <- glm(cbind(Freq.yes, Freq.no) ~ anc + clinic, family=binomial, data=data2)
lroc(glm3)


# ROC from a diagnostic table
table1 <- as.table(cbind(c(1,27,56,15,1),c(0,0,10,69,21)))
colnames(table1) <- c("Non-diseased", "Diseased")
rownames(table1) <- c("15-29","30-44","45-59","60-89","90+")
table1
roc.from.table(table1)
roc.from.table(table1, title=TRUE, auc.coords=c(.4,.1), cex=1.2)

# Application of the returned list
roc1 <- roc.from.table(table1, graph=FALSE)
cut.points <- rownames(roc1$diagnostic.table)
text(x=roc1$diagnostic.table[,1], y=roc1$diagnostic.table[,2], 
     labels=cut.points, cex=1.2, col="brown")

