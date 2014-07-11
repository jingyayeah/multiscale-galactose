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


dir = paste(ma.settings$dir.results, '/tmp_sim/T', task, sep='')
print(dir)
df = readDataForSimulation(dir=dir, simId=paste('Sim', simId, sep=''))
head(df)


%%
plot(df$time, df[,2])

plot(df$time, df$PP__gal, xlim=c(0,100))
points(df$time, df$PV__gal)
plot(df$time, df$PV__gal)

names(df)
