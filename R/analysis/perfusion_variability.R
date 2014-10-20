################################################################################
# Local heterogeinity in perfusion in the liver
################################################################################
# Depending on the local are the perfusion in the liver is quit 
# heteogeneous. This heterogeneity has to be taken into account
# when scaling to the whole liver volume.
#
# Sheriff1977
# Kanda2011
# 
# 
# author: Matthias Koenig
# date: 15-10-2014
################################################################################
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

# fit a normal distribtion for local heterogeinity in blood flow
library(MASS)
mle = fitdistr(she1977$perfusion_reldif, "normal")
mean.fit = mle$estimate["mean"]
sd.fit = mle$estimate["sd"]

print(mean); print(sd);
x.grid <- seq(from=-1.0, to=1.0,length.out = 101)
y <- dnorm(x=x.grid, mean=mle$estimate["mean"], sd=mle$estimate["sd"])
lines(x.grid, y, col='Orange', lwd=3)
abline(v=mean.fit, col='grey', lwd=3)
abline(v=mean.fit+sd.fit, col='grey', lwd=2)
abline(v=mean.fit-sd.fit, col='grey', lwd=2)

# The variance is the relative error from the mean
print('Fit values')
print(mle)


# create some examples
flowLiver = 1500 # ml/min
volLiver = 1800 # ml
perfusion = flowLiver/volLiver
perfusion

# GEC per volume liver tissue for given perfusion
# function coming from the underlying detailed kinetic model
GEC_per_vol <- function(perfusion){
 GEC = log((perfusion*10 + 1)) # mmol/min/ml(liver)
 return(GEC)
}

# Calculate the GEC over the heterogeneous liver

p.grid <- seq(from=0.4, to=1.5, by=0.1)
plot(p.grid, GEC_per_vol(perfusion=p.grid), xlim=c(0,1.6)

# This is the GEC data result from bootstrapping,
# which has to be fitted 
gec_data <- data.frame(perfusion=p.grid, GEC=GEC_per_vol(perfusion=p.grid))
head(gec_data)

n <- 40
for (perfusion in p.grid){
    perfusion.pattern <- rnorm(n=n, mean=perfusion, sd=perfusion*mle$estimate["sd"])
    GEC = GEC_per_vol(perfusion=perfusion.pattern)
    points(rep(perfusion,n), GEC, pch=21, col=rgb(1,0,0, alpha=0.4), bg=rgb(1,0,0, alpha=0.4))
    points(perfusion, mean(GEC), pch=22, col='blue', bg='blue')
    df <- data.frame(perfusion=rep(perfusion, n),
                     GEC=GEC)
    rbind(gec_data, df)
}
lines(p.grid, GEC_per_vol(perfusion=p.grid), lwd=3, col='Blue')





plot(pattern, pch=22, col=pattern, bg=pattern)
hist(pattern)







# Let's come to the tricky step that establishes how good the observed data match the theoretical model with the estimated parameters. You may use the Shapiro-Wilk test to fit normal distributions. If the p-value is lower than a threshold (usually fixed to 0.05), than the normality hypothesis is rejected: 
shapiro.test(rnorm(100, mean = 5, sd = 3))
shapiro.test(runif(100, min=2, max=4))

# To fit an arbitrary distribution, use the Kolmogorov-Smirnov test. The KS test compares an empirical and a theoretical model by computing the maximum absolute difference between the empirical and theoretical distribution functions: 
