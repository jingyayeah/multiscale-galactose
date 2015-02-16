################################################################
# Experimentell data for GE curves
################################################################
# author: Matthias Koenig
# date: 2015-02-12
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(file.path(ma.settings$dir.exp, 'GEC'))
do_plot = TRUE

# Function for correcting for systemic galactose clearance
gal <- seq(from=0, to=8.0, by=0.1)
Rbase <- calculate_Rbase(gal=gal)
plot(gal, Rbase, 
     xlab='galactose [mM]', ylab='Rbase [mmol/min]', 
     pch=21, bg='gray', cex=0.8,
     font.lab=2)
lines(gal, Rbase)

########################################################################
# Combined data (GE, ER, CL)
########################################################################
# Read data #
kei1988 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Keiding1988.csv"), sep="\t")
tyg1958 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Tygstrup1958.csv"), sep="\t")
tyg1958 <- tyg1958[tyg1958$status=='healthy',]
tyg1954 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Tygstrup1954.csv"), sep="\t")
wal1960 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Waldstein1960_Tab1.csv"), sep="\t")
hen1982 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Henderson1982_Tab4.csv"), sep="\t")
hen1982 <- hen1982[hen1982$status == 'healthy', ]
hen1982.tab2 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Henderson1982_Tab2.csv"), sep="\t")
win1965 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Winkler1965.csv"), sep="\t")

pal1965 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Palu1965_Fig6.csv"), sep="\t")
pal1965 <- pal1965[pal1965$status=='healthy', ]
# lots of outliers which are filtered
pal1965 <- pal1965[pal1965$GE<3.2, ]
pal1965 <- pal1965[!(pal1965$GE<2.3 & pal1965$Peq>3), ] 
with(pal1965, plot(Peq, GE))

# Data has to be corrected for systemic galactose clearance
# Necessary to correct the actual Rhep=GE & Clearance calculated from it
# (no) kei1988 (Clearance based on ca-co, femoral artery)
# (no) win1965 (CL & GE via ca-co difference, femoral artery)

# Corrrection necessary if estimation via peripheral blood concentration
# or via the infusion rate => After correction for the urinary loss is 
# still measuring systemic clearance & hepatic clearance

# (yes) wal1960 (GE & CLH via infusion rate, and periphereal c)
# (yes) tyg1954 (CL & GE estimated via cp-co)
# (yes CL, GE) tyg1958 (Clearance based on I/ci, GE via ca-co) 
# (yes) hen1982 (CL & GE vi infusion rate)

# Correction wal1960
wal1960$Rbase <- calculate_Rbase(wal1960$gal)
wal1960$GEcor = wal1960$R - wal1960$Rbase
wal1960$CLcor = wal1960$CLH - wal1960$Rbase/wal1960$gal*1000 
head(wal1960)
wal1960$CLcor/wal1960$CLH

# Correction tyg1954
head(tyg1954)
tyg1954$Rbase <- calculate_Rbase(tyg1954$ca)
tyg1954$GEcor = tyg1954$GEEst - tyg1954$Rbase
tyg1954$CLcor = tyg1954$CLEst - tyg1954$Rbase/tyg1954$ca*1000 
tyg1954$CLcor/tyg1954$CLEst

# Correction tyg1958
head(tyg1958)
tyg1958$Rbase <- calculate_Rbase(tyg1958$ca)
tyg1958$GEcor = tyg1958$GE - tyg1958$Rbase
tyg1958$CLcor = tyg1958$CL - tyg1958$Rbase/tyg1958$ca*1000 
tyg1958$CLcor/tyg1958$CL

# Correction hen1982
head(hen1982)
hen1982$Rbase <- calculate_Rbase(hen1982$css)
hen1982$GEcor = hen1982$GE - hen1982$Rbase
hen1982$CLcor = hen1982$CL - hen1982$Rbase/hen1982$css*1000 
hen1982$CLcor/hen1982$CL

head(hen1982.tab2)
hen1982.tab2$Rbase <- calculate_Rbase(hen1982.tab2$css)
hen1982.tab2$GEcor = hen1982.tab2$GE - hen1982.tab2$Rbase
hen1982.tab2$CLcor = hen1982.tab2$CL - hen1982.tab2$Rbase/hen1982.tab2$css*1000 
hen1982.tab2$CLcor/hen1982.tab2$CL

# Correction pal1965
pal1965$Rbase <- calculate_Rbase(pal1965$Peq)
pal1965$GEcor = pal1965$GE - pal1965$Rbase
pal1965$CLcor = pal1965$CL - pal1965$Rbase/pal1965$Peq*1000 


# Errorbars available in the following datasets
# kei1988 (ca, cv, ER, GE)
# wal1960 (Peq-> ca)

# Create one combined dataset 

exp <- list(
 kei1988=kei1988,
 tyg1958=tyg1958,
 tyg1954=tyg1954,
 wal1960=wal1960,
 hen1982=hen1982,
 win1965=win1965,
 pal1965=pal1965
)

exp_pchs <- rep(22,length(exp))
names(exp_pchs) <- names(exp)
exp_bg <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3), 'magenta')
names(exp_bg) <- names(exp)
exp_cols <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3), 'magenta')
names(exp_cols) <- names(exp)

add_exp_legend <- function(loc="topleft", subset){
  legend(loc, legend=gsub("19", "", subset), col=exp_cols[subset], pt.bg=exp_bg[subset], pch=exp_pchs[subset], cex=0.8, bty='n')
}

if (do_plot){
  fname <- file.path(ma.settings$dir.base, 'results', 'Galactose_elimination_experiments.png')
  png(filename=fname, width=1800, height=1000, units = "px", bg = "white",  res = 120)
}
par(mfrow=c(2,4))

# [1] Galactose elimination
# -----------------------------------------------------
# Q * (ca - cv)
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Blood flow [ml/min]",
     ylab="Galactose elimination [mmol/min]",
     xlim=c(0, 3200), 
     ylim=c(0, 3))
points(tyg1958$bloodflowBS, tyg1958$GEcor, 
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]]) 
points(kei1988$bloodFlow, kei1988$HE,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
segments(kei1988$bloodFlow-kei1988$bloodFlowSE, kei1988$HE,
         kei1988$bloodFlow+kei1988$bloodFlowSE, kei1988$HE,
         col=exp_cols[["kei1988"]])
segments(kei1988$bloodFlow, kei1988$HE-kei1988$HESE,
         kei1988$bloodFlow, kei1988$HE+kei1988$HESE,
         col=exp_cols[["kei1988"]])
points(win1965$flowLiver, win1965$GE, 
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$GEcor, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(tyg1954$bloodflowEst, tyg1954$GEcor, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$bloodflowEst, tyg1954$GEcor, col=exp_cols[["tyg1954"]])
add_exp_legend(subset=c("tyg1958","kei1988", "win1965", "hen1982", "tyg1954"))

plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose elimination [mmol/min]",
     xlim=c(0, 10), 
     ylim=c(0, 3.1))
points(tyg1958$ca, tyg1958$GEcor,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(wal1960$gal, wal1960$GEcor,
       bg=exp_bg[["wal1960"]], col=exp_cols[["wal1960"]], pch=exp_pchs[["wal1960"]])
segments(wal1960$gal-wal1960$galSd, wal1960$GEcor,
         wal1960$gal+wal1960$galSd, wal1960$GEcor,
         col=exp_cols[["wal1960"]])
points(kei1988$ca, kei1988$HE,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
segments(kei1988$ca-kei1988$caSE, kei1988$HE,
         kei1988$ca+kei1988$caSE, kei1988$HE,
         col=exp_cols[["kei1988"]])
segments(kei1988$bloodFlow, kei1988$HE-kei1988$HESE,
         kei1988$bloodFlow, kei1988$HE+kei1988$HESE,
         col=exp_cols[["kei1988"]])
points(win1965$ca, win1965$GE,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$css, hen1982$GEcor, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(hen1982.tab2$css, hen1982.tab2$GEcor, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(pal1965$Peq, pal1965$GEcor, 
       bg=exp_bg[["pal1965"]], col=exp_cols[["pal1965"]], pch=exp_pchs[["pal1965"]])
points(tyg1954$ca, tyg1954$GEcor, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$ca, tyg1954$GEcor, col=exp_cols[["tyg1954"]])
add_exp_legend("bottomright", subset=c("tyg1958","wal1960", "kei1988", "win1965", "hen1982", "tyg1954", "pal1965"))

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
segments(kei1988$bloodFlow-kei1988$bloodFlowSE, kei1988$ER,
         kei1988$bloodFlow+kei1988$bloodFlowSE, kei1988$ER,
         col=exp_cols[["kei1988"]])
segments(kei1988$bloodFlow, kei1988$ER-kei1988$ERSE,
         kei1988$bloodFlow, kei1988$ER+kei1988$ERSE,
         col=exp_cols[["kei1988"]])
points(win1965$flowLiver, win1965$ER,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$ER,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(tyg1954$bloodflowEst, tyg1954$ER, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$bloodflowEst, tyg1954$ER, col=exp_cols[["tyg1954"]])
abline(h=1, col="gray")
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "win1965", "hen1982", "tyg1954"))

plot(numeric(0), numeric(0), type='n', font.lab=2, 
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose extraction ratio [-]",
     ylim=c(0, 1.05),
     xlim=c(0, 5))
points(tyg1958$ca, tyg1958$ER,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$ca, kei1988$ER,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
segments(kei1988$ca-kei1988$caSE, kei1988$ER,
         kei1988$ca+kei1988$caSE, kei1988$ER,
         col=exp_cols[["kei1988"]])
segments(kei1988$ca, kei1988$ER-kei1988$ERSE,
         kei1988$ca, kei1988$ER+kei1988$ERSE,
         col=exp_cols[["kei1988"]])
points(hen1982$css, hen1982$ER,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$ER,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(tyg1954$ca, tyg1954$ER,
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$ca, tyg1954$ER, col=exp_cols[["tyg1954"]])
abline(h=1, col="gray")
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "hen1982", "win1965", "tyg1954"))


# [3] Clearance
# -----------------------------------------------------
plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Blood flow [ml/min]",
     ylab="Galactose clearance [ml/min]",
     xlim=c(0, 3200),
     ylim=c(0, 2600))
points(tyg1958$bloodflowBS, tyg1958$CLcor,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$bloodFlow, kei1988$HCL,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
segments(kei1988$bloodFlow-kei1988$bloodFlowSE, kei1988$HCL,
         kei1988$bloodFlow+kei1988$bloodFlowSE, kei1988$HCL,
         col=exp_cols[["kei1988"]])
segments(kei1988$bloodFlow, kei1988$HCL-kei1988$HCLSE,
         kei1988$bloodFlow, kei1988$HCL+kei1988$HCLSE,
         col=exp_cols[["kei1988"]])
points(win1965$flowLiver, win1965$CL,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$CLcor,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(tyg1954$bloodflowEst, tyg1954$CLcor, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$bloodflowEst, tyg1954$CLcor, col=exp_cols[["tyg1954"]])
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "win1965", "hen1982", "tyg1954"))

plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose clearance [ml/min]",
     xlim=c(0, 10),
     ylim=c(0, 3200))
points(tyg1958$ca, tyg1958$CLcor,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$ca, kei1988$HCL,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
segments(kei1988$ca-kei1988$caSE, kei1988$HCL,
         kei1988$ca+kei1988$caSE, kei1988$HCL,
         col=exp_cols[["kei1988"]])
segments(kei1988$ca, kei1988$HCL-kei1988$HCLSE,
         kei1988$ca, kei1988$HCL+kei1988$HCLSE,
         col=exp_cols[["kei1988"]])
points(hen1982$css, hen1982$CLcor, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(hen1982.tab2$css, hen1982.tab2$CLcor, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$CL,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(pal1965$Peq, pal1965$CLcor, 
       bg=exp_bg[["pal1965"]], col=exp_cols[["pal1965"]], pch=exp_pchs[["pal1965"]])
points(tyg1954$ca, tyg1954$CLcor, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$ca, tyg1954$CLcor, col=exp_cols[["tyg1954"]])
points(wal1960$gal, wal1960$CLcor,
       bg=exp_bg[["wal1960"]], col=exp_cols[["wal1960"]], pch=exp_pchs[["wal1960"]])
segments(wal1960$gal-wal1960$galSd, wal1960$CLcor,
         wal1960$gal+wal1960$galSd, wal1960$CLcor,
         col=exp_cols[["wal1960"]])
add_exp_legend("topright", subset=c("tyg1958","kei1988", "hen1982", "win1965", "wal1960", "tyg1954", "pal1965"))

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
segments(kei1988$bloodFlow-kei1988$bloodFlowSE, kei1988$cv,
         kei1988$bloodFlow+kei1988$bloodFlowSE, kei1988$cv,
         col=exp_cols[["kei1988"]])
segments(kei1988$bloodFlow, kei1988$cv-kei1988$cvSE,
         kei1988$bloodFlow, kei1988$cv+kei1988$cvSE,
         col=exp_cols[["kei1988"]])
points(win1965$flowLiver, win1965$cv,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$chv,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(tyg1954$bloodflowEst, tyg1954$cv, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$bloodflowEst, tyg1954$cv, col=exp_cols[["tyg1954"]])
add_exp_legend("topleft", subset=c("tyg1958","kei1988", "win1965", "hen1982", "tyg1954"))

plot(numeric(0), numeric(0), type='n', font.lab=2,
     xlab="Galactose arteriell [mmol/L]",
     ylab="Galactose venous [mmol/L]",
     xlim=c(0, 8),
     ylim=c(0, 7))
points(tyg1958$ca, tyg1958$cv,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$ca, kei1988$cv,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
segments(kei1988$ca-kei1988$caSE, kei1988$cv,
         kei1988$ca+kei1988$caSE, kei1988$cv,
         col=exp_cols[["kei1988"]])
segments(kei1988$ca, kei1988$cv-kei1988$cvSE,
         kei1988$ca, kei1988$cv+kei1988$cvSE,
         col=exp_cols[["kei1988"]])
points(hen1982$css, hen1982$chv,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$cv,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(tyg1954$ca, tyg1954$cv,
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$ca, tyg1954$cv, col=exp_cols[["tyg1954"]])
add_exp_legend("topleft", subset=c("tyg1958", "kei1988", "hen1982", "win1965", "tyg1954"))

par(mfrow=c(1,1))
if (do_plot){
  dev.off()
}
