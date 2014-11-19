rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

# gender color (all, male, female)
gender.levels <- c('all', 'male', 'female')
# gender.cols = c("black", "blue", "red")
gender.cols = c(rgb(0,0,0,0.5), rgb(0,0,1,0.5), rgb(1,0,0,0.5))
# gender.cols = c(rgb(0,0,0,0.5), rgb(0,0,0,0.5), rgb(0,0,0,0.5))
names(gender.cols) <- gender.levels

##############################################
# Read datasets
##############################################
f_liver_density = 1.08  # [g/ml] conversion between volume and weight

# sex, age, liverVolume
marG2 <- read.csv(file.path(ma.settings$dir.expdata, "marchesini", "Koenig_G2_v1.csv"), sep="\t")
marG2$GECkg <- marG2$GEC/marG2$bodyweight
marG2 <- marG2[marG2$A != 0.514, ]
str(marG2)
marG2$gender <- as.character(marG2$sex)
marG2$gender[marG2$gender=='M'] <- 'male'
marG2$gender[marG2$gender=='F'] <- 'female'
marG2$gender[marG2$gender=='A'] <- 'all'
head(marG2)

# Load the comparison datasets
# GEC~age data
fname <- file.path(ma.settings$dir.expdata, "processed", sprintf("%s_%s.Rdata", 'GEC', 'age'))
load(file=fname)
GEC_age <- data 
rm(data)

tmp <- marG2[marG2$type == 'N',c('sex', 'age', 'bodyweight', 'GEC', 'GECkg')]
tmp



library(ggplot2)

table(marG2$type)
# TODO: the different subtypes
g <- ggplot(marG2, aes(age, GEC, color=type))
p <- g + geom_point() + facet_grid(.~type)


p <- ggplot() + geom_point(aes(x=marG2$age, y=marG2$GEC, color=marG2$type)) + geom_point(aes(x=GEC_age$age, y=GEC_age$GEC, size=1.2, alpha=0.9)) + xlim(0,100) + ylim(0,5) + xlab("G2 age [years]") +
    ylab("G2 GEC [mmole/min]")
ggsave(filename="/home/mkoenig/Desktop/G2_GEC_overview.jpg", plot=p)

ggplot() + geom_boxplot(aes(y=marG2$GEC, color=marG2$type))

names(marG2)
plot(marG2$t.20, marG2$k.20, xlim=c(0,100), ylim=c(0,1000)) 
points(marG2$t.2, marG2$k.2) 
points(marG2$t.3, marG2$k.3) 
points(marG2$t.4, marG2$k.4) 
points(marG2$t.5, marG2$k.5) 
points(marG2$t.6, marG2$k.6) 

hist(marG2$t.6)
plot(numeric(0), numeric(0), type='n', xlim=c(0,100), ylim=c(0,1000)) 
for (k in 1:nrow(marG2)){
    lines(marG2[k, c('t.20', 't.2','t.3','t.4','t.5', 't.6')],
          marG2[k, c('k.20', 'k.2','k.3','k.4','k.5', 'k.6')], col=rgb(0,0,0,0.5)) 
}



p <- g + geom_point()
print(p)
g + geom_point()
# adding additional layers (smoother loess or lm, ...)
g + geom_point() + geom_smooth(method='lm')

# adding the facets
g + geom_point(color="steelblue", size=4, alpha=1/2) + geom_smooth(method='lm') + facet_grid(drv~.)



## GEC ##
marG2 <- marG2[marG2$type == 'N', ]
par(mfrow=c(1,1))
plot(marG2$age, marG2$GEC, type='n', xlim=c(0,100), ylim=c(0,6),
     xlab="age [years]", ylab="GEC [mmol/min]") 
points(marG2$age[marG2$gender=='male'], marG2$GEC[marG2$gender=='male'],
       pch=21, cex=0.5, col=gender.cols[['male']], bg=gender.cols[['male']]) 
points(marG2$age[marG2$gender=='female'], marG2$GEC[marG2$gender=='female'], 
       pch=21, cex=0.5, col=gender.cols[['female']], bg=gender.cols[['female']]) 

m1 <- lm(GEC ~ age, data=marG2)
abline(m1, lwd=3)

points(data$age, data$GEC, pch=21, cex=1.0, col=gender.cols[['all']], bg=gender.cols[['all']]) 



## GECkg ##
par(mfrow=c(1,1))
plot(marG2$age, marG2$GECkg, type='n', xlim=c(0,100), ylim=c(0,0.2),
     xlab="age [years]", ylab="GEC [mmol/min]") 
points(marG2$age[marG2$gender=='male'], marG2$GECkg[marG2$gender=='male'],
       pch=21, cex=0.5, col=gender.cols[['male']], bg=gender.cols[['male']]) 
points(marG2$age[marG2$gender=='female'], marG2$GECkg[marG2$gender=='female'], 
       pch=21, cex=0.5, col=gender.cols[['female']], bg=gender.cols[['female']]) 

# load the GEC~age data and plot
fname <- file.path(ma.settings$dir.expdata, "processed", sprintf("%s_%s.Rdata", 'GECkg', 'age'))
print(fname)
load(file=fname)
head(data)
points(data$age, data$GECkg, pch=21, cex=1.0, col=gender.cols[['all']], bg=gender.cols[['all']]) 

par(mfrow=c(1,1))




summary(marG2$type)
plot(marG2$age, marG2$GEC, type='n') 
points(marG2$age[marG2$type=='N'], marG2$GEC[marG2$type=='N'], col='Black') 
points(marG2$age[marG2$type=='E'], marG2$GEC[marG2$type=='E'], col='Red') 
points(marG2$age[marG2$type=='R'], marG2$GEC[marG2$type=='R'], col='Blue') 
points(marG2$age[marG2$gender=='female'], marG2$GEC[marG2$gender=='female'], col='Red') 

plot(marG2$age, marG2$GECkg, type='n') 
points(marG2$age[marG2$type=='E'], marG2$GECkg[marG2$type=='E'], col='Red') 

plot(marG2$age, marG2$weight) 
