################################################################
## GEC data
################################################################
# author: Matthias Koenig
# date: 2014-04-19

###############################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)

###############################################################
## Tygstrup1962 ##
###############################################################
tyg1962 <- read.csv(file.path(ma.settings$dir.expdata, "GEC", "Tygstrup1962.csv"), sep="\t")
head(tyg1962)
summary(tyg1962)

printCategoryPoints <- function(data, 
                                cats = c("male", "female"),
                                gcols = c(mcol, "darkorange"),
                                gpch = c(15, 17)  ){
  for (k in seq(length(cats))){
    print(cats[k])
    x <- data[data[1] == cats[k], 2]
    y <- data[data[1] == cats[k], 3]
    points(x, y, col=gcols[k], pch=gpch[k])  
  }
}

# Create the figure with the fit
create_plots = FALSE
if (create_plots == TRUE){
  png(filename=file.path(ma.settings$dir.results, 'Tygstrup1962.png'),
      width = 800, height = 800, units = "px", bg = "white",  res = 150)
}
par(mfrow=c(1,1))

summary(tyg1962)
cats = c('healthy', 'cirrhosis')
ccols = c("black", "darkorange")
cpch = c(15, 17)
plot(numeric(0), numeric(0), xlim=c(0,90), ylim=c(0,5), 
     main="Tygstrup1962",
     xlab="Age [years]", ylab="Galactose Elimination [mmol/min]")

for (k in 1:length(cats)){
  k
  inds <- which(tyg1962$state == cats[k])
  points(tyg1962$age[inds], tyg1962$GEC[inds], col=ccols[k], pch=cpch[k])  
}

legend("topright",  legend = cats, fill=ccols)


par(mfrow=c(1,1))
if (create_plots==TRUE){
  dev.off()
}