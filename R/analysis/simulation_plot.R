################################################################
## Plot single simulations
################################################################
# Plot information of single simulations.
#
# author: Matthias Koenig
# date: 2014-12-07
################################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.base)

# Get overview over available simulations
folder <- '2014-12-07_T7'
info <- process_folder_info(folder)
str(info)
# Load the parameter file
pars <- loadParameterFile(file=info$parsfile)
head(pars)

# select some simulations from the file
simIds <- rownames(pars)
simIds

get_rdata_for_simulation <- function(sim_id, info){
  fname <- file.path(info$dir.simdata, sprintf('%s_%s_roadrunner.csv.Rdata', info$modelId, sim_id))
  cat(fname, '\n')                   
  load(fname)
  return(data)
}

# get data for simulation
data <- lapply(simIds, get_rdata_for_simulation, info)
names(data) <- simIds

ids = names(data[[1]])

# filter the ids (some are not timecourses)
keywords = c("time", "y_cell", "y_dis", "scale_f", "gal_challenge", "deficiency", "flow_sin", "L", "y_sin")

# plot some components via ids
plotTimecourse <- function(data, ids, cols='Black'){
  for (id in ids){
    if (!(id %in% keywords)){
      lines(data$time, data[[id]], col=cols)
    }
  }
}

data[[1]]$scale_f[1]
data[[2]]$scale_f[1]
data[[3]]$scale_f[1]
data[[4]]$scale_f[1]
data[[5]]$scale_f[1]

plot(numeric(0), numeric(0), type='n', xlim=c(1999,2030), ylim=c(0,8.5))
for(k in 1:length(simIds)){
  lines(data[[k]]$time, data[[k]]$PV__gal)
}
plot(numeric(0), numeric(0), type='n', xlim=c(1999,2030), ylim=c(0,8.5))
for(k in 1:length(simIds)){
  lines(data[[k]]$time, data[[k]]$H01__gal)
}


# subsets for plotting
pp_ids = ids[grep('PP__', names(df))]
pv_ids = ids[grep('PV__', names(df))]
H01_ids = ids[grep('H01__', names(df))]
gal_ids = ids[grep('__gal$', names(df))]
galM_ids = ids[grep('__galM$', names(df))]
#adp_ids = ids[grep('__a[d,t]p', names(df))]
#audp_ids = ids[grep('__[a,u][d,t]p$', names(df))]

par(mfrow=c(1,5))
for (k in 1:5){
  plot(numeric(0), numeric(0), ylim=c(0,10), xlim=c(0,10000))
  plotTimecourse(data[[k]], ids)
}
par(mfrow=c(1,1))

# create pp and pv plots
xlimits = c(1000, 1200)
ylimits = c(0, 0.5)
plot(numeric(0), numeric(0), xlim=xlimits, ylim=ylimits)
plotTimecourse(df, pp_ids)
plotTimecourse(df, pv_ids)

plotTimecourse(df, c('PV__galM'), col=c('Blue'))
plotTimecourse(df, c('PV__gal'), col=c('Red'))
plotTimecourse(df, c('PV__suc'), col=c('Green'))

# create plots for the metabolic model
xlimits = c(0, 30000)

# metabolites
m_names = c('PP__gal', 'PP__galM', 'adp', 'atp', 'udp', 'utp', 'nadp', 'nadph',
            'gal', 'gal1p', 'galM', 'galtol', 'glc1p', 'glc6p', 'h2oM', 'phos', 'ppi',
            'udpgal', 'udpglc')
H__ids = list()
for (name in m_names){
  pattern <- paste('__', name, '$', sep="")
  H__ids[[name]] = ids[grep(pattern, ids)]
} 

# energy bilance

par(mfrow=c(4,4))
plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,5), type='l', main="ATP", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['atp']], col='Blue')
plotTimecourse(df, H__ids[['adp']], col='Red')

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,0.5), type='l', main="UTP", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['utp']], col='Blue')
plotTimecourse(df, H__ids[['udp']], col='Red')
 
plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,0.3), type='l', main="NADPH", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['nadph']], col='Blue')
plotTimecourse(df, H__ids[['nadp']], col='Red')

plot(numeric(0), numeric(0))
# ---

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,7), type='l', main="Phosphate", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['phos']])

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,0.2), type='l', main="Pyrophosphate", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['ppi']])

plot(numeric(0), numeric(0))
plot(numeric(0), numeric(0))
# ---
plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,13), type='l', main="Galactose", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['gal']])
plotTimecourse(df, c('PP__gal'), col='Blue')

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,2), type='l', main="Galactose M", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['galM']])
plotTimecourse(df, c('PP__galM'), col='Blue')

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,3), type='l', main="Galactose-1P", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['gal1p']])

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,0.05), type='l', main="Glucose-1P", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['glc1p']])

# ---
plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,0.3), type='l', main="UDP-glc & UDP-gal", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['udpglc']], col='Blue')
plotTimecourse(df, H__ids[['udpgal']], col='Red')

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,0.3), type='l', main="Glucose-6P", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['glc6p']])

plot(numeric(0), numeric(0), xlim=xlimits, ylim=c(0,1.0), type='l', main="Galactitol", 
     xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, H__ids[['galtol']])

par(mfrow=c(1,1))

#####################################################################################
# plot the reactions for analysis
r_names = c('ALDR', 'ATPS', 'GALE', 'GALK', 'GALKM', 'GALT', 'GLUT2_GAL', 'GLUT2_GALM',
            'GLY', 'GTFGAL', 'GTFGLC', 'H2OM', 'IMP', 'NADPR', 'NDKU', 'PGM1', 'PPASE',
            'UGALP', 'UGP')
Hr__ids = list()
for (name in r_names){
  pattern <- paste('__', name, '$', sep="")
  Hr__ids[[name]] = ids[grep(pattern, ids)]
} 
Hr__ids
test <- unlist(Hr__ids)
test

max(df[,unlist(Hr__ids)])
min(df[,unlist(Hr__ids)])
plot(numeric(0), numeric(), xlim=xlimits, type='l',
     ylim=c(-10E-14, 10E-14))
plotTimecourse(df, unlist(Hr__ids))

par(mfrow=c(4,4))

plot(numeric(0), numeric(0), xlim=xlimits,  ylim=c(-10E-14, 10E-14),
     type='l', main="GLUT2", xlab='time [s]', ylab='concentration [mM]')
plotTimecourse(df, Hr__ids[['GLUT2_GAL']], col='Blue')
plotTimecourse(df, Hr__ids[['GLUT2_GALM']], col='Red')

par(mfrow=c(1,1))



plot(df$time, df$PP__gal, xlim=c(0,100), ylim=c(0,2), type='l')
for (k in seq(1,Nc)){
  # Sinusoid
  id = sprintf('S%02d__gal', k)
  lines(df$time, df[[id]], col="Gray")
  # Disse
  id = sprintf('D%02d__gal', k)
  lines(df$time, df[[id]], col="Green")
  # Hepatocyte
  id = sprintf('H%02d__gal', k)
  lines(df$time, df[[id]], col="Blue")
}
lines(df$time, df$PV__gal)


names(df)

library('ggplot2')
g <- ggplot(df, aes(time, PV__gal))
summary(g)

library("reshape2")
mdf <- melt(df, id.vars="time", value.name="value", variable.name="id")
head(mdf)

g1 <- ggplot(mdf, aes(time, id, group="id", colour="id"))
summary(g)


p <- g + geom_point() + geom_line()
p <- g1 + geom_point() + geom_line()
print(p)