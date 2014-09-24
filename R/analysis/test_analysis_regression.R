# Calculation of probabilities


summary(m1)

age <- seq(20,90, by=10)
bloodflow <- 2065.369 -13.212*age
RSE <- 323.2
bf.sd <- RSE/2
d1 <- rnorm(500,mean=bloodflow[1], sd = bf.sd) 
dend <- rnorm(500,mean=bloodflow[8], sd = bf.sd) 
hist(d1)
