##############################################
# Linear regression analyis of dependent 
# variables

# Prepare data
# data <- list()
# data$x <- mar1988$age
# data$xname <- 'age'
# data$xunit <- '[years]'
# data$xlim <- c(20,90)
# data$y <- mar1988$GEC
# data$yname <- 'GEC'
# data$yunit <- '[mmol/min]'
# data$ylim <- c(1.0, 5.0)

# @author: Matthias Koenig
# @date: 2014-09-21
##############################################
create_plots = T

##############################################
# Linear regression analysis
##############################################
linear_regression <- function(data){  
  attach(data)
  res <- list()
  res$name <- paste(yname, 'vs', xname)
  res$cor <- cor(x, y)
  res$cor.test <- cor.test(x, y)  
  res$df <- data.frame(x=x, y=y)
  names(res$df) <- c(xname, yname)

  # linear regression
  res$m1 <- lm(y ~ x, data=res$df)
  print(res$m1)
  
  # Confidence Limits on the Estimated Coefficients
  res$confint <- confint(res$m1, level=0.95)
  
  detach(data)
  return(res)
}

res <- linear_regression(lm.data)

##############################################
# Info file
##############################################
sink.fname <-  file.path(ma.settings$dir.results, 'linear_regression', paste(res$name, ".log", sep=''))
sink.file <- file(sink.fname, open = "wt")
sink(sink.file)
sink(sink.file, type="message")

print('### Linear Regression Model ###')
print('* data *')
str(lm.data)
print('* model *')
summary(res$m1)
print(res$confint)

sink(type="message")
sink()
file.show(sink.fname)

##############################################
# Create Plots
##############################################
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
  print(str(conf.interval))
  print(str(x))
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

linear_regression_plots(res,data=lm.data)
