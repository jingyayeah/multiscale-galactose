################################################################
## GE curves
################################################################
# Calculate the galactose elimination (GE), clearance (CL), 
# extraction ratio (ER) for sets of simulations for given 
# perfusion and galactose concentration.
#
# GE is calculated based on periportal galactose challenge and
# the steady state difference periportal/perivenious.
# Integration over multiple sinusoidal units is performed to 
# calculate GEC for a region of interest.
#
# author: Matthias Koenig
# date: 2015-02-12
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
library('libSBML')
setwd(ma.settings$dir.base)

# Preprocess raw data and integrate over the sinusoidal units
factors <- c('f_flow', "gal_challenge")
fs <- get_age_GE_folders()
tmp <- integrate_GE_folders(df_folders=fs, factors=factors) 
parscl <- tmp$parscl
dfs <- tmp$dfs
rm(tmp)

################################################################
# Figures 
#   Galactose Elimination (GE), 
#   Extraction Ration (ER)
#   Clearance (CL)
#   Perivenous galactose (CL)
################################################################
do_plot = TRUE
if (do_plot){
  fname <- file.path(ma.settings$dir.base, 'results', 'Galactose_elimination.png')
  png(filename=fname, width=1800, height=1000, units = "px", bg = "white",  res = 120)
}

# In the plots the individual data points for the simulated 
# steady state galactose levels and flows
gal_levels <- as.numeric(levels(as.factor(dfs[[1]]$gal_challenge )))
gal_levels
f_levels <- as.numeric(levels(as.factor(dfs[[1]]$f_flow)))
f_levels

labels <- list(
  Q_per_vol_units = 'Perfusion (P) [ml/min/ml(liver)]',
  Q_abs_vol_units = 'Blood flow (Q) [ml/min]',
  R_per_vol_units = 'Galactose Elimination (GE) [µmol/min/ml(liver)]',
  R_abs_vol_units = 'Galactose Elimination (GE) [mmol/min]',
  CL_per_vol_units = 'Clearance (CL) [ml/min/ml(liver)]',
  CL_abs_vol_units = 'Clearance (CL) [ml/min]',
  c_in.mean = 'Periportal galactose (ci) [mmol/L]',
  c_out.mean = 'Perivenous galactose (co) [mmol/L]',
  ER.mean = 'Extraction Ratio (ER) [-]'
)
limits <- list(
  Q_per_vol_units = c(0,2.5),
  Q_abs_vol_units = c(0,4000),
  R_per_vol_units = c(0, 2.2),
  R_abs_vol_units = c(0, 3.5),
  CL_per_vol_units = c(0,1.8),
  CL_abs_vol_units = c(0,3000),
  c_in.mean = c(0,9),
  c_out.mean = c(0,8),
  ER.mean = c(0,1)
)


colors <- c("black", rgb(0.5,0.5,0.5,0.5), rgb(1,0,0,0.5))
names(colors) <- names(fs)
pchs <- rep(21, length(colors))
names(pchs) <- names(fs)
texts <- c('20 years', '60 years', '100 years')
names(texts) <- names(fs)

empty_plot <- function(xname, yname){
  plot(numeric(0), numeric(0), type='n', font.lab=2,
       xlab=labels[[xname]],
       ylab=labels[[yname]],
       xlim=limits[[xname]],
       ylim=limits[[yname]])
}

plot_data <- function(xname, yname, variable, levels){
  
  for (k in 1:length(dfs)){
    for (level in levels){
      name <- names(dfs)[length(dfs)+1-k]
      d <- dfs[[name]]
      d <- d[d[[variable]] == level, ]
      col <- colors[[name]]
      pch <- pchs[[name]]
      points(d[[xname]], d[[yname]], pch=pch, col=col, bg=col)  
      lines(d[[xname]], d[[yname]], col=col, lwd=1)  
      # text
      Np = length(d[[xname]])
      if (k==length(dfs)){
        t_level = level
        if (variable == 'f_flow'){
          t_level = sprintf('%1.2f', d$Q_per_vol_units[1])
        }
        text(1.1*d[[xname]][Np], d[[yname]][Np], labels=as.character(t_level), cex=0.7, font=2)
      }
    }
  }
}


add_legend <- function(loc="topleft"){
  legend(loc, legend=texts, col=colors, pt.bg=colors, pch=pchs, cex=0.8, lwd=1, bty='n')
}

###################################
# AGE PLOTS
###################################
par(mfrow=c(2,4))
#--------------------------------------------
# [A] GE ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_per_vol_units'
yname = 'R_per_vol_units'
empty_plot(xname, yname)
plot_data(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
add_legend()
#--------------------------------------------
# [B] GE ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'R_per_vol_units'
empty_plot(xname, yname)
plot_data(xname, yname, 
          variable='f_flow', levels=f_levels)
add_legend()
#--------------------------------------------
# [C] ER ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_per_vol_units'
yname = 'ER.mean'
empty_plot(xname, yname)
abline(h=1, col='gray')
plot_data(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
add_legend("topright")
#--------------------------------------------
# [D] ER ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'ER.mean'
empty_plot(xname, yname)
abline(h=1, col='gray')
plot_data(xname, yname, 
          variable='f_flow', levels=f_levels)
add_legend('bottomleft')
#--------------------------------------------
# [E] CL ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_per_vol_units'
yname = 'CL_per_vol_units'
empty_plot(xname, yname)
plot_data(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
add_legend('topleft')
#--------------------------------------------
# [F] CL ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'CL_per_vol_units'
empty_plot(xname, yname)
plot_data(xname, yname, 
          variable='f_flow', levels=f_levels)
add_legend('topright')
#--------------------------------------------
# [G] c_out ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_per_vol_units'
yname = 'c_out.mean'
empty_plot(xname, yname)
plot_data(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
add_legend('topleft')
#--------------------------------------------
# [H] c_out ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'c_out.mean'
empty_plot(xname, yname)
abline(a = 0, b=1, col='gray')
plot_data(xname, yname, 
          variable='f_flow', levels=f_levels)
add_legend('topleft')
#--------------------------------------------
par(mfrow=c(1,1))

if (do_plot){
  dev.off()
}

###########################################################################################
# AGE PLOTS WITH EXPERIMENTAL DATA
###########################################################################################
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

# Correction wal1960
wal1960$Rbase <- calculate_Rbase(wal1960$gal)
wal1960$GEcor = wal1960$R - wal1960$Rbase
wal1960$CLcor = wal1960$CLH - wal1960$Rbase/wal1960$gal*1000 
# Correction tyg1954
tyg1954$Rbase <- calculate_Rbase(tyg1954$ca)
tyg1954$GEcor = tyg1954$GEEst - tyg1954$Rbase
tyg1954$CLcor = tyg1954$CLEst - tyg1954$Rbase/tyg1954$ca*1000 
# Correction tyg1958
tyg1958$Rbase <- calculate_Rbase(tyg1958$ca)
tyg1958$GEcor = tyg1958$GE - tyg1958$Rbase
tyg1958$CLcor = tyg1958$CL - tyg1958$Rbase/tyg1958$ca*1000 
# Correction hen1982
hen1982$Rbase <- calculate_Rbase(hen1982$css)
hen1982$GEcor = hen1982$GE - hen1982$Rbase
hen1982$CLcor = hen1982$CL - hen1982$Rbase/hen1982$css*1000 
hen1982.tab2$Rbase <- calculate_Rbase(hen1982.tab2$css)
hen1982.tab2$GEcor = hen1982.tab2$GE - hen1982.tab2$Rbase
hen1982.tab2$CLcor = hen1982.tab2$CL - hen1982.tab2$Rbase/hen1982.tab2$css*1000 

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
exp_bg <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3))
names(exp_bg) <- names(exp)
exp_cols <- c('red', 'darkgreen', 'orange', 'blue', 'brown', rgb(0.3, 0.3, 0.3))
# exp_cols <- rep('black', length(exp))
names(exp_cols) <- names(exp)

add_exp_legend <- function(loc="topleft", subset){
  legend(loc, legend=gsub("19", "", subset), col=exp_cols[subset], pt.bg=exp_bg[subset], pch=exp_pchs[subset], cex=0.8, bty='n')
}

# To bring experimental data and the caculated curves together,
# the per volume response has to be scaled to the total liver.
# Assumption of liver volume

plot_data_exp <- function(xname, yname, variable, levels){
  for (level in levels){
    name <- names(dfs)[1]
    d <- dfs[[name]]
    d <- d[d[[variable]] == level, ]
    col <- colors[[name]]
    pch <- pchs[[name]]
    # points(d[[xname]], d[[yname]], pch=pch, col=col, bg=col)  
    lines(d[[xname]], d[[yname]], col=col, lwd=1)  
    # text
    Np = length(d[[xname]])
    t_level = level
    if (variable == 'f_flow'){
      t_level = sprintf('%2.0f', d$Q_abs_vol_units[1])
    }
    text(1.1*d[[xname]][Np], d[[yname]][Np], labels=as.character(t_level), cex=0.7, font=2)
  }
}

if (do_plot){
  fname <- file.path(ma.settings$dir.base, 'results', 'Galactose_elimination_with_exp.png')
  png(filename=fname, width=1800, height=1000, units = "px", bg = "white",  res = 120)
}
par(mfrow=c(2,4))
#--------------------------------------------
# [A] GE ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_abs_vol_units'
yname = 'R_abs_vol_units'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
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

#--------------------------------------------
# [B] GE ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'R_abs_vol_units'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='f_flow', levels=f_levels)
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
points(tyg1954$ca, tyg1954$GEcor, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$ca, tyg1954$GEcor, col=exp_cols[["tyg1954"]])
add_exp_legend("bottomright", subset=c("tyg1958","wal1960", "kei1988", "win1965", "hen1982", "tyg1954"))

#--------------------------------------------
# [C] ER ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_abs_vol_units'
yname = 'ER.mean'
empty_plot(xname, yname)
abline(h=1, col='gray')
plot_data_exp(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
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

#--------------------------------------------
# [D] ER ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'ER.mean'
empty_plot(xname, yname)
abline(h=1, col='gray')
plot_data_exp(xname, yname, 
              variable='f_flow', levels=f_levels)
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

#--------------------------------------------
# [E] CL ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_abs_vol_units'
yname = 'CL_abs_vol_units'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
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

#--------------------------------------------
# [F] CL ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'CL_abs_vol_units'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='f_flow', levels=f_levels)
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
points(tyg1954$ca, tyg1954$CLcor, 
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
lines(tyg1954$ca, tyg1954$CLcor, col=exp_cols[["tyg1954"]])
points(wal1960$gal, wal1960$CLcor,
       bg=exp_bg[["wal1960"]], col=exp_cols[["wal1960"]], pch=exp_pchs[["wal1960"]])
segments(wal1960$gal-wal1960$galSd, wal1960$CLcor,
         wal1960$gal+wal1960$galSd, wal1960$CLcor,
         col=exp_cols[["wal1960"]])
add_exp_legend("topright", subset=c("tyg1958","kei1988", "hen1982", "win1965", "wal1960", "tyg1954"))
#--------------------------------------------
# [G] c_out ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_abs_vol_units'
yname = 'c_out.mean'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
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
#--------------------------------------------
# [H] c_out ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'c_out.mean'
empty_plot(xname, yname)
abline(a = 0, b=1, col='gray')
plot_data_exp(xname, yname, 
          variable='f_flow', levels=f_levels)
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
#--------------------------------------------
par(mfrow=c(1,1))

if (do_plot){
  dev.off()
}

