rm(list=ls())
library('MultiscaleAnalysis')
setwd(file.path(ma.settings$dir.exp, 'GEC'))
d <- read.csv("Keiding1988.csv", sep="\t")
head(d)
plot(d$ca, d$cv, xlim=c(0,120), ylim=c(0,120))


# Merkel ROC curve data
d <- read.csv("Merkel1991.csv", sep="\t")
head(d)
summary(d)
with(d, {
  plot(fpr, tpr, type='n')
    subset <- (d$predictor == 'GEC')
    points(fpr[subset], tpr[subset], pch=15, col='black')
    lines(fpr[subset], tpr[subset], col='black')
    subset <- (d$predictor == 'Pugh')
    points(fpr[subset], tpr[subset], pch=3, col='black')
    lines(fpr[subset], tpr[subset], col='black', lty=2)
})

d <- read.csv("Waldstein1960_Tab1.csv", sep="\t")
head(d)
attach(d)
fname <- file.path(ma.settings$dir.base, 'results', 'Waldstein1960.png')
cat(fname, '\n')
png(filename=fname, width=1600, height=800, res=150,
    units = "px", bg = "white")
par(mfrow=c(1,2))
plot(gal, R, xlab='Galactose Peq [mM]', ylab='Removal [mmole/min]', 
     pch=21, col='black', bg='gray', font.lab=2,
     ylim=c(0,3.0), xlim=c(0,8))
plot(gal, CLH, xlab='Galactose Peq [mM]', ylab='Hepatic Clearance [ml/min]', 
     pch=21, col='black', bg='gray', font.lab=2,
     ylim=c(0,3000))
par(mfrow=c(1,2))
dev.off()

d <- read.csv("Waldstein1960_Fig6.csv", sep="\t")