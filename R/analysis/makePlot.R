## makePlot.R
# Rscript makePlot.R sid
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

args <- commandArgs(trailingOnly = TRUE)

s
sim_file <- args[1]
out_dir <- args[2]

sim_file = '/home/mkoenig/multiscale-galactose-results/django/timecourse/T3/Galactose_v12_Nc20_dilution_Sim497_roadrunner.csv'
out_dir = '/home/mkoenig/multiscale-galactose-results/tmp_plot'
print(sim_file)
print(out_dir)

# create model dataframe for simulation
if (is.na(sim_file)){
  print('No simulation file given')
} 

# plot some components via ids
plotTimecourse <- function(df, ids, cols='Black'){
  for (id in ids){
    lines(df$time, df[[id]], col=cols)
  }
}
  
df = readDataForSimulationFile(sim_file)
ids = names(df)

# subsets for plotting
pp_ids = ids[grep('PP__', names(df))]
pv_ids = ids[grep('PV__', names(df))]
H01_ids = ids[grep('H01__', names(df))]
gal_ids = ids[grep('__gal$', names(df))]
galM_ids = ids[grep('__galM$', names(df))]
adp_ids = ids[grep('__a[d,t]p', names(df))]
audp_ids = ids[grep('__[a,u][d,t]p$', names(df))]

# create some plots
create_plot_files = FALSE
if (create_plot_files){
  png(filename=paste(out_dir, '/', task, "_test_", name, sep=""),
      width = 500, height = 500, units = "px", bg = "white",  res = 72)
}
time <- getTimeFromPreprocessMatrix(preprocess.mat) - 10.0
plotCompound(time, preprocess.mat[[name]], name, col=ccolors[name], ylim=c(0,2.1))
if (create_plot_files){
  dev.off()
}


plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,2.3), type='l')
plotTimecourse(df, pp_ids, col='Black')
plotTimecourse(df, pv_ids, col='Blue')




