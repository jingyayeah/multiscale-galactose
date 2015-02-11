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

# TODO: calculate the GEC curves depending on age


################################################################
# Figures 
#   Galactose Elimination (GE), 
#   Extraction Ration (ER)
#   Clearance (CL)
#   Perivenous galactose (CL)
################################################################
# Preprocess raw data and integrate over the sinusoidal units
fs <- list()
fs$normal20 <- '2015-02-05_T3'
fs$normal60 <- '2015-02-05_T4'
fs$normal100 <- '2015-02-05_T6'
names(fs)

# Calculate all the individual points, i.e. split data frame on factors
library(plyr)
factors <- c('f_flow', "gal_challenge")
t_peak <- 2000 
t_end <- 10000 

processed <- list()
dfs <- list()
for (name in names(fs)){
  cat(name, '\n')
  # preprocess raw data
  processed[[name]] <- preprocess_task(folder=fs[[name]], force=FALSE)
  # additional parameters in data frame
  parscl <- extend_with_galactose_clearance(processed=processed[[name]], t_peak=t_peak, t_end=t_end)
  # perform integration over the sinusoidal units
  dfs[[name]] <- ddply(parscl, factors, f_integrate_GE)
}
 

###################################
# Plots
###################################
# TODO: GE in µmol
fname <- file.path(ma.settings$dir.base, 'results', 'Galactose_elimination.png')
png(filename=fname, width=1800, height=1000, units = "px", bg = "white",  res = 120)
par(mfrow=c(2,4))

# In the plots the individual data points for the simulated 
# steady state galactose levels and flows
gal_levels <- as.numeric(levels(as.factor(dfs[[1]]$gal_challenge )))
gal_levels
f_levels <- as.numeric(levels(as.factor(dfs[[1]]$f_flow)))
f_levels

labels <- list(
  Q_per_vol_units = 'Perfusion (P) [ml/min/ml(liver)]',
  R_per_vol_units = 'Galactose Elimination (GE) [mmol/min/ml(liver)]',
  c_in.mean = 'Periportal galactose (ci) [mmol/L]',
  c_out.mean = 'Perivenous galactose (co) [mmol/L]',
  ER.mean = 'Extraction Ratio (ER) [-]',
  CL_per_vol_units = 'Clearance (CL) [ml/min/ml liver tissue]'
)
limits <- list(
  Q_per_vol_units = c(0,3),
  R_per_vol_units = c(0,0.0025),
  c_in.mean = c(0,9),
  c_out.mean = c(0,8),
  ER.mean = c(0,1),
  CL_per_vol_units = c(0,1.3)
)

colors <- c("black", rgb(0,0,1,0.5), rgb(1,0,0,0.5))
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
      if (k==1){
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
plot_data(xname, yname, 
          variable='gal_challenge', levels=gal_levels)
add_legend("topright")
#--------------------------------------------
# [D] ER ~ galactose (various perfusion)
#--------------------------------------------
xname = 'c_in.mean'
yname = 'ER.mean'
empty_plot(xname, yname)
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

par(mfrow=c(1,1))
dev.off()

###########################################################################################
# AGE PLOTS WITH EXPERIMENTAL DATA
###########################################################################################

wal1960 <- read.csv(file.path(ma.settings$dir.exp, 'GEC', "Waldstein1960_Tab1.csv"), sep="\t")
# vol_liv = 1500/1.25 # [ml]
vol_liv <- 1500*0.8

par(mfrow=c(1,2))
#--------------------------------------------
# [B] GE ~ galactose (various perfusion)
#--------------------------------------------
plot(df_int20$c_in.mean, df_int20$R_per_vol_units * vol_liv, type='n',
     xlab='Periportal galactose [mmol/L]',
     ylab='Galactose Elimination (GE) [mmol/min]',
     font.lab=2)
for (f in c(0.5)){
  d <- df_int20[df_int20$f_flow == f, ]
  points(d$c_in.mean, d$R_per_vol_units * vol_liv, pch=21, col='black', bg=rgb(0,0,1,0.5))  
  lines(d$c_in.mean, d$R_per_vol_units * vol_liv, col='black', lwd=2)  
  d <- df_int60[df_int60$f_flow == f, ]
  points(d$c_in.mean, d$R_per_vol_units * vol_liv, pch=21, col='black', bg=rgb(1,0,0,0.5))  
  lines(d$c_in.mean, d$R_per_vol_units * vol_liv, col='red', lwd=2)  
}
points(wal1960$gal, wal1960$R, pch=21, col='black', bg='gray')
abline(h=3.2, col='red')

#--------------------------------------------
# [F] CL ~ galactose (various perfusion)
#--------------------------------------------
plot(df_int20$c_in.mean, df_int20$CL_per_vol_units * vol_liv, type='n',
     xlab='Periportal galactose [mM]',
     ylab='Clearance [ml/min]',
     font.lab=2)
for (f in c(0.5)){
  d <- df_int20[df_int20$f_flow == f, ]
  points(d$c_in.mean, d$CL_per_vol_units * vol_liv, pch=21, col='black', bg=rgb(0,0,1,0.5))  
  lines(d$c_in.mean, d$CL_per_vol_units * vol_liv, col='black', lwd=2)  
  d <- df_int60[df_int60$f_flow == f, ]
  points(d$c_in.mean, d$CL_per_vol_units * vol_liv, pch=21, col='black', bg=rgb(1,0,0,0.5))  
  lines(d$c_in.mean, d$CL_per_vol_units * vol_liv, col='red', lwd=2)  
}

points(wal1960$gal, wal1960$CLH, pch=21, col='black', bg='gray')
par(mfrow=c(1,1))



str(test)
head(test)

str(res)
str(res$GEC_curves)



# TODO: necessary to calculate the various GE curves
GEC_f <- GEC_functions(task=info$task)
plot_GEC_function(GEC_f)





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
