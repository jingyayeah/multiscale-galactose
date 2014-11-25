# Do a proper loess fitting to explain the data
period <- 120
x=1:120
y <- sin(2*pi*x/period) + runif(length(x), -1,1)
plot(x,y)
y.loess <- loess(y ~ x, span=0.75, data.frame(x=x, y=y), se=TRUE)

summary(y.loess)

y.predict <- predict(y.loess, data.frame(x=x), se=TRUE)
y.predict$fit
y.predict$se
lines(x, y.predict$fit)

# use the R optimize function to find the peak
peak <- optimize(function(x, model)
  predict(model, data.frame(x=x)),
  c(min(x),max(x)),
  maximum=TRUE,
  model=y.loess) 
points(peak$maximum,peak$objective, pch=FILLED.CIRCLE<-19)

summary(y.loess)
# Residual standard error

y.loess$s

# hist(y.loess$residuals, breaks = 30)

# prediction interval
lines(x, y.predict$fit+y.loess$s, col='red', lwd=1)
lines(x, y.predict$fit-y.loess$s, col='red', lwd=1)
lines(x, y.predict$fit+1.96*y.loess$s, col='red', lwd=1)
lines(x, y.predict$fit-1.96*y.loess$s, col='red', lwd=1)

# confidence band for regression line (95% CI)
# A confidence band provides a representation of the uncertainty about your regression line. In a sense, you could think that the true regression line is as high as the top of that band, as low as the bottom, or wiggling differently within the band. (Note that this explanation is intended to be intuitive, and is not technically correct
# confidence intervals of prediction (1.96* standard error)
# lines(x, y.predict$fit+1.96*y.predict$se.fit, col='blue', lwd=1)
# lines(x, y.predict$fit-1.96*y.predict$se.fit, col='blue', lwd=1)

# create polygon bounds
##interval construction stuff
my.count <- seq(from=1, to=max(x), by=1)
my.count.rev <- order(my.count, decreasing=TRUE)
y.polygon <- c((y.predict$fit+1.96*y.predict$se.fit)[my.count], (y.predict$fit-1.96*y.predict$se.fit)[my.count.rev])
x.polygon <- c(my.count, my.count.rev)

##add this to the plot
polygon(x.polygon, y.polygon, col="#00009933", border=NA)

summary(y.loess)
