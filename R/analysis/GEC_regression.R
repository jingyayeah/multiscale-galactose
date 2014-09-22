##############################################
# Linear regression analyis of dependent 
# variables

# @author: Matthias Koenig
# @date: 2014-09-21
##############################################


rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

# gender color (all, male, female)
gender.levels <- c('all', 'male', 'female')
gender.cols = c("black", "blue", "red")

##############################################
# Read datasets
##############################################
# age [years], GEC (galactose elimination capacity) [mmol/min], 
# HVI (hepatic volumetric index) [units], volLiver [cm^3]
mar1988 <- read.csv(file.path(ma.settings$dir.expdata, "GEC_aging", "Marchesini1988_Fig.csv"), sep="\t")
mar1988 <- data.frame(subject=mar1988$subject, 
                      age=mar1988$age,
                      GEC=mar1988$GEC,
                      HVI=mar1988$HVI[order(mar1988$subject)],
                      volLiver=mar1988$volLiver[order(mar1988$subject)])
mar1988$study = 'mar1988'
mar1988$gender = 'all'
head(mar1988)


##############################################
# Linear regression analysis
##############################################

# Prepare data
data <- list()
data$x <- mar1988$age
data$xname <- 'age'
data$xunit <- '[years]'
data$xlim <- c(20,90)
data$y <- mar1988$GEC
data$yname <- 'GEC'
data$yunit <- '[mmol/min]'
data$ylim <- c(1.0, 5.0)

#################################################

# Perform analysis
linear_regression <- function(data){  
  attach(data)
  res <- list()
  res$name <- paste(yname, 'vs', xname)
  res$cor <- cor(x, y)
  res$cor.test <- cor.test(x, y)
  
  res$df <- data.frame(x=x, y=y)
  names(res$df) <- c(xname, yname)
  # linear regression
  # linear regression
  res$m1 <- lm(y ~ x, data=res$df)
  print(res$m1)
  
  # Confidence Limits on the Estimated Coefficients
  res$confint <- confint(res$m1, level=0.95)
  
  detach(data)
  return(res)
}

# Perform calculation
res <- linear_regression(data)

# Create output file with information
sink.fname <-  file.path(ma.settings$dir.results, 'linear_regression', paste(res$name, ".log", sep=''))
sink.file <- file(sink.fname, open = "wt")
sink(sink.file)
sink(sink.file, type="message")

print('### Linear Regression Model ###')
print('* data *')
str(data)

print('* model *')
summary(res$m1)
print(res$confint)

sink(type="message")
sink()
file.show(sink.fname)


create_plots=T
linear_regression_plots <- function(res, data){
  attach(data)
  
  if (create_plots == TRUE){
    plot.file <- file.path(ma.settings$dir.results, 'linear_regression', 
                           paste(res$name, '_plot1.png', sep=""))
    print(plot.file)               
    png(filename=plot.file,
        width = 800, height = 800, units = "px", bg = "white",  res = 150)
  }
  # Plot the linear regression with the data  
  plot(x, y, xlab=paste(xname, xunit), 
       ylab=paste(yname, yunit),
       xlim=xlim, ylim=ylim,
       main=paste(yname, 'vs.', xname))
  abline(res$m1, col='red')
  
  # get the confidence intervals for the betas
  conf.interval <- predict(res$m1, interval="confidence") 
  lines(x, conf.interval[,2], lty=2)
  lines(x, conf.interval[,3], lty=2)
  
  # get prediction intervals
  newx <- seq(min(x), max(x), length.out = 100)
  for (level in c(0.66, 0.95)){
    pred.interval <- predict(res$m1, newdata=data.frame(x=newx), interval="prediction", level=level) 
    lines(newx,pred.interval[,2], lty=3, col='blue')
    lines(newx,pred.interval[,3], lty=3, col='blue') 
  }
  if (create_plots==TRUE){ dev.off() }
  
  
  # Residual and control plots
  if (create_plots == TRUE){
    plot.file <- file.path(ma.settings$dir.results, 'linear_regression', 
                           paste(res$name, '_plot2.png', sep=""))
    print(plot.file)               
    png(filename=plot.file,
        width = 800, height = 800, units = "px", bg = "white",  res = 150)
  }
  par(mfrow=c(2,2))
  plot(res$m1)
  par(mfrow=c(1,1))
  if (create_plots==TRUE){ dev.off() }
  
  detach(data)
}

linear_regression_plots(res,data)


########################################
with(mar1988, plot(age, GEC))
df <- data.frame(x=mar1988$age, y<-mar1988$GEC)
names(df) <- c('age', 'GEC')
  
  # Residual and control plots
  par(mfrow=c(2,2))
  plot(m1)
  par(mfrow=c(1,1))
  plot(x=m1, which=6)
  
  # more advanced residual plots
  install.packages('car')
  library('car')
  residualPlots(model=m1)
  
  
}





  # create data frame
  df <- data.frame(x=x, y=y)
  names(df) <- c('x', 'y')
  
  options(show.signif.stars=T)
  
  # correlation matrix
  cor(df)
  cor.test(df[,1], df[,2])
  
  # covariance matrix
  cov(df)
  
  # visual representation of the correlation matrix
  pairs(df)
  
# more in depth analysis with the correlate() function from library(lsr)
# install.packages('lsr')
library(lsr)
correlate(df, test=TRUE)

# linear regression
m1 <- lm(GEC ~ age, data=df)
print(m1)
attributes(m1)
summary(m1)

# Interpretation of lm output
# http://stats.stackexchange.com/questions/5135/interpretation-of-rs-lm-output
# Residuals
# 5-point summary of residuals, should be normal distributed, i.e. mean ~ 0
# and |Q1| approximate |Q3|.
# Coefficients
# estimates, standard error and t-value (testing if different from zero).
# The p-value is the probability of achieving a value of t as larger or larger if the null hypothesis were true. Here the null hypothesis is the βi^ are individually 0.
# F and p for the whole model

# Each coefficient in the model is a Gaussian (Normal) random variable. The βi^ is the estimate of the mean of the distribution of that random variable, and the standard error is the square root of the variance of that distribution.

# The residual standard error is an estimate of the parameter σ. The assumption in ordinary least squares is that the residuals are individually described by a Gaussian (normal) distribution with mean 0 and standard deviation σ. The σ relates to the constant variance assumption; each residual has the same variance and that variance is equal to σ2.

# The F is the ratio of two variances, the variance explained by the parameters in the model and the residual or unexplained variance. You can see this better if we get the ANOVA table for the model via 
anova(m1)
summary(m1)

# plot the regression line
plot(df$GEC, df$age, xlab="age [years]", 
     ylab="GEC [mmol/min]",
     main="GEC vs. age")
abline(m1)


# show an ANOVA table
options(show.signif.stars=F)
anova(m1)

# a graphic display of how good the model fit is can be achieved as follows... 
# The first plot is a standard residual plot showing residuals against fitted values. Points that tend towards being outliers are labeled. If any pattern is apparent in the points on this plot, then the linear model may not be the appropriate one. The second plot is a normal quantile plot of the residuals. We like to see our residuals normally distributed. Don't we? The last plot shows residuals vs. leverage. Labeled points on this plot represent cases we may want to investigate as possibly having undue influence on the regression relationship. Case 144 is one perhaps worth taking a look at... 
par(mfrow=c(2,2))
plot(m1)
par(mfrow=c(1,1))
plot(x=m1, which=6)

# more advanced residual plots
install.packages('car')
library('car')
residualPlots(model=m1)

# Confidence Limits on the Estimated Coefficients
confint(m1, level=0.95)

# The predict() command calculates confidence intervals for the predicted values
plot(df$age, df$GEC, xlab="age [years]", 
     ylab="GEC [mmol/min]",
     main="GEC vs. age",
     xlim=c(20, 90), ylim=c(1.0, 4.5))
abline(m1, col='red')

conf.interval <- predict(m1, interval="confidence") 
lines(df$age, conf.interval[,2], lty=2)
lines(df$age, conf.interval[,3], lty=2)

# New data for prediction
newx <- seq(min(df$age), max(df$age), 0.1)
for (level in c(0.66, 0.95)){
  pred.interval <- predict(m1, newdata=data.frame(age=newx), interval="prediction", level=level) 
  lines(newx,pred.interval[,2], lty=3, col='blue')
  lines(newx,pred.interval[,3], lty=3, col='blue') 
}
hist((pred.interval[,2]-pred.interval[,3])/2)
summary(m1)

# squared correlation coefficient = R^2
cor(df)^2
summary(m1)

hist(m1$residuals, breaks=10)

summary(m1)

# how to calculate the residual standard error
# 0.4142
sqrt(deviance(m1)/df.residual(m1))
# df.residual : residual degrees of freedom
# deviance
