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
# '2014-12-03_T5'  # normal GEC ~ f_flow, f_scale (metabolic scaling)
# '2014-12-07_T6'  # normal GEC ~ f_flow, f_scale (metabolic scaling, mean)

folders <- c('2014-11-30_T1', '2014-12-03_T3', '2014-12-03_T5', '2014-12-07_T6')
for (folder in folders){
  assign(folder, calculate_GEC_curves(folder))
}

res <- calculate_GEC_curves('2014-12-08_T10')
GEC_f <- GEC_functions(task='T2')
str(GEC_f)
names(GEC_f)
plot_GEC_function(GEC_f)
d.mean <- GEC_f$d.mean
head(d.mean)

################################################################
## Normal Galactose Clearance & Elimination (20 years)
################################################################
# TODO: make function depending on person
rm(list=ls())
GEC_f <- GEC_functions(task='T1')
names(GEC_f)
plot_GEC_function(GEC_f)

################################################################
## Galactose Clearance & Elimination Curves (Ageing)
################################################################
# Create GEC curves in aging.
# Multiple processing of the individual GEC curves.
rm(list=ls())
task <- 'T3'
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

p1 <- ggplot(d.mean, aes(f_flow, R_per_vol_units*1500)) + geom_point() + geom_line() + facet_grid(~ age)
p2 <- ggplot(d.mean, aes(f_flow, Q_per_vol_units)) + geom_point() + geom_line() + facet_grid(~ age)
p3 <- ggplot(d.mean, aes(Q_per_vol_units, R_per_vol_units*1500)) + geom_point() + geom_line()+ ylim(0,5) +facet_grid(~ age)
multiplot(p1, p2, p3, cols=3)


################################################################
## Galactose Clearance & Elimination Curves (Expression Changes)
################################################################
# variation in scale_f
rm(list=ls())
task <- 'T6'
load(file=GEC_curve_file(task))
d.mean <- GEC_curves$d.mean
d.se <- GEC_curves$d.se
names(d.mean)

head(d.mean)
d.mean


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
