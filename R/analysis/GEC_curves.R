################################################################
## Galactose Clearance & Elimination Curves
################################################################
# Calculates the galactose clearance for given region of interest
# and perfusion. Creates response curves for the calculation of GEC
# for given tissue perfusion.
#
# GEC is calculated based on periportal galactose challenge and
# uses the steady state difference periportal/perivenious for 
# the calculation of GEC. Multiple sinusoidal units are combined
# to calculate the actual GEC for the given region.
#
# author: Matthias Koenig
# date: 2014-12-06
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# Set of GEC curves to create from simulations
# '2014-11-30_T1'  # normal GEC ~ f_flow
# '2014-12-03_T3'  # normal GEC ~ f_flow, N_fen (ageing)
# '2014-12-08_T5'  
# '2014-12-07_T6'  # normal GEC ~ f_flow, f_scale (metabolic scaling, mean)

folders <- c('2014-12-08_T1', # GEC ~ f_flow (metabolic scaling)
             '2014-12-08_T2', # GEC ~ f_flow (metabolic scaling, mean)
             '2014-12-08_T3', # GEC ~ f_flow (aging)
             '2014-12-08_T4', # GEC ~ f_flow (aging, mean)
             '2014-12-08_T5', # GEC ~ f_flow (baseline)
             '2014-12-08_T6') # GEC ~ f_flow (baseline, mean)
for (folder in folders){
  assign(folder, calculate_GEC_curves(folder))
}


str(GEC_f)
names(GEC_f)

d.mean <- GEC_f$d.mean
d.mean[, c('f_flow', 'N_fen', 'R_per_vol_units')]

################################################################
## Normal Galactose Clearance & Elimination (20 years)
################################################################
# TODO: make function depending on person
rm(list=ls())

par(mfrow=c(1,2))
folder <- '2014-12-08_T5'
info <- process_folder_info(folder)
res <- calculate_GEC_curves(folder, force=FALSE, B=10)
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)
names(GEC_f)
GEC_f$d.mean[, c('f_flow', 'Q_per_vol_units')]


folder <- '2014-12-08_T6'
info <- process_folder_info(folder)
res <- calculate_GEC_curves(folder, force=FALSE, B=10)
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)
par(mfrow=c(1,1))



################################################################
## Galactose Clearance & Elimination Curves (Ageing)
################################################################
# Create GEC curves in aging.
# Multiple processing of the individual GEC curves.
rm(list=ls())

par(mfrow=c(1,2))
folder <- '2014-12-08_T3'
info <- process_folder_info(folder)
res <- calculate_GEC_curves(folder, force=TRUE, B=10)
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)

folder <- '2014-12-08_T4'
info <- process_folder_info(folder)
res <- calculate_GEC_curves(folder, force=TRUE, B=10)
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)
par(mfrow=c(1,1))



task <- 'T4'
load(file=GEC_curve_file(task))
d.mean <- GEC_curves$d.mean
d.se <- GEC_curves$d.se


add_age <- function(data, age.levels=c(20, 40, 60, 80, 100)){
  # add the age to the data frame
  N_fen.levels <- unique(data$N_fen)
  N_fen.levels <- N_fen.levels[order(N_fen.levels, decreasing=TRUE)]
  age.levels <- c(20, 40, 60, 80, 100)
  
  data$age <- NA
  for (k in seq_along(age.levels)){
    data$age[data$N_fen == N_fen.levels[k]] <- age.levels[k]
  }
  # add the base age
  tmp <- data[ data$age == 20, ]
  tmp$age <- 0
  data <- rbind(data, tmp)
  # reorder
  data <- data[with(data, order(f_flow, age)), ]
  return(data)
}
d.mean <- add_age(d.mean)
d.se <- add_age(d.se)

plot(numeric(0), numeric(0), xlim=range(d.mean$Q_per_vol_units), ylim=range(d.mean$R_per_vol_units)*1500, type='n',
     main="Effect of ageing on GEC", xlab='Q_per_vol_units', ylab='R_per_vol_units')
for (age in c(0, 20, 40, 60, 80, 100)){
  inds <- which(d.mean$age == age)
  with(d.mean, lines(Q_per_vol_units[inds], R_per_vol_units[inds]*1500) )
}


p1 <- ggplot(d.mean, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ age)
p2 <- ggplot(d.mean, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ age)
p3 <- ggplot(d.mean, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ age)
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
