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
# TODO: add error bars were available
# TODO: correction of all GE & CL values, when not based on ca-cv differences

# Read data #
kei1988 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Keiding1988.csv"), sep="\t")
tyg1958 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Tygstrup1958.csv"), sep="\t")
tyg1958 <- tyg1958[tyg1958$status=='healthy',]
tyg1954 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Tygstrup1954.csv"), sep="\t")
wal1960 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Waldstein1960_Tab1.csv"), sep="\t")
hen1982 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Henderson1982_Tab4.csv"), sep="\t")
hen1982 <- hen1982[hen1982$status == 'healthy', ]
win1965 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Winkler1965.csv"), sep="\t")
head(win1965)

exp <- list(
 kei1988=kei1988,
 tyg1958=tyg1958,
 tyg1954=tyg1954,
 wal1960=wal1960,
 hen1982=hen1982,
 win1965=win1965
)
exp_pchs <- rep(22,length(exp))
names(exp_pchs) <- names(exp)
exp_bg <- c('red', 'darkgreen', 'darkorange', 'blue', 'brown', rgb(0.3, 0.3, 0.3))
names(exp_bg) <- names(exp)
exp_cols <- rep('black', length(exp))
names(exp_cols) <- names(exp)

add_exp_legend <- function(loc="topleft", subset){
  legend(loc, legend=gsub("19", "", subset), col=exp_cols[subset], pt.bg=exp_bg[subset], pch=exp_pchs[subset], cex=0.8, bty='n')
}

fname <- file.path(ma.settings$dir.base, 'results', 'Galactose_elimination_experiments.png')
png(filename=fname, width=1800, height=1000, units = "px", bg = "white",  res = 120)
par(mfrow=c(2,4))

# [1] Galactose elimination
# -----------------------------------------------------
# Q * (ca - cv)
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Blood flow [ml/min]",
     ylab="Galactose elimination [mmol/min]",
     xlim=c(0, 3200), 
     ylim=c(0, 3))
points(tyg1958$bloodflowBS, tyg1958$GE, 
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]]) 
points(kei1988$bloodFlow, kei1988$HE, 
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(win1965$flowLiver, win1965$GE, 
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$GE, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
add_exp_legend(subset=c("tyg1958","kei1988", "win1965", "hen1982"))

plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose elimination [mmol/min]",
     xlim=c(0, 10), 
     ylim=c(0, 3))
points(tyg1958$ca, tyg1958$GE,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(wal1960$gal, wal1960$R, 
       bg=exp_bg[["wal1960"]], col=exp_cols[["wal1960"]], pch=exp_pchs[["wal1960"]])
points(kei1988$ca, kei1988$HE,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(win1965$ca, win1965$GE,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$css, hen1982$GE, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
add_exp_legend("bottomright", subset=c("tyg1958","wal1960", "kei1988", "win1965", "hen1982"))

# [2] Galactose extraction ratio ER
# -----------------------------------------------------
plot(numeric(0), numeric(0), type='n', font.lab=2, 
     xlab="Blood flow [ml/min]",
     ylab="Galactose extraction ratio [-]",
     ylim=c(0, 1.05),
     xlim=c(0, 3200))
points(tyg1958$bloodflowBS, tyg1958$ER,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$bloodFlow, kei1988$ER,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(win1965$flowLiver, win1965$ER,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$ER,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
abline(h=1, col="gray")
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "win1965", "hen1982"))

plot(numeric(0), numeric(0), type='n', font.lab=2, 
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose extraction ratio [-]",
     ylim=c(0, 1.05),
     xlim=c(0, 5))
points(tyg1958$ca, tyg1958$ER,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$ca, kei1988$ER,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(hen1982$css, hen1982$ER,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$ER,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
abline(h=1, col="gray")
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "hen1982", "win1965"))

# [3] Clearance
# -----------------------------------------------------
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Blood flow [ml/min]",
     ylab="Galactose clearance [ml/min]",
     xlim=c(0, 3200),
     ylim=c(0, 2600))
points(tyg1958$bloodflowBS, tyg1958$CL,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$bloodFlow, kei1988$HCL,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(win1965$flowLiver, win1965$CL,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$CL,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "win1965", "hen1982"))

plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose clearance [ml/min]",
     xlim=c(0, 10),
     ylim=c(0, 3200))
points(tyg1958$ca, tyg1958$CL,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$ca, kei1988$HCL,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
# points(kei1988$ca, kei1988$SCL, pch=22, col='black', bg=rgb(0,0,1.0, 0.5)) 
points(hen1982$css, hen1982$CL, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$CL,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
# points(wal1960$gal, wal1960$CLH, pch=21, col='black', bg='gray')
# CL_new <- (wal1960$R - 0.2*wal1960$gal/(wal1960$gal+0.1))/wal1960$gal *1000 
points(wal1960$gal, wal1960$CLH,
       bg=exp_bg[["wal1960"]], col=exp_cols[["wal1960"]], pch=exp_pchs[["wal1960"]])
add_exp_legend("topright", subset=c("tyg1958","kei1988", "hen1982", "win1965", "wal1960"))


# cv ~ ca (cv = ca*(1-ER) )
# -----------------------------------------------------
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Blood flow [ml/min]",
     ylab="Galactose venous [mmol/L]",
     xlim=c(0, 3200),
     ylim=c(0, 7))
points(tyg1958$bloodflowBS, tyg1958$cv,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$bloodFlow, kei1988$cv,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(win1965$flowLiver, win1965$cv,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$chv,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(rep(1500, nrow(tyg1954)), tyg1954$cv,
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
points(rep(1500, nrow(tyg1954)), tyg1954$cv, pch=7)
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "win1965", "hen1982", "tyg1954"))

plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose venous [mmol/L]",
     xlim=c(0, 8),
     ylim=c(0, 7))
points(tyg1958$ca, tyg1958$cv,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(tyg1954$ca, tyg1954$cv,
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
points(kei1988$ca, kei1988$cv,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(hen1982$css, hen1982$chv,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$cv,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
add_exp_legend("topleft", subset=c("tyg1958", "tyg1954", "kei1988", "hen1982", "win1965"))

par(mfrow=c(1,1))
dev.off()




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