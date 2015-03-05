# Model equation for filtration and reabsorption
# based on Kozlova2000


# important parameters and typical values
# mean pressure in HA is around 100mmHg. 
# The resistance of th e HA bed is around 30-40 times that of the
# portal venous bed. 
# see [Rappaport -> 161]
# portal pressure depends primarily on the state of constriction or
# dilatatation of the mesenteric and splenic arterioles and on the 
# intrahepatic resistance.
# Normal hepatic arterial pressure is already greatly reduced within the
# sinusoids and has little influence on the portal pressure [Rappaport -> 264,265]
# Modeling of resistance [??] 
# Presinusoidal & sinusoidal portal hypertension also occur depending on the the 
# site of hindrance factor.
# [Rappaport 286 -> hepatic venous pressure]

# Pa 50mm H20
# Pv 10mm H20 [Rappaport 122, 123, 291]

# pressure boundary conditions (converted to pascal)
Pa_per_mmHg = 133.322
Pa = 28.4   # [mmHg] (28.4, 32) arterial pressure
Pb = 12     # [mmHg] venous pressure
P0 = 20     # [mmHg] P0 = Poc-Pot, resulting oncotic pressure

hr = 1 # 20     # [-] hepatic resistance to flow
nu = 0.0012  # [Pa*s] viscosity (adaption of viscosity to actual values)
R = 3E-6    # [m] radius capillary
L = 600E-6  # [m] capilary length
r  = 50E-9  # [m] pore radius
# r  = 54E-9  # [m] pore radius (10, 100, 250)

l = 0.6E-6  # [m] pore length (capillary thickness)
Np = 1.3E12 # [1/m^2] pores density number of pores per unit area
# Np = 10E12 # [1/m^2] pores density number of pores per unit area


# Actual sinusoidal values
# Rappaport: low hydrostatic pressure sinusois of 2-3mmHg
sinusoid = TRUE
if (sinusoid){
  cat('# Hepatic Sinusoid Simulation #')
  Pa = 7   # [mmHg] (28.4, 32) arterial pressure
  Pb = 2     # [mmHg] venous pressure
  P0 = 0.5*(Pa+Pb)     # [mmHg] P0 = Poc-Pot, resulting oncotic pressure
  R = 4.4E-6 # [m]
  L = 500E-6 # [m]
  l = 1.65E-7 # [m]
  Np = 1E13 # [1/m^2]
  r = 5.35E-8 # [m]
}


# W = 8*nu/(pi*R^4) # [Pa*s/m^4] specific hydraulic resistance
# w = 4*nu*l/(pi^2*r^4*R*Np) # [Pa*s/m^2] hydraulic resistance of all pores

W = 8*nu*hr/(pi*R^4) # [Pa*s/m^4] specific hydraulic resistance
w = 4*nu*hr*l/(pi^2*r^4*R*Np) # [Pa*s/m^2] hydraulic resistance of all pores



lambda = sqrt(w/W) # [m]
lambda
lambda2 = sqrt(R^3*l/(2*pi*r^4*Np)) #[m]
lambda2

# solutions of the partial differential equations
# P(x) [mmHg] - pressure in mmHg
P_f <- function(x){
  # returns pressure in units of Pa, Pb, P0, i.e. Pa
  y <- (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) + 
       ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda) + P0
  return(y)
}

# Q(x) flow along sinusoid in [m^3/s]
Q_f <- function(x){
  p_x <- (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) - 
         ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda)
  p_x <- p_x * Pa_per_mmHg # [Pa]
  y <- - 1/sqrt(W*w) * p_x  # [m^3/Pa*s * Pa] = [m^3/s]
  return(y)
}

# q(x) flow through pores [m^2/s]
# why not volume flow ?
q_f <- function(x){
  p_x <- (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) + 
         ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda)
  p_x <- p_x * Pa_per_mmHg
  y <- 1/w * p_x # [m^2/Pa*s * Pa] = [m^2/s]
  return(y)
}

par(mfrow=c(3,1))
curve(P_f, from=0, to=L, font.lab=2,
      main='Pressure along capillary',
      xlab='x [m]', ylab='P(x) [mmHg]',
      xlim=c(0,L), ylim=c(0, Pa))
abline(h=0)

curve(Q_f, from=0, to=L, font.lab=2,
      main='Flow along capillary',
      xlab='x [m]', ylab='Q(x) [m^3/s]',
      xlim=c(0,L), ylim=c(0,10E-13))
abline(h=0)

curve(q_f, from=0, to=L, font.lab=2,
      main='Flow throw pores',
      xlab='x [m]', ylab='q(x) [m^2/s]',
      xlim=c(0,L))
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

plot(x, Qres, ylim=c(0, max(Qres)))

Q_f(0)
A <- pi*R^2
cat('A = ', A, ' [m^2]\n')
Q_f(0)/A
cat('v = ', Q_f(0)/A, ' [m/s]\n')



curve(v_f, from=0, to=L, font.lab=2,
      main='Flow throw pores',
      xlab='x [m]', ylab='v(x) [m/s]',
      xlim=c(0,L), ylim=c(0,0.004))
abline(h=0)

# Dependency between pressure and blood flow (at portal end)




# filtration and reabsorption processes
# q(x) [m^3/s] - flow perpendicular to sinusoid 