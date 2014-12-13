################################################################
# Circos plot of dilution curves
################################################################
# Prepares the dilution data for visualization in circos.
# 
# TODO: visualize Multiple Indicator data
# author: Matthias Koenig
# date: 2014-12-13
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)

# Set folder and peak times for analysis
folder <- '2014-12-13_T9'   # Multiple indicator data
t_peak <- 5000               # [s] MID peak start
t_end <- 10000               # [s] simulation time

# Only small subset of simulation is of interest
time = seq(from=t_peak-5, to=t_peak+50, by=0.05) # approximation time for plot
# time = seq(from=t_peak-5, to=t_peak+10, by=0.01) # approximation time for plot

# Process the integration time curves
info <- process_folder_info(folder)
p <- preprocess_task(folder=folder, force=FALSE) 
pars <- p$pars
sim_ids <- rownames(pars)
names(p)

# Species in the dilution curves
compounds = c('gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM')
ccolors = c('gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue')
ids <- c( paste(rep('PP__', length(compounds)), compounds, sep=''), 
          paste(rep('PV__', length(compounds)), compounds, sep=''))
ccolors <- c(ccolors, ccolors)
names(ccolors) <- ids
ccolors

# Variation of background galactose levels for given tracer
f.level = "PP__gal" 
gal_levels <- levels(as.factor(pars[[f.level]]))
cat('Galactose levels: ', gal_levels, '\n')


# Select the ids for the approximation matrix
# PP__s, H01__s, H02__s, ..., H20__s, PV__s
compound = 'gal'
ids = c(sprintf('PP__%s', compound), sprintf('PP__%s', compound))



# Create the CSV file for the species of interest
name <- 'PP__galM'
df <- as.data.frame(p$x[[name]])
df$time <- time


