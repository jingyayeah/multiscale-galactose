################################################################
## Analyse Marchesini dataset
################################################################
# GEC curves from Marchesini
#
# author: Matthias Koenig
# date: 2014-11-17
################################################################
rm(list=ls())
library(MultiscaleAnalysis)
setwd(ma.settings$dir.results)
create_plots = F

# Visualization options for gender
g.info <- gender.cols()


##############################################
# Datasets
##############################################
# preprocess
marG2 <- read.csv(file.path(ma.settings$dir.expdata, "raw_data", "marchesini", "Koenig_G2_v1.csv"), sep="\t")
marG2$GECkg <- marG2$GEC/marG2$bodyweight
marG2$gender <- as.character(marG2$sex)
marG2$gender[marG2$gender=='M'] <- 'male'
marG2$gender[marG2$gender=='F'] <- 'female'
marG2$gender[marG2$gender=='A'] <- 'all'

# filter
# marG2 <- marG2[marG2$A != 0.514, ] # filter out the high dose data
head(marG2)

# gec & geckg classification data
gec_data <- load_classification_data(name='GEC_classification')
head(gec_data)

##############################################
# Figures
##############################################
library(ggplot2)
table(marG2$type)
# plot GEC depending on type
g <- ggplot(marG2, aes(age, GEC, color=type))
p <- g + geom_point() + facet_grid(.~type)
p

p <- ggplot() + geom_point(aes(x=marG2$age, y=marG2$GEC, color=marG2$type)) + xlim(0,100) + ylim(0,5) + xlab("G2 age [years]") +
  ylab("G2 GEC [mmole/min]")
p


p <- ggplot() + geom_point(aes(x=marG2$age, y=marG2$GEC, color=marG2$type)) + geom_point(aes(x=gec_data$age, y=gec_data$GEC, size=1.2, alpha=0.9)) + xlim(0,100) + ylim(0,5) + xlab("G2 age [years]") +
    ylab("G2 GEC [mmole/min]")
p
# ggsave(filename="/home/mkoenig/Desktop/G2_GEC_overview.jpg", plot=p)

#################################
# Time dependency galactose
#################################



names(marG2)
plot(marG2$t.20, marG2$k.20, xlim=c(0,100), ylim=c(0,1000)) 
points(marG2$t.2, marG2$k.2) 
points(marG2$t.3, marG2$k.3) 
points(marG2$t.4, marG2$k.4) 
points(marG2$t.5, marG2$k.5) 
points(marG2$t.6, marG2$k.6)

hist(marG2$t.6)
plot(numeric(0), numeric(0), type='n', xlim=c(0,100), ylim=c(0,1000),
     main="GEC via single injection", xlab='time [min]', ylab='galactose [?]', 
     font.lab=2)
for (k in 1:nrow(marG2)){
# for (k in 1:10){
    lines(marG2[k, c('t.20', 't.2','t.3','t.4','t.5', 't.6')],
          marG2[k, c('k.20', 'k.2','k.3','k.4','k.5', 'k.6')], col=rgb(0,0,0,0.5))    
    points(marG2[k, c('t.20', 't.2','t.3','t.4','t.5', 't.6')],
          marG2[k, c('k.20', 'k.2','k.3','k.4','k.5', 'k.6')], col=rgb(0,0,0,0.5), cex=0.4)    
}


tmp <- marG2[marG2$type == 'N',c('sex', 'age', 'bodyweight', 'GEC', 'GECkg')]
tmp


## GEC ##
# marG2 <- marG2[marG2$type == 'N', ] # filtering by type
par(mfrow=c(1,1))
plot(marG2$age, marG2$GEC, type='n', xlim=c(0,100), ylim=c(0,6),
     xlab="age [years]", ylab="GEC [mmol/min]") 
points(marG2$age[marG2$gender=='male'], marG2$GEC[marG2$gender=='male'],
       pch=21, cex=0.5, col=g.info$cols[['male']], bg=g.info$cols[['male']]) 
points(marG2$age[marG2$gender=='female'], marG2$GEC[marG2$gender=='female'], 
       pch=21, cex=0.5, col=g.info$cols[['female']], bg=g.info$cols[['female']]) 

m1 <- lm(GEC ~ age, data=marG2)
abline(m1, lwd=3)
points(gec_data$age, gec_data$GEC, pch=21, cex=0.8, col=g.info$cols[['all']], bg=g.info$cols[['all']]) 


## GECkg ##
par(mfrow=c(1,1))
plot(marG2$age, marG2$GECkg, type='n', xlim=c(0,100), ylim=c(0,0.2),
     xlab="age [years]", ylab="GEC [mmol/min]") 
points(marG2$age[marG2$gender=='male'], marG2$GECkg[marG2$gender=='male'],
       pch=21, cex=0.5, col=g.info$cols[['male']], bg=g.info$cols[['male']]) 
points(marG2$age[marG2$gender=='female'], marG2$GECkg[marG2$gender=='female'], 
       pch=21, cex=0.5, col=g.info$cols[['female']], bg=g.info$cols[['female']]) 

points(gec_data$age, gec_data$GECkg, pch=21, cex=1.0, col=g.info$cols[['all']], bg=g.info$cols[['all']]) 

