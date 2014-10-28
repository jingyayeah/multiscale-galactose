# how to combine to probability functions
# sample from combined probability densities

age.grid=seq(from=0, to=100, by=1)

qBCCG
par(mfrow=c(2,1))
y1 <- dnorm(x=age.grid,mean=50,sd=20)
y2 <- dnorm(x=age.grid, mean=40, sd=10)
y3 <- y1*y2
plot(age.grid, y1/max(y1), col='gray', type='l', ylim=c(0, 1.0))
points(age.grid, y2/max(y2), col='blue', type='l')
points(age.grid, y3/max(y3), col='red', type='l')

n <- 1000
yr1 <- rnorm(n, mean=50,sd=20)
yr2 <- rnorm(n, mean=40, sd=10)
yr3 <- yr1*yr2

hist(yr1, breaks=20, xlim=c(-10, 110), col=rgb(0.5, 0.5, 0.5, 0.25))
hist(yr2, breaks=20, xlim=c(-10, 110), col=rgb(0, 0, 1.0, 0.25), add=T)
hist(yr3, xlim=c(-10, 110), col=rgb(1.0, 0, 0, 0.25), add=T)

par(mfrow=c(1,1))

# use the cummulative distribution functions
par(mfrow=c(2,1))
y1 <- pnorm(q=age.grid,mean=50,sd=20)
y2 <- pnorm(q=age.grid, mean=40, sd=10)

# new cummulative distribution function
y3 <- y1*y2 
# to make it valid it has to normalized via the integral from -inf - inf
approxfun(x, y = NULL,       method = "linear",
          yleft, yright, rule = 1, f = 0, ties = mean)


plot(age.grid, y1, col='grey', type='l', ylim=c(0, 1.0))
points(age.grid, y2, col='blue', type='l')
points(age.grid, y3, col='red', type='l')

deriv


