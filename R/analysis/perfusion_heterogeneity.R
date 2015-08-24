################################################################################
# Local heterogeneity in liver perfusion
################################################################################
# The local perfusion in the liver shows large heterogeneity. Based on the
# response curves depending on perfusion the local heterogeneity in metabolic
# response can be calculated.
# 
# Example data sets are:
#   {Sheriff1977} - single measurements
#   {Wang2013} - single measurements
#   {Kanda2011, Wang201?} - CT measurements
# 
# author: Matthias Koenig
# date: 24-08-2015
################################################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

##############################################
# Read datasets
##############################################
f_liver_density = 1.08  # [g/ml] conversion between volume and weight

# Sheriff1977
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

# Plot the data for the the individual subjects
par(mfrow=c(2,1))
plot(she1977$patient, she1977$perfusion,
     main="Sheriff1977: Perfusion Heterogeneity",
     xlab="Patient", ylab="Perfusion [ml/min/ml (tissue)]",
     ylim=c(0,1.5))
# require(ggplot2)
# qplot(she1977$patient, she1977$perfusion, 
#      main="Sheriff1977: Perfusion Heterogeneity",
#      xlab="Patient", ylab="Perfusion [ml/min/ml (tissue)]")

stripchart(she1977$perfusion~she1977$patient, data.frame(she1977$perfusion,she1977$patient),
           # main="Sheriff1977: Perfusion Heterogeneity",
           xlab="Patient", ylab="Perfusion [ml/min/ml (tissue)]",
           ylim=c(0,1.5),
           pch=16,vertical=T, cex=0.8)
par(mfrow=c(1,1))


# Sheriff1977







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
# Function which provides the local metabolic function depending on the perfusion in the region.
# The function is fitted based on the underlying kinetic metabolic network.
GEC_per_vol <- function(perfusion){
 GEC = log((perfusion*10 + 1)) # mmol/min/ml(liver)
 return(GEC)
}

# Calculate the GEC over the heterogeneous liver
p.grid <- seq(from=0.4, to=1.5, by=0.1)
plot(p.grid, GEC_per_vol(perfusion=p.grid))

# This is the GEC data result from bootstrapping, which is fitted afterwards
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

