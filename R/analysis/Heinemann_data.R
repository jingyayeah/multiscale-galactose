################################################################################
# Heinemann1999
################################################################################
# Basic analyis of the data
# 
# author: Matthias Koenig
# date: 15-10-2014
################################################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd("/home/mkoenig/multiscale-galactose/experimental_data")
hei1999 <- read.csv(file.path(ma.settings$dir.expdata, "heinemann", "Heinemann1999.csv"), sep="\t")
head(hei1999)

f_liver_density = 1.08  # [g/ml] conversion between volume and weight
hei1999$gender <- as.character(hei1999$sex)
hei1999$gender[hei1999$gender=='M'] <- 'male'
hei1999$gender[hei1999$gender=='F'] <- 'female'
hei1999$volLiver <- hei1999$liverWeight/f_liver_density  # [ml]
hei1999$volLiverkg <- hei1999$volLiver/hei1999$bodyweight # [ml/kg]
hei1999$BSA <- hei1999$BSA_DuBois # use the DuBois calculation
head(hei1999)

##########################
# Outliers
##########################
# outliers found by graphical analysis
outliers.1 <- which((hei1999$liverWeight<500) & (hei1999$age>5))
outliers.2 <- which((hei1999$liverWeight>1500) & (hei1999$liverWeight<2000) & (hei1999$age<10))
outliers.3 <- which((hei1999$BSA_DuBois<0.5) & (hei1999$liverWeight/hei1999$bodyweight<20))
outliers <- c(outliers.1, outliers.2, outliers.3)

##########################
# Plot helpers
##########################
colors <- rep('gray', nrow(hei1999))
split(colors, hei1999$sex)<- c(rgb(1,0,0, alpha=0.5), rgb(0,0,1, alpha=0.5))
symbols <- rep(1, nrow(hei1999))
split(symbols, hei1999$sex)<- c(19, 25)

create_plots = F
startDevPlot <- function(name, width=1500, height=1000, file=NULL){
    if (is.null(file)){
        file <- sprintf('%s.png', name)
    }
    if (create_plots == T) { 
        print(file)
        png(filename=file, width=width, height=height, 
            units = "px", bg = "white",  res = 150)
    }
}
stopDevPlot <- function(){
    if (create_plots == T) { dev.off() }
}

startDevPlot(name='heinemann/Heinemann1999_Fig1', height=1000, width=1500)
par(mfrow=c(2,3))
plot(liverWeight~age, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Age [years]', ylab='Liver weight [g]',
     xlim=c(0,100), ylim=c(0,4000) )
points(liverWeight~age, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~height, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Height [cm]', ylab='Liver weight [g]',
     xlim=c(0,220), ylim=c(0,4000) )
points(liverWeight~height, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~bodyweight, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Body weight [kg]', ylab='Liver weight [g]',
     xlim=c(0,130), ylim=c(0,4000) )
points(liverWeight~bodyweight, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~BSA_DuBois, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Body surface area [m^2]', ylab='Liver weight [g]',
     xlim=c(0,3), ylim=c(0,4000) )
points(liverWeight~BSA_DuBois, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()

plot(liverWeight~BMI, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='BMI (Body mass index) [kg/m^2]', ylab='Liver weight [g]',
     xlim=c(0,40), ylim=c(0,4000) )
points(liverWeight~BMI, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
abline(v=30, col='grey', lwd=1.0)
abline(v=25, col='grey', lwd=1.0)
abline(v=18.5, col='grey', lwd=1.0)
grid()

plot(liverWeight/bodyweight~BSA_DuBois, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='Body surface area [m^2]', ylab='Liver weight per body weight [g/kg]',
     xlim=c(0,3), ylim=c(0,100) )
points(liverWeight/bodyweight~BSA_DuBois, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
grid()
par(mfrow=c(1,1))
stopDevPlot()


# Figure 2
startDevPlot(name='heinemann/Heinemann1999_Fig2', height=1000, width=1000)
par(mfrow=c(2,2))
plot(BMI~age, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='age [years]', ylab='BMI (Body mass index) [kg/m^2]', 
     xlim=c(0,100), ylim=c(0,40) )
points(BMI~age, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)
abline(h=30, col='grey', lwd=1.0)
abline(h=25, col='grey', lwd=1.0)
abline(h=18.5, col='grey', lwd=1.0)

plot(liverWeight/bodyweight~age, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='age [years]', ylab='Liver weight per body weight [g/kg]', 
     xlim=c(0,100), ylim=c(0,80) )
points(liverWeight/bodyweight~age, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)

plot(liverWeight/bodyweight~bodyweight, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='bodyweight [kg]', ylab='Liver weight per body weight [g/kg]', 
     xlim=c(0,100), ylim=c(0,80) )
points(liverWeight/bodyweight~bodyweight, data=hei1999[outliers, ], col='black', pch=1, cex=1.5)

par(mfrow=c(1,1))
stopDevPlot()

#################################################
# Modeling
#################################################
# remove the outliers
hei1999 <- hei1999[-outliers, ]
summary(hei1999)
plot(liverWeight/bodyweight~age, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='age [years]', ylab='Liver weight per body weight [g/kg]', 
     xlim=c(0,100), ylim=c(0,80) )

plot(liverWeight/BSA~age, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='age [years]', ylab='Liver weight per BSA [g/m^2]', 
     xlim=c(0,100), ylim=c(0,3000) )

par(mfrow=c(2,2))
plot(volLiver~BSA, data=hei1999, col=colors, pch=symbols, cex=0.8,
     xlab='BSA [m^2]', ylab='Liver volume [ml]', 
     xlim=c(1.5, 2.5), ylim=c(1000,3000) )

plot(volLiver~BSA, data=hei1999[abs(hei1999$age-20)<5, ], col=colors, pch=symbols, cex=2.0,
     xlab='BSA [m^2]', ylab='Liver volume [ml]', 
     xlim=c(0.5, 2.5), ylim=c(0,3000) )

hist(hei1999[abs(hei1999$age-40)<5, ]$volLiver, breaks=20)
hist(hei1999[abs(hei1999$age-40)<5 & (hei1999$BSA<2.1) & (hei1999$BSA>1.9), ]$volLiver, breaks=20)
table(abs(hei1999$age-40)<5)
table(abs(hei1999$age-40)<5 & (hei1999$BSA<2.1) & (hei1999$BSA>1.9))
mean( hei1999$volLiver[abs(hei1999$age-40)<5] )
mean( hei1999$volLiver[abs(hei1999$age-40)<5 & (hei1999$BSA<2.1) & (hei1999$BSA>1.9)] )

mean( hei1999$volLiver[abs(hei1999$age-40)<5 & hei1999$gender=="male"] )
mean( hei1999$volLiver[abs(hei1999$age-40)<5 & (hei1999$BSA<2.1) & (hei1999$BSA>1.9)& hei1999$gender=="male"] )

mean( hei1999$volLiver[abs(hei1999$age-40)<5 & hei1999$gender=="female"] )
mean( hei1999$volLiver[abs(hei1999$age-40)<5 & (hei1999$BSA<2.1) & (hei1999$BSA>1.9)& hei1999$gender=="female"] )


mean( hei1999$volLiver[abs(hei1999$age-40)<5] )
mean( hei1999$volLiver[abs(hei1999$age-40)<5 & (hei1999$BSA<2.1) & (hei1999$BSA>1.9)] )

table(abs(hei1999$age-40)<5 & (hei1999$BSA<2.1) & (hei1999$BSA>1.9))



par(mfrow=c(1,1))


hei1999$volLiverBSA <- hei1999$volLiver/hei1999$BSA

# simple scannerplot
install.packages("scatterplot3d")
library(scatterplot3d)
scatterplot3d(hei1999[c('age', 'BSA', 'volLiver')], 
              pch=16, highlight.3d=TRUE)


install.packages("rgl")
require("rgl")
require("RColorBrewer")
plot3d(hei1999$age, hei1999$BSA, hei1999$volLiver, 
       col=colors, pch=symbols, size=8, xlim=c(0,100),ylim=c(1.5, 2.5)) 
decorate3d()

source(file.path(ma.settings$dir.code, 'analysis', 'data_information.R'))
dataset <- 'volLiver_age'
dataset <- 'volLiverBSA_age'

# Plot helpers
name.parts <- strsplit(dataset, '_')
xname <- name.parts[[1]][2]
yname <- name.parts[[1]][1]
rm(name.parts)
xlab <- lab[[xname]]; ylab <- lab[[yname]]
xlim <- lim[[xname]]; ylim <- lim[[yname]]
main <- sprintf('%s vs. %s', yname, xname)


library(gamlss)
# sigma.formula= ~cs(age,1)
hei1999.male <- hei1999[hei1999$gender == 'male',]
fit.all.bccg <- gamlss(volLiver ~ cs(age,1), family=BCCG, data=hei1999)
fit.male.bccg <- gamlss(volLiver ~ cs(age,1), family=BCCG, data=hei1999.male)

fit.male.bccg1 <- gamlss(volLiver ~ cs(age,1), family=BCCG, data=hei1999.male)
fit.male.bccg2 <- gamlss(volLiver ~ cs(age,1) + BSA, family=BCCG, data=hei1999.male)
# fit.all.no <- gamlss(GEC ~ cs(age,3), family=NO, data=df.all)
# fit.all.no <- gamlss(GEC ~ cs(age,2), sigma.formula= ~cs(age,2), family=NO, data=df.all)
fit.male.no <- gamlss(volLiverBSA ~ cs(age,0), family=NO, data=hei1999.male)
fit.male.bccg3 <- gamlss(volLiverBSA ~ cs(age,1), family=BCCG, data=hei1999.male)

centiles(fit.male.bccg2, xvar = hei1999.male$age)
centiles(fit.male.bccg2, xvar = hei1999.male$BSA)

fit.male.bccg3
plotCentiles(model=fit.male.no, d=hei1999.male, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=rgb(0,0,0, 0.5))


plotCentiles(model=fit.all.no, d=hei1999, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=rgb(0,0,0, 0.5))
plotCentiles(model=fit.male.bccg, d=hei1999.male, xname=xname, yname=yname,
             main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, 
             pcol=rgb(0,0,1, 0.5))
plot(fit.male.bccg)


library(ggplot2)

g <- ggplot(hei1999, aes(age, BSA))
p <- g + geom_point(size=hei1999$BSA*3, alpha=0.5)
p

# adding the facets
g + geom_point(color="steelblue", size=4, alpha=1/2)


