################################################################################
# Individual GEC prediction ranges
################################################################################
# Demonstration curves to show the idea of individualized predictions.
#
# author: Matthias Koenig
# date: 24-10-2014
################################################################################
png(filename='home/mkoenig/muliscale-galactose/presentations/normal_ranges.png', width=1500, height=800, 
    units = "px", bg = "white",  res = 150)
N=100
par(mfrow=c(1,2))
m1 = 10; sd1 = 2
f1 <- function(x) {dnorm(x, mean=m1, sd=sd1)} 
curve(f1, from=0, to=17, col='black', lwd=3, main='subject 1',
      xlab='Test Result', ylab='Probability for reference population',
      font.lab=2, n=400)
abline(v=m1+2*sd1, lty=2, col='black',lwd=2)
abline(v=m1-2*sd1, lty=2, col='black',lwd=2)
abline(v=m1+1*sd1, lty=1, col='gray',lwd=3)

x1 <- seq(from=0, to=(m1-2*sd1), length.out=N)
y1 <- f1(x1) 
polygon(x=c(x1, rev(x1)), y=c(rep(0,N), rev(y1)), col='red')
x1 <- seq(from=(m1+2*sd1), to=20, length.out = N)
y1 <- f1(x1) 
polygon(x=c(x1, rev(x1)), y=c(rep(0,N), rev(y1)), col='red')

##
m1 = 5; sd1 = 0.8
f1 <- function(x) {dnorm(x, mean=m1, sd=sd1)} 
plot(f1, from=0, to=17, col='black', lwd=3, main='subject 2',
      xlab='Test Result', ylab='Probability for reference population',
      font.lab=2, 400)
abline(v=m1+2*sd1, lty=2, col='black',lwd=2)
abline(v=m1-2*sd1, lty=2, col='black',lwd=2)
abline(v=m1+3*sd1, lty=1, col='red',lwd=3)

x1 <- seq(from=0, to=(m1-2*sd1), length.out = N)
y1 <- f1(x1) 
polygon(x=c(x1, rev(x1)), y=c(rep(0,N), rev(y1)), col='red')
x1 <- seq(from=(m1+2*sd1), to=20, length.out = N)
y1 <- f1(x1) 
polygon(x=c(x1, rev(x1)), y=c(rep(0,N), rev(y1)), col='red')

par(mfrow=c(1,1))
dev.off()
