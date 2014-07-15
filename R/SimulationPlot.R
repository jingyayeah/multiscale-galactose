################################################################
## Plot single simulations
################################################################
# Analysis of the galactose elimination simulations with varying
# galactose and varying blood flow
#
# author: Matthias Koenig
# date: 2014-07-14
################################################################
rm(list=ls())
library(data.table)
library(libSBML)
library(matrixStats)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

# Get overview over available simulations
ma.settings$simulator <- 'ROADRUNNER'
task <- 'T3'
date = '2014-07-15'
modelId <- paste('Galactose_v12_Nc20_dilution')
Nc <- 20

sname <- paste(date, '_', task, sep='')
parsfile <- file.path(ma.settings$dir.results, sname, 
                      paste(task, '_', modelId, '_parameters.csv', sep=""))
print(parsfile)
pars <- loadParameterFile(file=parsfile)
head(pars)


# create model dataframe for simulation
simId <- 497 # 298 (5) 
dir = paste(ma.settings$dir.results, '/tmp_sim/', task, sep='')
df = readDataForSimulation(dir=dir, simId=paste('Sim', simId, sep=''))
head(df)
ids = names(df)


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
adp_ids = ids[grep('__a[d,t]p', names(df))]
audp_ids = ids[grep('__[a,u][d,t]p$', names(df))]

# create some plots
plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,2.3), type='l')
plotTimecourse(df, pp_ids)
plotTimecourse(df, pv_ids)
plotTimecourse(df, c('PV__galM'), col=c('Blue'))
plotTimecourse(df, c('PV__gal'), col=c('Red'))

plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,0.05), type='l')
plotTimecourse(df, c('PV__galM'), col=c('Blue'))

plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,5.1), type='l')
plotTimecourse(df, gal_ids)
plotTimecourse(df, c('PV__gal'), col=c('Red'))
plotTimecourse(df, c('PP__gal'), col=c('Red'))

plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,2.0), type='l')
plotTimecourse(df, ids)

plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,0.5), type='l')
plotTimecourse(df, galM_ids)
plotTimecourse(df, gal_ids, col=c('Blue'))
head(df[,gal_ids])


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