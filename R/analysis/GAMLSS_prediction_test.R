################################################################################
# GAMLSS prediction test
################################################################################
# Test the GAMLSS prediction of 
# - volLiver
# - volLiverkg
# - flowLiver
# - flowLiverkg
#
# author: Matthias Koenig
# date: 2014-11-20
################################################################################


#########################################
# volLiver densities
#########################################
# test data
age=60; sex='male'; bodyweight=50; height=170;  BSA=1.7

xlimits=c(0,4000); ylimits=c(0,0.002)
plot(numeric(0), numeric(0), type='n', xlim=xlimits, ylim=ylimits, 
     xlab='volLiver [ml]', ylab='probability', font.lab=2)
# volLiver ~ age
tmp <- f_d.factory(models=models.volLiver_age, xname='age', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiver ~ bodyweight
tmp <- f_d.factory(models=models.volLiver_bodyweight, xname='bodyweight', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiver ~ height
tmp <- f_d.factory(models=models.volLiver_height, xname='height', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiver ~ bsa
tmp <- f_d.factory(models=models.volLiver_BSA, xname='BSA', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)

# volLiverkg ~ age
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_age, xname='age', 
                              sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bodyweight
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                              sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ height
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_height, xname='height', 
                              sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bsa
tmp <- f_d.factory.bodyweight(models=models.volLiverkg_BSA, xname='BSA', 
                              sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)

# Example
age<-80; sex<-'male'; bodyweight<-55; BSA<-1.6; height=NA;
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], BSA=%s [m^2]', age, sex, bodyweight, BSA)
f_d.volLiver <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
summary(f_d.volLiver)

# plot single contributions and resulting density
# png(filename='/home/mkoenig/multiscale-galactose/presentations/volLiver_estimation_02.png', width=1000, height=1000, units = "px", bg = "white",  res = 150)
x <- seq(10, 3000, by=20)
plot(x, f_d.volLiver$f_d(x), 
     type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, , font.lab=2,
     main=info, xlab='liver volume [ml]', ylab='estimated probability density')
points(x, f_d.volLiver$f_ds[[1]](x), type='l', lty=1, col='red', lwd=2)
points(x, f_d.volLiver$f_ds[[2]](x), type='l', lty=1, col='orange', lwd=2)
points(x, f_d.volLiver$f_ds[[3]](x), type='l', lty=1, col='gray', lwd=2)
points(x, f_d.volLiver$f_ds[[4]](x), type='l', lty=1, col='black', lwd=2)
points(x, f_d.volLiver$f_ds[[5]](x), type='l', lty=2, col='red', lwd=2)
points(x, f_d.volLiver$f_ds[[6]](x), type='l', lty=2, col='orange', lwd=2)
points(x, f_d.volLiver$f_ds[[7]](x), type='l', lty=2, col='gray', lwd=2)
points(x, f_d.volLiver$f_ds[[8]](x), type='l', lty=2, col='black', lwd=2)
legend("topright", legend=c('combined', 'volLiver~age', 'volLiver~bodyweight', 'volLiver~height', 'volLiver~BSA', 
                            'volLiverkg~age', 'volLiverkg~bodyweight', 'volLiverkg~height', 'volLiverkg~BSA'), 
       lty=c(rep(1,5), rep(2,4)), col=c(gender.base_cols[[sex]], 'red', 'orange', 'gray', 'black', 'red', 'orange', 'gray', 'black'), lwd=rep(2,9))
# dev.off()

################################################################################
## Liver Volume per bodyweight
################################################################################
# volLiverkg
xlimits=c(0,80); ylimits=c(0,0.15)
plot(numeric(0), numeric(0), type='n', xlim=xlimits, ylim=ylimits, 
     xlab='volLiverkg [ml/kg]', ylab='probability', font.lab=2)
# volLiverkg ~ age
tmp <- f_d.factory(models=models.volLiverkg_age, xname='age', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bodyweight
tmp <- f_d.factory(models=models.volLiverkg_bodyweight, xname='bodyweight', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ height
tmp <- f_d.factory(models=models.volLiverkg_height, xname='height', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# volLiverkg ~ bsa
tmp <- f_d.factory(models=models.volLiverkg_BSA, xname='BSA', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)

# plot single contributions and resulting density
f_d.volLiverkg <- f_d.volLiverkg.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
summary(f_d.volLiverkg)
x <- seq(1, 80, by=0.1)
plot(x, f_d.volLiverkg$f_d(x), type='l', 
     lty=1, col=gender.base_cols[[sex]], lwd=2, font.lab=2,
     main=info, xlab='liver volume per bodyweight [ml/kg]', ylab='estimated probability density')
points(x, f_d.volLiverkg$f_ds[[1]](x), type='l', lty=2, col='red', lwd=2)
points(x, f_d.volLiverkg$f_ds[[2]](x), type='l', lty=2, col='orange', lwd=2)
points(x, f_d.volLiverkg$f_ds[[3]](x), type='l', lty=2, col='gray', lwd=2)
points(x, f_d.volLiverkg$f_ds[[4]](x), type='l', lty=2, col='black', lwd=2)
legend("topright", legend=c('combined', 'volLiver~age', 'volLiver~bodyweight', 'volLiver~height', 'volLiver~BSA'), 
       lty=c(1, rep(2,4)), 
       col=c(gender.base_cols[[sex]], 'red', 'orange', 'gray', 'black'), lwd=rep(2,5))
# dev.off()

################################################################################
## Liver Blood Flow
################################################################################
# test data
age=60; sex='male'; bodyweight=50; height=170;  BSA=1.7; volLiver=1500;


xlimits=c(0,4000); ylimits=c(0,0.002)
plot(numeric(0), numeric(0), type='n', xlim=xlimits, ylim=ylimits, 
     xlab='flowLiver [ml/min]', ylab='probability', font.lab=2)
# flowLiver ~ age
tmp <- f_d.factory(models=models.flowLiver_age, xname='age', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiver ~ bodyweight
tmp <- f_d.factory(models=models.flowLiver_bodyweight, xname='bodyweight', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiver ~ bsa
tmp <- f_d.factory(models=models.flowLiver_BSA, xname='BSA', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiverkg ~ age
tmp <- f_d.factory.bodyweight(models=models.flowLiverkg_age, xname='age', 
                              sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiverkg ~ bodyweight
tmp <- f_d.factory.bodyweight(models=models.flowLiverkg_bodyweight, xname='bodyweight', 
                              sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiverkg ~ bsa
tmp <- f_d.factory.bodyweight(models=models.flowLiverkg_BSA, xname='BSA', 
                              sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiver ~ volLiver
tmp <- f_d.factory(models=models.flowLiver_volLiver, xname='volLiver', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiver=volLiver)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)

f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiver=volLiver)


# some example values
age<-80; sex<-'male'; bodyweight<-55; BSA<-1.6; height=170; volLiver<-1500; volLiverkg=15
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], BSA=%s [m^2], volLiver=%s [ml/min]', age, sex, bodyweight, BSA, volLiver)
f_d.flowLiver <- f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiver=volLiver)
summary(f_d.flowLiver)

# plot single contributions and resulting density
# png(filename='/home/mkoenig/multiscale-galactose/presentations/volLiver_estimation_02.png', width=1000, height=1000, units = "px", bg = "white",  res = 150)
x <- seq(10, 3000, by=20)
plot(x, f_d.flowLiver$f_d(x), 
     type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, , font.lab=2,
     main=info, xlab='liver blood flow [ml/min]', ylab='estimated probability density')
points(x, f_d.flowLiver$f_ds[[1]](x), type='l', lty=1, col='red', lwd=2)
points(x, f_d.flowLiver$f_ds[[2]](x), type='l', lty=1, col='orange', lwd=2)
points(x, f_d.flowLiver$f_ds[[3]](x), type='l', lty=1, col='gray', lwd=2)
points(x, f_d.flowLiver$f_ds[[4]](x), type='l', lty=1, col='red', lwd=2)
points(x, f_d.flowLiver$f_ds[[5]](x), type='l', lty=2, col='orange', lwd=2)
points(x, f_d.flowLiver$f_ds[[6]](x), type='l', lty=2, col='gray', lwd=2)
points(x, f_d.flowLiver$f_ds[[7]](x), type='l', lty=2, col='black', lwd=2)
legend("topright", legend=c('combined', 'flowLiver~age', 'flowLiver~bodyweight', 'flowLiver~BSA',
                            'flowLiverkg~age', 'flowLiverkg~bodyweight', 'flowLiverkg~BSA', 'flowLiver~volLiver'), 
       lty=c(rep(1,4), rep(2,3), 3), col=c(gender.base_cols[[sex]], 'red', 'orange', 'gray', 'red', 'orange', 'gray', 'black'), lwd=rep(2,8))
# dev.off()

################################################################################
## Liver Blood Flow per bodyweight
################################################################################
xlimits=c(0,70); ylimits=c(0,0.2)
plot(numeric(0), numeric(0), type='n', xlim=xlimits, ylim=ylimits, 
     xlab='flowLiverkg [ml/min/kg]', ylab='probability', font.lab=2)

# flowLiverkg ~ age
tmp <- f_d.factory(models=models.flowLiverkg_age, xname='age', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiverkg ~ bodyweight
tmp <- f_d.factory(models=models.flowLiverkg_bodyweight, xname='bodyweight', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiverkg ~ bsa
tmp <- f_d.factory(models=models.flowLiverkg_BSA, xname='BSA', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)
# flowLiverkg ~ volLiverkg
tmp <- f_d.factory(models=models.flowLiverkg_volLiverkg, xname='volLiverkg', 
                   sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiverkg=volLiverkg)
curve(tmp, from=xlimits[1], to=xlimits[2], add=TRUE)

f_d.flowLiverkg.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiverkg=volLiverkg)

# some examples
age<-80; sex<-'male'; bodyweight<-55; BSA<-1.6; height=170; volLiver<-NA; volLiverkg=15
info <- sprintf('age=%s [y], sex=%s, bodyweight=%s [kg], BSA=%s [m^2], volLiverkg=%s [ml/min/kg]', age, sex, bodyweight, BSA, volLiverkg)
f_d.flowLiverkg <- f_d.flowLiverkg.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA, volLiverkg=volLiverkg)
summary(f_d.flowLiverkg)

# plot single contributions and resulting density
# png(filename='/home/mkoenig/multiscale-galactose/presentations/volLiver_estimation_02.png', width=1000, height=1000, units = "px", bg = "white",  res = 150)
x <- seq(1, 70, by=0.1)
plot(x, f_d.flowLiverkg$f_d(x), 
     type='l', lty=1, col=gender.base_cols[[sex]], lwd=2, , font.lab=2,
     main=info, xlab='liver blood flow per bodyweight [ml/min/kg]', ylab='estimated probability density')
points(x, f_d.flowLiverkg$f_ds[[1]](x), type='l', lty=1, col='red', lwd=2)
points(x, f_d.flowLiverkg$f_ds[[2]](x), type='l', lty=1, col='orange', lwd=2)
points(x, f_d.flowLiverkg$f_ds[[3]](x), type='l', lty=1, col='gray', lwd=2)
points(x, f_d.flowLiverkg$f_ds[[4]](x), type='l', lty=2, col='black', lwd=2)
legend("topright", legend=c('combined', 'flowLiverkg~age', 'flowLiverkg~bodyweight', 'flowLiverkg~BSA', 'flowLiverkg~volLiverkg'), 
       lty=c(rep(1,4), 2), col=c(gender.base_cols[[sex]], 'red', 'orange', 'gray', 'black'), lwd=rep(2,5))
# dev.off()


##############################################################################
# Test age dependency
age.test <- seq(1, 100, by=4)
bodyweight=20; BSA=NA; height=NA;

x = seq(from=1, to=3000, by=20)
par(mfrow=c(1,3))
for (k in seq(1:length(gender.levels))){
  sex <- gender.levels[k]
  col <- gender.cols[k]
  age = age.test[1]
  f_d.volLiver <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
  
  plot(x, f_d.volLiver$f_d(x), type='l', col=col, main=gender.levels[k])
  legend("topright", legend=c('volLiver~age'), lty=c(1), col=col)
  for (age in age.test){
    f_d.f <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, height=height, BSA=BSA)
    points(x, f_d.f$f_d(x), type='l', col=col)
  }
}
par(mfrow=c(1,1))

# bodyweight dependency
bodyweight.test <- seq(1, 120, by=6)
par(mfrow=c(1,3))
for (k in seq(1:length(gender.levels))){
  sex <- gender.levels[k]
  col <- gender.cols[k]
  f_d.f <- f_d.volLiver.c(sex=sex, bodyweight=bodyweight.test[1])
  plot(x, f_d.f$f_d(x), type='l', col=col, main=gender.levels[k])
  legend("topright", legend=c('volLiver~bodyweight'), lty=c(1),
         col=col)
  for (bodyweight in bodyweight.test){
    f_d.f <- f_d.volLiver.c(sex=sex, bodyweight=bodyweight)
    points(x, f_d.f$f_d(x), type='l', col=col)
  }
}
par(mfrow=c(1,1))


############################################################
# Rejection sampling for testing
############################################################

## find proper approximation of density ##
# get density
sex = 'male'; age=50; bodyweight=80; BSA=1.8;
f_d <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)$f_d
plot(f_d, from=0, to=3000, col="blue", ylab="")

# define 
interval <- c(1,3000) # interval for sampling (no sampling in zero regions)

# find maximum value
f_d.max_x <- optimize(f_d, interval=interval, maximum=TRUE)$maximum
f_d.max_y <- f_d(f_d.max_x)
f_d.max_x
f_d.max_y

# find half maximal value
f_d.half <- function(x){f_d(x)-0.5*f_d.max_y}
f_d.half_x1 <- uniroot(f_d.half, interval=c(interval[1], f_d.max_x))$root
f_d.half_x2 <- uniroot(f_d.half, interval=c(f_d.max_x, interval[2]))$root
sd <- max(f_d.max_x-f_d.half_x1, f_d.half_x2-f_d.max_x)

# sample within 3*sds within the interval
s.interval = c(max(interval[1], f_d.max_x - 3*sd), min(interval[2], f_d.max_x + 3*sd)) 
s.interval

# normalization constant for rejection sampling,
# so that the second function is above the sample function
m <- 1.01 * f_d.max_y / (1/(sd*sqrt(2*pi)))
m

funct1 <- function(x) {m*dnorm(x, mean=f_d.max_x, sd=sd)}
plot(funct1, from=s.interval[1], to=s.interval[2], col="blue", ylab="")
curve(f_d, from=s.interval[1], to=s.interval[2], col="red", add=T)

set.seed(1); Nsim <- 1e5
s.values <- NULL
while(length(s.values) < Nsim){
  x <- rnorm(n=Nsim, mean=f_d.max_x, sd=sd)
  u <- runif(n=Nsim)
  ratio <- f_d(x) / (m*dnorm(x, mean=f_d.max_x, sd=sd))
  ind <- I(u<ratio)
  s.values <- c(s.values, x[ind==1])
}
s.values=s.values[1:Nsim]
length(s.values) # as a check to make sure we have enough


plot(density(s.values))
hist(betas, freq=FALSE, add=T)
curve(funct1, from=s.interval[1], to=s.interval[2], col="red", lwd=2, add=T)
curve(f_d, from=s.interval[1], to=s.interval[2], col="blue", ylab="", add=T)


# test the rejection sampling
sex = 'male'; age=40; bodyweight=90; BSA=1.8; volLiver=2500;
f_d1 <- f_d.volLiver.c(sex=sex, age=age, bodyweight=bodyweight, BSA=BSA)$f_d
f_d2 <- f_d.flowLiver.c(sex=sex, age=age, bodyweight=bodyweight, volLiver=volLiver)$f_d

# rejection sampling
rs1 <- f_d.rejection_sample(f_d1, 1000, interval=c(1,3000))
plot(f_d1, from=0, to=3000, col="blue", ylab="")
hist(rs1$values, freq=FALSE, add=TRUE)

rs2 <- f_d.rejection_sample(f_d2, 1000, interval=c(1,3000))
plot(f_d2, from=0, to=3000, col="blue", ylab="")
hist(rs2$values, freq=FALSE, add=TRUE)
