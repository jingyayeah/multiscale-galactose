rm(list=ls())
library('MultiscaleAnalysis')
setwd(file.path(ma.settings$dir.exp, 'GEC'))

########################################################################
# Urin galactose clearance
########################################################################
# Estimated as ~ 10% in Tystrup
wal1960 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Waldstein1960_Tab1.csv"), sep="\t")
head(wal1960)

plot(numeric(0), numeric(0), type='n',
     xlab="Galactose arteriell [mmol/L]",
     ylab="Urin galactose elimination [mmol/min]",
     xlim=c(0, 10), 
     ylim=c(0, 3),
     font.lab = 2)
points(wal1960$gal, wal1960$U, pch=21, col='black', bg='gray')
points(wal1960$gal, wal1960$R, pch=21, col='black', bg='red')

########################################################################
# Combined data (GE, ER, CL)
########################################################################
# TODO: unify colors & symbols for datasets
# TODO: add legend for data
# TODO: bold plot & create figure
# TODO: add error bars were available

# Read data
kei1988 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Keiding1988.csv"), sep="\t")
head(kei1988)

tyg1958 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Tygstrup1958.csv"), sep="\t")
tyg1958 <- tyg1958[tyg1958$status=='healthy',]
head(tyg1958)

tyg1954 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Tygstrup1954.csv"), sep="\t")
head(tyg1954)

wal1960 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Waldstein1960_Tab1.csv"), sep="\t")
head(wal1960)

hen1982 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Henderson1982_Tab4.csv"), sep="\t")
hen1982 <- hen1982[hen1982$status == 'healthy', ]
head(hen1982)

win1965 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Winkler1965.csv"), sep="\t")
head(win1965)

# TODO: proper correction for all R & CL values,
# if not based on ca-cv differences


# [1] Galactose elimination / removal
# -----------------------------------------------------
# Q * (ca - cv)
par(mfrow=c(1,2))
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Blood flow [ml/min]",
     ylab="Galactose elimination [mmol/min]",
     xlim=c(0, 3200), 
     ylim=c(0, 3))
points(tyg1958$bloodflowBS, tyg1958$GE) 
points(kei1988$bloodFlow, kei1988$HE, pch=21, col='black', bg=rgb(0,0,1.0, 0.5)) 
points(win1965$flowLiver, win1965$GE, pch=22, bg='red') 

plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose elimination [mmol/min]",
     xlim=c(0, 10), 
     ylim=c(0, 3))
points(tyg1958$ca, tyg1958$GE)
points(wal1960$gal, wal1960$R, pch=21, col='black', bg='gray')
points(kei1988$ca, kei1988$HE, pch=21, col='black', bg=rgb(0,0,1.0, 0.5)) 
points(win1965$ca, win1965$GE, pch=22, bg='red')
par(mfrow=c(1,1))

# [2] Galactose extraction ratio ER
# -----------------------------------------------------
par(mfrow=c(1,2))
plot(numeric(0), numeric(0), type='n', font.lab=2, 
     xlab="Blood flow [ml/min]",
     ylab="Galactose extraction ratio [-]",
     ylim=c(0, 1),
     xlim=c(0, 3200))
points(tyg1958$bloodflowBS, tyg1958$ER)
points(kei1988$bloodFlow, kei1988$ER, pch=21, col='black', bg=rgb(0,0,1.0, 0.5)) 
points(win1965$flowLiver, win1965$ER, pch=22, bg='red')

plot(numeric(0), numeric(0), type='n', font.lab=2, 
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose extraction ratio [-]",
     ylim=c(0, 1),
     xlim=c(0, 5))
points(tyg1958$ca, tyg1958$ER)
points(kei1988$ca, kei1988$ER, pch=21, col='black', bg=rgb(0,0,1, 0.5)) 
points(hen1982$css, hen1982$ER, pch=21, col='black', bg=rgb(1,0,0, 0.5)) 
points(win1965$ca, win1965$ER, pch=22, bg='red')
par(mfrow=c(1,1))

# [3] Clearance
# -----------------------------------------------------
par(mfrow=c(1,2))
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose clearance [ml/min]",
     xlim=c(0, 10),
     ylim=c(0, 3200))
points(tyg1958$ca, tyg1958$CL)
points(kei1988$ca, kei1988$HCL, pch=21, col='black', bg=rgb(0,0,1.0, 0.5)) 
# points(kei1988$ca, kei1988$SCL, pch=22, col='black', bg=rgb(0,0,1.0, 0.5)) 
points(hen1982$css, hen1982$CL, pch=21, col='black', bg=rgb(1,0,0, 0.5)) 
points(win1965$ca, win1965$CL, pch=22, bg='red')

# points(wal1960$gal, wal1960$CLH, pch=21, col='black', bg='gray')
CL_new <- (wal1960$R - 0.2*wal1960$gal/(wal1960$gal+0.1))/wal1960$gal *1000 
points(wal1960$gal, CL_new, pch=21, col='black', bg='darkgreen')



plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Blood flow [ml/min]",
     ylab="Galactose clearance [ml/min]",
     xlim=c(0, 3200),
     ylim=c(0, 2600))
points(tyg1958$bloodflowBS, tyg1958$CL)
points(kei1988$bloodFlow, kei1988$HCL, pch=21, col='black', bg=rgb(0,0,1.0, 0.5)) 
points(win1965$flowLiver, win1965$CL, pch=22, bg='red')
par(mfrow=c(1,1))

# cv ~ ca (cv = ca*(1-ER) )
# -----------------------------------------------------
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose venous [mmol/L]",
     xlim=c(0, 8),
     ylim=c(0, 7))
points(tyg1958$ca, tyg1958$cv)
points(tyg1954$ca, tyg1954$cv, pch=21, bg='darkgreen')
points(kei1988$ca, kei1988$cv, pch=21, col='black', bg=rgb(0,0,1, 0.5)) 
points(hen1982$css, hen1982$chv, pch=21, col='black', bg=rgb(1,0,0, 0.5)) 
points(win1965$ca, win1965$cv, pch=22, bg='red')



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


#############################################################################
# Keiding1988
#############################################################################
kei1988 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Keiding1988.csv"), sep="\t")
head(kei1988)

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
     ylab="ca-cv [mmol/L]",
     xlim=c(0,1.2),
     ylim=c(0, 0.2))

# Hepatic extraction fraction
plot(kei1988$bloodFlow/vol_liv, kei1988$ER, 
     main="Hepatic extraction ratio",
     xlab="Liver bloodflow [ml/min]", 
     ylab="ER [-]",
     xlim=c(0,1.2),
     ylim=c(0, 1.1))

# Hepatic elimination
plot(kei1988$ca, kei1988$HE, 
     main="Hepatic elimination",
     xlab="Galactose ca [mmol/L]", 
     ylab="Hepatic elimination [mmol/min]",
     xlim=c(0,0.2),
     ylim=c(0,0.2))
for (k in 1:nrow(kei1988)){
  # horizontal
  lines(kei1988$ca[k]+c(-1,1)*kei1988$caSE[k], rep(kei1988$HE[k],2) )
  # vertical
  lines(rep(kei1988$ca[k], 2), kei1988$HE[k] + c(-1,2)*kei1988$HESE[k])
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
     xlim=c(0,0.150),
     ylim=c(0,1000))

########################################################################
wal1960 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Waldstein1960_Tab1.csv"), sep="\t")

# fname <- file.path(ma.settings$dir.base, 'results', 'Waldstein1960.png')
# png(filename=fname, width=1600, height=800, res=150,
#     units = "px", bg = "white")
par(mfrow=c(1,2))
plot(wal1960$gal, wal1960$R, xlab='Galactose Peq [mM]', ylab='Removal [mmole/min]', 
     pch=21, col='black', bg='gray', font.lab=2,
     ylim=c(0,3.0), xlim=c(0,8))
abline(v=0.5)
plot(wal1960$gal, wal1960$CLH, xlab='Galactose Peq [mM]', ylab='Hepatic Clearance [ml/min]', 
     pch=21, col='black', bg='gray', font.lab=2,
     ylim=c(0,3000))
par(mfrow=c(1,2))
dev.off()



# dev.off()

d <- read.csv("Waldstein1960_Fig6.csv", sep="\t")