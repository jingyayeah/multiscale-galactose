#########################################
###   Load parameter file             ###
#########################################

parsfile <- paste(info.folder, '/', task, '_', modelId, '_parameters.csv', sep="")
pars <- read.csv(parsfile, header=TRUE)
names(pars)

# set row names
row.names(pars) <- paste("Sim", pars$sim, sep="")

# reserved keywords which are not parameters
keywords <- c('status', 'duration', 'core', 'sim')
# find the parameters not in keywords
pnames <- setdiff(names(pars), keywords) 
Np = length(pnames)

# plot parameter histogram
plotParameterHistogramm <- function(name, breaks=40){
  x <- pars[,name] 
  hist(x, breaks=breaks, xlab=name, main=paste("Histogram", name))
}

# create the plot
phist_file <-paste(info.folder, '/', task, "_parameter_histograms.png", sep="") 
print(phist_file)
png(filename=phist_file,
    width = 1800, height = 500, units = "px", bg = "white",  res = 150)
par(mfrow=c(1,Np))
for (k in seq(1,Np)){
  plotParameterHistogramm(pnames[k])
}
rm(k)
par(mfrow=c(1,1))
dev.off()

rm(keywords, Np, pnames, phist_file)
#########################################