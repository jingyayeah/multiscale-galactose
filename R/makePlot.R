## makePlot.R
# Rscript makePlot.R sid
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

args <- commandArgs(trailingOnly = TRUE)
sim_file <- args[1]

sim_file = '/home/mkoenig/multiscale-galactose-results/django/timecourse/T3/Galactose_v12_Nc20_dilution_Sim497_roadrunner.csv'


# create model dataframe for simulation
if (is.na(sim_file)){
  print('No simulation file given')
} else {
  print('Simulation file:')
  print(sim_file)
  df = readDataForSimulationFile(sim_file)
  ids = names(df)
}

