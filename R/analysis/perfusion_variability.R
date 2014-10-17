

rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F


##############################################
# Read datasets
##############################################
f_liver_density = 1.08  # [g/ml] conversion between volume and weight

# sex, age, liverVolume
she1977 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Sheriff1977.csv"), sep="\t")
she1977$gender <- as.character(she1977$sex)
she1977$gender[she1977$gender=='U'] <- 'all'
she1977$perfusion <- she1977$perfusion/100/f_liver_density # ml/min/g

head(she1977)
hist(she1977$perfusion)

# Calculate mean by patient
library(plyr)
df <- ddply(she1977, .(patient), function(x) data.frame(perfusion_mean=mean(x$perfusion)))
she1977 <- join(she1977, df, by=c("patient"))
head(she1977)
she1977$perfusion_dif <- (she1977$perfusion_mean - she1977$perfusion)
she1977$perfusion_reldif <- (she1977$perfusion- she1977$perfusion_mean)/she1977$perfusion_mean

# Plot the distribution of regional difference in blood flow
hist(she1977$perfusion_reldif, breaks=20, freq=FALSE, xlim=c(-0.6, 0.6),
     main="Local heterogeneity of liver perfusion", xlab="(<p> - p)/<p>")
lines(density(she1977$perfusion_reldif), col='red', lwd=3)

# fit a normal distribtion
library(MASS)
mle = fitdistr(she1977$perfusion_reldif, "normal")
mle
mean = mle$estimate["mean"]
sd = mle$estimate["sd"]
print(mean); print(sd);
x.grid <- seq(from=-1.0, to=1.0,length.out = 101)
y <- dnorm(x=x.grid, mean=mle$estimate["mean"], sd=mle$estimate["sd"])
lines(x.grid, y, col='Orange', lwd=3)
abline(v=mean, col='grey', lwd=3)
abline(v=mean+sd, col='grey', lwd=2)
abline(v=mean-sd, col='grey', lwd=2)

# Let's come to the tricky step that establishes how good the observed data match the theoretical model with the estimated parameters. You may use the Shapiro-Wilk test to fit normal distributions. If the p-value is lower than a threshold (usually fixed to 0.05), than the normality hypothesis is rejected: 
shapiro.test(rnorm(100, mean = 5, sd = 3))
shapiro.test(runif(100, min=2, max=4))

test <- rnorm(n = 50, mean=mle$estimate["mean"], sd=mle$estimate["sd"])
hist(test, breaks = 10)


# To fit an arbitrary distribution, use the Kolmogorov-Smirnov test. The KS test compares an empirical and a theoretical model by computing the maximum absolute difference between the empirical and theoretical distribution functions: 


## Plot the results
for(i in 1:n)
    plot(f[[i]])

head(marG2)