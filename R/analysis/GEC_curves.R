################################################################
## Creates GE curves for prediction
################################################################
# Creates the spline fit curves of GE depending on perfusion
# (and GE)
#
# author: Matthias Koenig
# date: 2015-02-12
################################################################
# TODO: create the GEC functions


rm(list=ls())
library('MultiscaleAnalysis')
library('libSBML')
setwd(ma.settings$dir.base)
do_plot = FALSE

# Preprocess raw data and integrate over the sinusoidal units
factors <- c('f_flow', "gal_challenge")
fs <- get_age_GE_folders()
tmp <- integrate_GE_folders(df_folders=fs, factors=factors) 
parscl <- tmp$parscl
dfs <- tmp$dfs
rm(tmp)

# In the plots the individual data points for the simulated 
# steady state galactose levels and flows
gal_levels <- as.numeric(levels(as.factor(dfs[[1]]$gal_challenge )))
gal_levels
f_levels <- as.numeric(levels(as.factor(dfs[[1]]$f_flow)))
f_levels
















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
