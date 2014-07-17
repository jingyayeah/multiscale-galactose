## makePlot.R
# Rscript makePlot.R sid
rm(list=ls())

library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

args <- commandArgs(trailingOnly = TRUE)

sim_id <- 'Sim1371'
sim_file <- args[1]
out_dir <- args[2]

sim_file = '/home/mkoenig/multiscale-galactose-results/django/timecourse/T10/Galactose_v15_Nc20_dilution_Sim1371_roadrunner.csv'
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

# get the variables to plot & calculate the plot limits
names(df)
plot_ids <- c(pp_ids, pv_ids)
plot_cols <- c(rep('Black', length(pp_ids)), 
               rep('Blue', length(pv_ids)))
xlimits = c(min(df$time), max(df$time))
ylimits = c(min(df[,plot_ids]), max(df[,plot_ids]))

xlimits = c(1000,1200)
ylimits = c(0,1)

# create plot standard
do_file_plots = F
if (do_file_plots){
  plot_file <- paste(out_dir, '/', task, "_", sim_id, '_plot1.png' , sep="")
  print(plot_file)
  png(filename=plot_file, 
      width = 500, height = 500, units = "px", bg = "white",  res = 72)
}
plot(numeric(0), numeric(), xlim=xlimits, ylim=ylimits, type='l')
plotTimecourse(df, plot_ids, cols=plot_cols)
plotTimecourse(df, c('PV__galM'), cols=c('BLUE'))

if (do_file_plots){
  dev.off()
}

# do the same with ggplot2
require(ggplot2)
require(reshape)
df.small <- df[,c('time', plot_ids)]
names(df.small)
# melt the data
df.melt <- melt(df.small, id.vars='time', variable_name = 'series')

# create additional column for name
# test <- sub(".*__", "", 'PP__gal')
df.melt$name <- sub(".*__", "", df.melt$series)
head(df.melt, n=40)

# plot on same grid, each series colored differently -- 
# good if the series have same scale
ggplot(df.melt, aes(x=time,y=value, colour=name, group=series)) + geom_line() + scale_y_continuous(limits=ylimits) + scale_x_continuous(limits=xlimits)



