#---------------------------------------------------------------
# Pressure - Flow - Model
#---------------------------------------------------------------
# Model of pressure and flow dependency in the sinusoidal 
# unit based on Kozlova2000 solutions for filtration and
# reabsorption.
#
# author: Matthias Koenig
# date: 2014-03-05
#---------------------------------------------------------------
rm(list=ls())

# [1] Kozlova2000 model
# pressures


# Create standard parameters for calculation
p_flow <- list(
  Pa = 10,            # [mmHg] portal pressure
  Pb = 2.0,          # [mmHg] central pressure
  
  # viscosity, so that the actual blood flows are correct
  nu_f = 10,            # [-] flow dependent viscosity in capillaries (~ Factor 3 at 100µm/s)
  nu_plasma = 0.0018,   # [Pa*s]
  
  y_sin = 4.4E-6,  # [m]
  L = 500E-6,  # [m]
  y_end = 1.65E-7, # [m]
  N_fen = 10E12,   # [1/m^2]
  r_fen = 5.35E-8 # [m]
)
head(p_flow)

# Additional derived parameters
derived_pars <- function(p){
  p$Pa_per_mmHg = 133.322  # [Pa/mmHg]
  p$P0 = 0.5*(p$Pa+p$Pb)       # [mmHg] P0 = Poc-Pot, resulting oncotic pressure
  p$nu = p$nu_plasma * p$nu_f  # [Pa*s]
  
  p$W = 8*p$nu/(pi*p$y_sin^4)            # [Pa*s/m^4] specific hydraulic resistance (blood)
  p$w = 4*p$nu*p$y_end/(pi^2*p$r_fen^4*p$y_sin*p$N_fen)  # [Pa*s/m^2] hydraulic resistance of all pores (plasma)
  
  p$lambda = sqrt(p$w/p$W) # [m]
  p$lambda2 = sqrt(p$y_sin^3*p$y_end/(2*pi*p$r_fen^4*p$N_fen)) #[m]
  
  if (abs(p$lambda-p$lambda2)>1E-8){
    warning('Lambda calculation failed.')
  }
  return(p)
}
p_new <- derived_pars(p_flow)


y = with(p_new, p_new$lambda)

# solutions of the partial differential equations
# P(x) [mmHg] - pressure in mmHg
P_f <- function(x, p){
  # returns pressure in units of Pa, Pb, P0, i.e. Pa
  y <- with(p, 
    (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) + 
    ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda) + P0
  )
  return(y)
}

# Q(x) flow along sinusoid in [m^3/s]
Q_f <- function(x, p){
  y <- with(p, {
    p_x <- (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) - 
      ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda)
    p_x <- p_x * Pa_per_mmHg # [Pa]
    y <- - 1/sqrt(W*w) * p_x  # [m^3/Pa*s * Pa] = [m^3/s]
    })
  return(y)
}

# q(x) flow through pores [m^2/s]
# why not volume flow ?
q_f <- function(x, p){
  y <- with(p, {
    p_x <- (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) + 
      ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda)
    p_x <- p_x * Pa_per_mmHg
    y <- 1/w * p_x # [m^2/Pa*s * Pa] = [m^2/s]
  })
  return(y)
}

# flow velocity [m/s]
v_f <- function(x, p){
  Q <- Q_f(x,p) # [m^3/s]
  A <- pi*p$y_sin^2
  v <- Q/A
  return(v)
}

par(mfrow=c(3,1))
x <- seq(from=0, to=p_new$L, length.out=40)
plot(x, P_f(x, p_new), type='l',
      font.lab=2,
      main='Pressure along capillary',
      xlab='x [m]', ylab='P(x) [mmHg]',
      xlim=c(0,p_new$L), ylim=c(0, p_new$Pa))
abline(h=0)

plot(x, Q_f(x, p_new), type='l',
      font.lab=2,
      main='Flow along capillary',
      xlab='x [m]', ylab='Q(x) [m^3/s]',
      xlim=c(0,p_new$L), ylim=c(0,1E-13))
abline(h=0)

plot(x, q_f(x, p_new), type='l',
      font.lab=2,
      main='Flow through pores',
      xlab='x [m]', ylab='q(x) [m^2/s]',
      xlim=c(0,p_new$L))
abline(h=0)
par(mfrow=c(1,1))

v = v_f(x, p_new)
plot(x, v, type='l',
     font.lab=2,
     main='flow velocity',
     xlab='x [m]', ylab='v(x) [m/s]',
     xlim=c(0,p_new$L),
     ylim=c(0,1E-3))
abline(h=0)
abline(h=mean(v), lty=2)
cat('y_flow = ', mean(v), ' [m/s]\n')
par(mfrow=c(1,1))

#####################################################################
# Sampling from distributions
# load distributions


library(MultiscaleAnalysis)

dir_out <- file.path(ma.settings$dir.base, 'results', 'distributions')
fname <- file.path(dir_out, 'distribution_fit_data.csv')
p.gen <-read.csv(file=fname)
head(p.gen)
# sample from the distributions
# L, y_sin, y_dis, y_cell

vnames <- c('L', 'y_sin', 'y_dis', 'y_cell')
Nsample = 1000
p_set <- list()
for (name in vnames){
  cat(name, '\n')
  meanlog <- p.gen[p.gen$name==name, "meanlog"]
  sdlog <- p.gen[p.gen$name==name, "sdlog"]
  
  # scale <- p.gen[name, "scale_fac"]
  y <- rlnorm(Nsample,
              meanlog=meanlog, 
              sdlog=sdlog)
  p_set[[name]] = y
}
p_set <- as.data.frame(p_set)
names(p_set) <- vnames
str(p_set)

name <- 'L'
hist(y, ylim=c(0,1500))

# TODO: reduce the width of L distribution
hist(p_set[,1])
hist(p_set[,2])

# Calculate the new parameters
names(p_flow)
pflow_set <- as.list(rep(NA, Nsample))
for (k in 1:Nsample){
  p_new <- p_flow
  p_new$L <- p_set$L[k]
  p_new$y_sin <- p_set$y_sin[k]
  p_new$y_dis <- p_set$y_dis[k]
  p_new$y_cell <- p_set$y_cell[k]
  p_new <- derived_pars(p_new)
  pflow_set[[k]] <- p_new
}
head(pflow_set, 3)

# Plot the resulting distribution depending on the parameters

par(mfrow=c(3,1))

Lmax = max(p_set$L)
# P(x) ---------------------------------------------------
plot(numeric(0), numeric(0), type='n',
     font.lab=2,
     main='Pressure along capillary',
     xlab='x [m]', ylab='P(x) [mmHg]',
     xlim=c(0, Lmax), ylim=c(0, 5))
abline(h=0)
for (k in 1:Nsample){
  p <- pflow_set[[k]]
  x <- seq(from=0, to=p$L, length.out=40)
  lines(x, P_f(x, p), col=rgb(0,0,1, 0.5))
}

# Q(x) ---------------------------------------------------
plot(numeric(0), numeric(0), type='n',
     font.lab=2,
     main='Flow along capillary',
     xlab='x [m]', ylab='Q(x) [m^3/s]',
     xlim=c(0,Lmax), ylim=c(0,1E-13))
abline(h=0)
for (k in 1:Nsample){
  p <- pflow_set[[k]]
  x <- seq(from=0, to=p$L, length.out=40)
  lines(x, Q_f(x, p), col=rgb(0,0,1, 0.5))
}

# q(x) ---------------------------------------------------
plot(numeric(0), numeric(0), type='n',
     font.lab=2,
     main='Flow through pores',
     xlab='x [m]', ylab='q(x) [m^2/s]',
     xlim=c(0,Lmax), ylim=c(-1E-10, 1E-10))
abline(h=0)
for (p in pflow_set){
  x <- seq(from=0, to=p$L, length.out=40)
  lines(x, q_f(x, p), col=rgb(0,0,1, 0.5))
}

par(mfrow=c(1,1))


v = v_f(x, p_new)
plot(x, v, type='l',
     font.lab=2,
     main='flow velocity',
     xlab='x [m]', ylab='v(x) [m/s]',
     xlim=c(0,p_new$L),
     ylim=c(0,1E-3))
abline(h=0)


curve(v_f, from=0, to=L, font.lab=2,
      main='Flow throw pores',
      xlab='x [m]', ylab='v(x) [m/s]',
      xlim=c(0,L), ylim=c(0,0.004))
abline(h=0)

#
flow <- rep(NA, Nsample)
for (k in 1:Nsample){
  p <- pflow_set[[k]]
  flow[k] = v_f(0, p)
}
hist(flow, breaks = 20, xlim=c(0, 1.5E-3))
