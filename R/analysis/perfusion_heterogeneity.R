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
f_liver_density = 1.25  # [g/ml] conversion between volume and weight

# Sheriff1977  --------------------------
# sex, age, liverVolume
she1977 <- read.csv(file.path(ma.settings$dir.expdata, "liver_bloodflow", "Sheriff1977.csv"), sep="\t")
she1977$gender <- as.character(she1977$sex)
she1977$gender[she1977$gender=='U'] <- 'all'
she1977$perfusion <- she1977$perfusion/100 * f_liver_density # ml/min/g
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

 
# Wang2013 --------------------------
wan2013 <- read.csv(file.path(ma.settings$dir.expdata, "raw_data", "wang", "Wang2013.csv"), sep="\t")
wan2013$perfusion <- wan2013$thp/100 # [ml/min/100ml] -> [ml/min/ml (tissue)]

wan2013.col <- rgb(1,0,0,0.5)
she1977.col <- rgb(0.4,0.4,0.4,0.5)

hist(she1977$perfusion, freq=FALSE, col=wan2013.col,
     main="Histogramm of local perfusion (CT & Xe)",
     xlab="Perfusion [ml/min/ml (tissue)]",
     xlim=c(0, 2.4), ylim=c(0,2.0))
hist(wan2013$perfusion, freq=FALSE, col=she1977.col,
     add=TRUE)
legend("topright", bty="n", cex=1.0,
       legend=c("Sheriff1977 Xenon (Np=14, N=246)", "Wang2013 Perfusion-CT (Np=50, N=400)"),
       col=c(she1977.col, wan2013.col), pch=15)




# Plot the distribution of regional difference in blood flow
hist(she1977$perfusion_reldif, breaks=20, freq=FALSE, xlim=c(-0.7, 0.7),
     main="Local heterogeneity of liver perfusion", xlab="(<p> - p)/<p> [ml/min/ml (tissue)")
lines(density(she1977$perfusion_reldif), col='red', lwd=3)


# CT data Wang2013 --------------------------
wan2013 <- read.csv(file.path(ma.settings$dir.expdata, "raw_data", "wang", "Wang2013.csv"), sep="\t")
CT_perfusion_Legend.png

# source("http://bioconductor.org/biocLite.R")
# biocLite()
# sudo apt-get install libfftw3-dev libtiff4-dev

biocLite("EBImage")
library("EBImage")
# Reading image
img.legend <- readImage(file.path(ma.settings$dir.expdata, "raw_data", "wang", "CT_perfusion_Legend.jpeg"))
img.ALP1 <- readImage(file.path(ma.settings$dir.expdata, "raw_data", "wang", "CT_perfusion_ALP1.jpeg"))
img.PVP1 <- readImage(file.path(ma.settings$dir.expdata, "raw_data", "wang", "CT_perfusion_PVP1.jpeg"))

# Display
display(img.legend)
print(img.legend)
# colormode 	Color 	The type (Color/Grayscale) of the color of the image.
# storage.mode 	double 	Type of values in the array.
# dim 	1984 1488 3 	Dimension of the array, (x, y, z).
# nb.total.frames: 	3 	Number of channels in each pixel, z entry in dim.
# nb.render.frames 	1 	Number of channels rendered.

print(img.ALP1)
print(img.PVP1)

# legend colors
# TODO mean over the width of the data
legend_colors <- imageData(img.legend)[4, ,]

value_from_color <- function(color, min.value=0, max.value=40, legend_colors=legend_colors){
    # find the closest color in the color data
  col_dist <- (color[1]-legend_colors[, 1])^2 + (color[2]-legend_colors[, 2])^2 + (color[3]-legend_colors[, 3])^2 
  # plot(col_dist)
  
  # get the color from the minimum distance
  value <- min.value + (which.min(col_dist)-1)/(Ncolors-1) * (max.value-min.value)
  
  # TODO: handle black & white
  
  return(value)
}

# calculate value for single pixel 
value_from_color(color=imageData(img.ALP1)[0,0,], min.value=0, max.value=40, legend_colors=legend_colors)

# Get values for all ALP pixels
start.time <- Sys.time()
imgData.ALP1 <- imageData(img.ALP1)
imgData.ALP1[100,100,]
values.ALP1 <- matrix(data=NA, nrow=dim(img.ALP1)[1], ncol=dim(img.ALP1)[2]) 
for (kr in 1:nrow(values.ALP1)){
  for (kc in 1:ncol(values.ALP1)){
    values.ALP1[kr, kc] <- value_from_color(color=imgData.ALP1[kr,kc,], min.value=0, max.value=40, 
                                            legend_colors=legend_colors)
  }
}
Sys.time() - start.time

# Get values for all PVP pixels
imgData.PVP1 <- imageData(img.PVP1)
values.PVP1 <- matrix(data=NA, nrow=dim(img.PVP1)[1], ncol=dim(img.PVP1)[2]) 
for (kr in 1:nrow(values.PVP1)){
  for (kc in 1:ncol(values.PVP1)){
    values.PVP1[kr, kc] <- value_from_color(color=imgData.PVP1[kr,kc,], min.value=0, max.value=100,
                                            legend_colors=legend_colors)
  }
}

display(values.ALP1/40)
display(values.PVP1/100)

values.THP1 <- values.ALP1 + values.PVP1
display(values.THP1/140)
hist(values.THP1)
tmp <- values.THP1
tmp[tmp>=139.9] <- NA
display(tmp/140)



hist(values.ALP1)

hist(values.ALP1)
heatmap(values.ALP1, Rowv=NA, Colv=NA, col=heat.colors(400, alpha = 1))
display(values.ALP1/40)








# ------------------------

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

