# plot a single simulation

rm(list=ls())
library(data.table)
library(libSBML)
library(matrixStats)
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

ma.settings$simulator <- 'ROADRUNNER'
task = 2
simId = 103
modelId <- paste('Galactose_v12_Nc20_core')

# create a model dictionary


dir = paste(ma.settings$dir.results, '/tmp_sim/T', task, sep='')
print(dir)
df = readDataForSimulation(dir=dir, simId=paste('Sim', simId, sep=''))
head(df)


plot(df$time, df[,2])
Nc=20

# Generate the important functions to analyse the results 

# create the different subsets for plotting
ids = names(df)
pp_compounds = ids[grep('PP__', names(df))]
pv_compounds = ids[grep('PP__', names(df))]

H01_compounds = ids[grep('H01__', names(df))]
H01_compounds

# plot H01
plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,5), type='l')
for (id in H01_compounds){
  lines(df$time, df[[id]])
}

# plot everything
plot(numeric(0), numeric(), xlim=c(0,100), ylim=c(0,5), type='l')
for (id in ids){
  if (id != 'time'){
    lines(df$time, df[[id]])
  }
}



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