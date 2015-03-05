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
  Pa = 5,            # [mmHg] portal pressure
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
  attach(p)
  p$Pa_per_mmHg = 133.322  # [Pa/mmHg]
  p$P0 = 0.5*(Pa+Pb)       # [mmHg] P0 = Poc-Pot, resulting oncotic pressure
  p$nu = nu_plasma * nu_f  # [Pa*s]
  
  p$W = 8*p$nu/(pi*y_sin^4)            # [Pa*s/m^4] specific hydraulic resistance (blood)
  p$w = 4*p$nu*y_end/(pi^2*r_fen^4*y_sin*N_fen)  # [Pa*s/m^2] hydraulic resistance of all pores (plasma)
  
  p$lambda = sqrt(p$w/p$W) # [m]
  p$lambda2 = sqrt(y_sin^3*y_end/(2*pi*r_fen^4*N_fen)) #[m]
  detach(p)
  if (p$lambda != p$lambda2){
    stop('Lambda calculation failed.')
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

# How to calculate the flow velocity from the blood flow ?

# flow velocity [m/s]
v_f <- function(x){
  Q <- Q_f(x) # [m^3/s]
  A <- pi*R^2
  v <- Q/A
  return(v)
}

x <- seq(from=0, to=L, length.out = 100)
Qres <- Q_f(x)
max(Qres)
min(Qres)
max(Qres)/min(Qres)