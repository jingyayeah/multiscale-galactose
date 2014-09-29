# Calculation of probabilities



summary(m1)

age <- seq(20,90, by=10)
bloodflow <- 2065.369 -13.212*age
RSE <- 323.2
bf.sd <- RSE/2
d1 <- rnorm(500,mean=bloodflow[1], sd = bf.sd) 
dend <- rnorm(500,mean=bloodflow[8], sd = bf.sd) 
hist(d1)


##########################################################
# Function Definitions
##########################################################

# Fit function from detailed tissue model
# Provides the galactose clearance per ml tissue.
f_Rvol <- function(perfusion){
 # TODO: fit the information from the structural model  
 Rvol <- 3.87   # [mmole/min/ml]  
 return(Rvol)
}

# => returns distribution with probabilities
# => or return sampling
f_perfusion_from_age <- function(age, N){
  # Calculate the exact mean
  y.mean = - 0.0044*age + 1.2902
  y.sd = 0.1622
  # generate the distribution
  y <- rnorm(n=N, mean=y.mean, sd=y.sd)
  
  return(y)
}



f_livVolume_from_age <- function(age, range){
  # Calculate the exact mean
  y.mean = -7.8382 * age + 1654.681
  y.sd = 225.8646
  # generate the distribution by sampling
  y <- rnorm(n=N, mean=y.mean[k], sd=y.sd)
  # return the probabilities for the range
  y <- 
  
  return(y) 
}



# input
N = 100;
age <- seq(20,90, by=10)

# perfusion from age
test <- f_perfusion_from_age(age, N=10)

for (a in age){
  test <- f_livVolume_from_age(a, N=10)
}

N <- 200
res <- data.frame(age=NULL, livVolume=NULL) 
for (a in age){
  test <- f_livVolume_from_age(a=a, N=N)
  res <- rbind(res, data.frame(age=rep(a, N), livVolume=test))
}
summary(res)
str(res)
plot(res)
hist(test)



print(test)
apply

# liver volume from age



# necessary general input from here on is
# perfusion, livVolume, (bodyweight)

# Calculate galactose Removal per tissue [mmole/min/ml]

Rvol = f_Rvol(perfusion)

# scale removal to full liver : GEC in [mmol/min] 
GEC = Rvol * livVolume  
GEC = Rvol * livVolume  

# make a proper mesh of all the variables
x1 = seq(1:100)
x2 = seq(1:100)

p_x1 = dnorm(x = x1, mean=10, sd=3)
p_x2 = dnorm(x = x2, mean=50, sd=3)
plot(x1, p_x1)
f_test = x1*x2


# calculate GEC per bodyweight
GECkg = GEC / bodyweight

