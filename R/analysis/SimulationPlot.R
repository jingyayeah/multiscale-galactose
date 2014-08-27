################################################################
## Plot single simulations
################################################################
# Plot information of single simulation for quality control
#
# author: Matthias Koenig
# date: 2014-07-28
################################################################
rm(list=ls())
library(data.table)
library(libSBML)
library(matrixStats)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

# Get overview over available simulations
ma.settings$simulator <- 'ROADRUNNER'
task <- 'T25'
modelId <- paste('Galactose_v21_Nc20_dilution')
simId <- 29966

dir = paste(ma.settings$dir.results, '/tmp_sim/', task, sep='')
fname = getSimulationFileFromSimulationId(dir, simId=paste('Sim', simId, sep=''))
df = readDataForSimulationFile(fname)
ids = names(df)
ids

# create model dataframe for simulation
#simId <- 1251

Sys.time()->start;
load('/home/mkoenig/multiscale-galactose-results/2014-07-30_T25/Galactose_v21_Nc20_dilution_Sim29921_roadrunner.csv.Rdata')
print(Sys.time()-start);



# plot some components via ids
plotTimecourse <- function(df, ids, cols='Black'){
  for (id in ids){
    lines(df$time, df[[id]], col=cols)
  }
}

# subsets for plotting
pp_ids = ids[grep('PP__', names(df))]
pv_ids = ids[grep('PV__', names(df))]
H01_ids = ids[grep('H01__', names(df))]
gal_ids = ids[grep('__gal$', names(df))]
galM_ids = ids[grep('__galM$', names(df))]
#adp_ids = ids[grep('__a[d,t]p', names(df))]
#audp_ids = ids[grep('__[a,u][d,t]p$', names(df))]

ids
plot(numeric(0), numeric(0), ylim=c(0,10), xlim=c(0,1200))
plotTimecourse(df, ids)

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