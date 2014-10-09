# R Bootstrap examples #
########################
# Here, we will estimate the size of the standard error by applying the bootstrap
# and sampling many samples with replacement from the original sample, each the same size as the
# original sample, computing a point estimate for each, and nding the standard deviation of this
# distribution of bootstrap statistics.
rm(list = ls())
library(Lock5Data)
data(CommuteAtlanta)
str(CommuteAtlanta)

# point estimate
time.mean <- with(CommuteAtlanta, mean(Time))
# do the samples
B <- 1000  # number of samples
n <- nrow(CommuteAtlanta)
boot.samples <- matrix(sample(CommuteAtlanta$Time, size=B*n, replace=TRUE), B, n)
dim(boot.samples)

# function should be applied to each row
boot.statistics <- apply(boot.samples, 1, mean)

# plot the results
require(ggplot2)
ggplot(data.frame(meanTime=boot.statistics), aes(x=meanTime)) + geom_histogram(binwidth=0.25, aes(y=..density..)) + geom_density(color='red')

# get the standard deviation of the simulated bootstrap
time.se <- sd(boot.statistics)
print(time.se)
# Finally, construct the confidence interval. Here, I round the margin of error up and to one
# decimal place so that it has two signicant digits, and I am being cautious when rounding not to
# make the interval too small.
cis <- time.mean + c(-1, 1) * 2*time.se
print(cis)
# the accuracy of the inference depends on the original sample being representative from the population
# of interest


# Bret Larget
# January 10, 2014
# A quick bootstrap function for a confidence interval for the mean
# x is a single quantitative sample
# B is the desired number of bootstrap samples to take
# binwidth is passed on to geom_histogram()
boot.mean = function(x,B,binwidth=NULL) {
  n = length(x)
  boot.samples = matrix( sample(x,size=n*B,replace=TRUE), B, n)
  boot.statistics = apply(boot.samples,1,mean)
  se = sd(boot.statistics)
  require(ggplot2)
  if ( is.null(binwidth) )
    binwidth = diff(range(boot.statistics))/30
    p = ggplot(data.frame(x=boot.statistics),aes(x=x)) + geom_histogram(aes(y=..density..),binwidth=binwidth) + geom_density(color="red")
    plot(p)
    interval = mean(x) + c(-1,1)*2*se
    print( interval )
  return( list(boot.statistics = boot.statistics, interval=interval, se=se, plot=p) )
}
boot.mean(CommuteAtlanta$Time, B=1000)

# There is a package boot with a function boot() that does the bootstrap for many situations.
library(boot)
my.mean = function(x, indices){
  return (mean( x[indices]) )
}
time.boot = boot(CommuteAtlanta$Time, my.mean, 10000)
head(time.boot)
str(time.boot)
# confidence interval from the boot package
# pPercentile uses percentile, Basic uses the estimated standard eror, BCa also uses percentiles,
# but adjusted to account for bias and skewness

boot.ci(time.boot)

