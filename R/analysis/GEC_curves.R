################################################################
## Galactose Elimination
################################################################
# Calculates the galactose clearance, elimination, extraction
# fraction, ... for set of simulations (i.e. sample from underlying
# distribution)
# and perfusion. Creates response curves for the calculation of GEC
# for given tissue perfusion.
#
# GEC is calculated based on periportal galactose challenge and
# uses the steady state difference periportal/perivenious for 
# the calculation of GEC. Multiple sinusoidal units are combined
# to calculate the actual GEC for the given region.
#
# author: Matthias Koenig
# date: 2014-01-04
################################################################
# TODO: create the GEC functions

rm(list=ls())
library('MultiscaleAnalysis')
library('libSBML')
setwd(ma.settings$dir.base)

# Preprocess all the files
# ! Force update if additional simulations are performed !
folders <- c('2015-02-05_T1', # GEC ~ f_flow, galactose (baseline)
             '2015-02-05_T2')  # GEC ~ f_flow, galactose (baseline, mean)
             # '2014-12-08_T3', # GEC ~ f_flow (aging)
             # '2014-12-08_T4', # GEC ~ f_flow (aging, mean)
             # '2014-12-08_T5', # GEC ~ f_flow (Vmax)
             # '2014-12-08_T6') # GEC ~ f_flow (Vmax, mean)

folders <- paste('2015-02-05_T', 1:24, sep="")
folders

for (f in folders){
  preprocess_task(folder=f, force=FALSE) 
  # assign(folder, calculate_GEC_curves(folder))
}

################################################################
# Figures 
#   Galactose Elimination (GE), 
#   Extraction Ration (ER)
#   Clearance (CL)
#   Perivenous galactose (CL)
################################################################
# Preprocess raw data and integrate over the sinusoidal units
fs <- list(
  normal20 = '2015-02-05_T3',
  normal60 = '2015-02-05_T4',
  normal100 = '2015-02-05_T6'
)
names(fs)

# Calculate all the individual points, i.e. split data frame on factors
library(plyr)
factors <- c('f_flow', "gal_challenge")
t_peak <- 2000 
t_end <- 10000 

parscl <- list()
dfs <- list()
for (name in names(fs)){
  cat(name, '\n')
  # preprocess raw data
  processed <- preprocess_task(folder=fs[[name]], force=FALSE)
  # additional parameters in data frame
  parscl[[name]] <- extend_with_galactose_clearance(processed=processed, t_peak=t_peak, t_end=t_end)
  # perform integration over the sinusoidal units
  dfs[[name]] <- ddply(parscl[[name]], factors, 
                       f_integrate_GE, f_tissue=0.8, vol_liver=1500)
}


###################################
# Plots
###################################
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
  R_abs_vol_units = c(0, 3.0),
  CL_per_vol_units = c(0,1.1),
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
points(tyg1958$bloodflowBS, tyg1958$GE, 
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]]) 
points(kei1988$bloodFlow, kei1988$HE, 
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(win1965$flowLiver, win1965$GE, 
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$GE, 
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
add_exp_legend(subset=c("tyg1958","kei1988", "win1965", "hen1982"))


#--------------------------------------------
# [B] GE ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'R_abs_vol_units'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='f_flow', levels=f_levels)
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
points(win1965$flowLiver, win1965$ER,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$ER,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
abline(h=1, col="gray")
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "win1965", "hen1982"))
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
points(hen1982$css, hen1982$ER,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$ER,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
abline(h=1, col="gray")
add_exp_legend("bottomright", subset=c("tyg1958","kei1988", "hen1982", "win1965"))
#--------------------------------------------
# [E] CL ~ perfusion (various galactose)
#--------------------------------------------
xname = 'Q_abs_vol_units'
yname = 'CL_abs_vol_units'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
points(tyg1958$bloodflowBS, tyg1958$CL,
       bg=exp_bg[["tyg1958"]], col=exp_cols[["tyg1958"]], pch=exp_pchs[["tyg1958"]])
points(kei1988$bloodFlow, kei1988$HCL,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(win1965$flowLiver, win1965$CL,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$CL,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
add_exp_legend("topleft", subset=c("tyg1958","kei1988", "win1965", "hen1982"))
#--------------------------------------------
# [F] CL ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'CL_abs_vol_units'
empty_plot(xname, yname)
plot_data_exp(xname, yname, 
          variable='f_flow', levels=f_levels)
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
points(win1965$flowLiver, win1965$cv,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
points(hen1982$bloodflow, hen1982$chv,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(rep(1500, nrow(tyg1954)), tyg1954$cv,
        bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
# points(rep(1500, nrow(tyg1954)), tyg1954$cv, pch=7)
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
points(tyg1954$ca, tyg1954$cv,
       bg=exp_bg[["tyg1954"]], col=exp_cols[["tyg1954"]], pch=exp_pchs[["tyg1954"]])
points(kei1988$ca, kei1988$cv,
       bg=exp_bg[["kei1988"]], col=exp_cols[["kei1988"]], pch=exp_pchs[["kei1988"]])
points(hen1982$css, hen1982$chv,
       bg=exp_bg[["hen1982"]], col=exp_cols[["hen1982"]], pch=exp_pchs[["hen1982"]])
points(win1965$ca, win1965$cv,
       bg=exp_bg[["win1965"]], col=exp_cols[["win1965"]], pch=exp_pchs[["win1965"]])
add_exp_legend("topleft", subset=c("tyg1958", "tyg1954", "kei1988", "hen1982", "win1965"))
#--------------------------------------------
par(mfrow=c(1,1))

if (do_plot){
  dev.off()
}



################################################################

# TODO: necessary to calculate the various GE curves
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)


################################################################
## Normal Galactose Clearance & Elimination (20 years)
################################################################
# TODO: make function depending on person
rm(list=ls())

par(mfrow=c(1,2))
folder <- '2015-02-04_T1'
info <- process_folder_info(folder)
str(info)

res <- calculate_GEC_curves(folder, force=FALSE, B=10)
# TODO: necessary to calculate the various GE curves
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)
names(GEC_f)
GEC_f$d.mean[, c('f_flow', 'Q_per_vol_units')]

folder <- '2014-12-17_T18'
info <- process_folder_info(folder)
res <- calculate_GEC_curves(folder, force=FALSE, B=10)
head(res)
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)
par(mfrow=c(1,1))

p1 <- ggplot(GEC_f$d.mean, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ scale_f)
p1

d.mean <- GEC_f$d.mean
p1 <- ggplot(d.mean, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ scale_f)
p2 <- ggplot(d.mean, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ scale_f)
p3 <- ggplot(d.mean, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ scale_f)
multiplot(p1, p2, p3, cols=3)

################################################################
## Galactose Clearance & Elimination Curves (Expression Changes)
################################################################
# variation in scale_f
par(mfrow=c(1,2))
folder <- '2014-12-08_T1'
info <- process_folder_info(folder)
res <- calculate_GEC_curves(folder, force=FALSE, B=10)
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)

folder <- '2014-12-08_T2'
info <- process_folder_info(folder)
res <- calculate_GEC_curves(folder, force=FALSE, B=10)
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)
par(mfrow=c(1,1))


p1 <- ggplot(d.mean, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ scale_f)
p2 <- ggplot(d.mean, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ scale_f)
p3 <- ggplot(d.mean, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ scale_f)
multiplot(p1, p2, p3, cols=3)



###########################################################################
# Control plots for GEC curves
###########################################################################


# TODO: create images for the analysis
plot(parscl$f_flow, parscl$flow_sin)
plot(parscl$flow_sin, parscl$R)

p1 <- ggplot(parscl, aes(flow_sin, R, colour=c_out)) + geom_point() +facet_grid(f_flow ~ N_fen)
p2 <- ggplot(parscl, aes(flow_sin, CL, colour=c_out)) + geom_point() +facet_grid(f_flow ~ N_fen)
p3 <- ggplot(parscl, aes(flow_sin, ER, colour=c_out)) + geom_point() + facet_grid(f_flow ~ N_fen)
multiplot(p1, p2, p3, cols=3)

# Plot the generated GEC curves
head(d2)
p1 <- ggplot(d2, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p2 <- ggplot(d2, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ N_fen)
p3 <- ggplot(d2, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ N_fen)
multiplot(p1, p2, p3, cols=3)
d2
