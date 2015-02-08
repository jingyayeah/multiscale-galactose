rm(list=ls())
library('MultiscaleAnalysis')
setwd(file.path(ma.settings$dir.exp, 'GEC'))

#############################################################################
# Keiding1988
#############################################################################
kei1988 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Keiding1988.csv"), sep="\t")
head(kei1988)

plot(ca, cv, xlim=c(0,120), ylim=c(0,120))

# Hepatic clearance ~ perfusion
vol_liv = 1500   # [ml]
plot(kei1988$bloodFlow, kei1988$HCL, 
     xlab="Liver bloodflow [ml/min]", 
     ylab="Hepatic Clearance [ml/min]",
     xlim=c(0,1800),
     ylim=c(0, 1800))

plot(kei1988$bloodFlow/vol_liv, kei1988$HCL, 
     xlab="Liver bloodflow [ml/min]", 
     ylab="Hepatic Clearance [ml/min]",
     xlim=c(0,1.2),
     ylim=c(0, 1800))
for (k in 1:nrow(kei1988)){
  # horizontal
  lines(kei1988$bloodFlow[k]/vol_liv+c(-1,1)*kei1988$bloodFlowSE[k]/vol_liv, rep(kei1988$HCL[k],2) )
  # vertical
  lines(rep(kei1988$bloodFlow[k]/vol_liv, 2), kei1988$HCL[k] + c(-1,2)*kei1988$HCLSE[k])
}

# Artial and venous concentration 
plot(kei1988$bloodFlow/vol_liv, kei1988$ca-kei1988$cv, 
     xlab="Liver bloodflow [ml/min]", 
     ylab="ca-cv [µmol/L]",
     xlim=c(0,1.2),
     ylim=c(0, 120))

# Hepatic extraction fraction
plot(kei1988$bloodFlow/vol_liv, kei1988$ER, 
     main="Hepatic extraction ratio"
     xlab="Liver bloodflow [ml/min]", 
     ylab="ER [-]",
     xlim=c(0,1.2),
     ylim=c(0, 1.1))

# Hepatic elimination
plot(kei1988$ca/1000, kei1988$HE/1000, 
     main="Hepatic elimination",
     xlab="Galactose ca [mmol/L]", 
     ylab="Hepatic elimination [mmol/min]",
     xlim=c(0,0.2),
     ylim=c(0,0.2))
for (k in 1:nrow(kei1988)){
  # horizontal
  lines(kei1988$ca[k]/1000+c(-1,1)*kei1988$caSE[k]/1000, rep(kei1988$HE[k]/1000,2) )
  # vertical
  lines(rep(kei1988$ca[k]/1000, 2), kei1988$HE[k]/1000 + c(-1,2)*kei1988$HESE[k]/1000)
}

# Systemic clearance ~ Hepatic clearance
# Correction necessary for low galactose concentration
plot(kei1988$HCL, kei1988$SCL, 
     xlab="Systemic Clearance [ml/min]", 
     ylab="Hepatic Clearance [ml/min]",
     xlim=c(0,2000),
     ylim=c(0, 2000))
abline(a = 0, b=1)

plot(kei1988$ca, kei1988$SCL-kei1988$HCL,
     xlim=c(0,150),
     ylim=c(0,1000))

########################################################################
# Tygstrup1958
########################################################################
tyg1958 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Tygstrup1958.csv"), sep="\t")
head(tyg1958)
summary(tyg1958)
# reduce to healthy
tyg1958 <- tyg1958[tyg1958$status=='healthy',]
summary(tyg1958)

# Galactose elimination
par(mfrow=c(1,2))
plot(tyg1958$bloodflowBS, tyg1958$GE,
     xlab="Blood flow [ml/min]",
     ylab="Galactose elimination [mmol/min]",
     xlim=c(0, 3200), 
     ylim=c(0, 3))

plot(tyg1958$ca, tyg1958$GE,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose elimination [mmol/min]",
     # xlim=c(0, 3),
     xlim=c(0, 5), 
     ylim=c(0, 3))
par(mfrow=c(1,1))




# Galactose extracton ratio
par(mfrow=c(1,2))
plot(tyg1958$bloodflowBS, tyg1958$ER,
     xlab="Blood flow [ml/min]",
     ylab="Galactose extraction ratio [-]",
     # xlim=c(0, 3),
     ylim=c(0, 1),
     xlim=c(0, 3200))

plot(tyg1958$ca, tyg1958$ER,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose extraction ratio [-]",
     # xlim=c(0, 3),
     ylim=c(0, 1),
     xlim=c(0, 5))
par(mfrow=c(1,1))


# Clearance
par(mfrow=c(1,2))
plot(tyg1958$ca, tyg1958$CL,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose clearance [ml/min]",
     xlim=c(0, 3),
     ylim=c(0, 2600))

plot(tyg1958$bloodflowBS, tyg1958$CL,
     xlab="Blood flow [ml/min]",
     ylab="Galactose clearance [ml/min]",
     # xlim=c(0, 3),
     xlim=c(0, 3200),
     ylim=c(0, 2600))
par(mfrow=c(1,1))

# cv ~ ca (cv = ca*(1-ER) )
plot(tyg1958$ca, tyg1958$cv,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose venous [mmol/L]",
     # xlim=c(0, 3),
     ylim=c(0, 3),
     xlim=c(0, 3))


# Galactose elimination
# Q * (ca - cv)

plot(tyg1958$bloodflowBS, tyg1958$ER/100)

# TODO: ca - co calculation 


########################################################################
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

wal1960 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Waldstein1960_Tab1.csv"), sep="\t")
head(wal1960)
fname <- file.path(ma.settings$dir.base, 'results', 'Waldstein1960.png')
cat(fname, '\n')
# png(filename=fname, width=1600, height=800, res=150,
#     units = "px", bg = "white")
par(mfrow=c(1,2))
plot(wal1960$gal, wal1960$R, xlab='Galactose Peq [mM]', ylab='Removal [mmole/min]', 
     pch=21, col='black', bg='gray', font.lab=2,
     ylim=c(0,3.0), xlim=c(0,8))
plot(wal1960$gal, wal1960$CLH, xlab='Galactose Peq [mM]', ylab='Hepatic Clearance [ml/min]', 
     pch=21, col='black', bg='gray', font.lab=2,
     ylim=c(0,3000))
par(mfrow=c(1,2))
dev.off()

# dev.off()

d <- read.csv("Waldstein1960_Fig6.csv", sep="\t")