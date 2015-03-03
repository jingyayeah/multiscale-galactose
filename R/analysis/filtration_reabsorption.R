# Model equation for filtration and reabsorption
# based on Kozlova2000


# important parameters and typical values

# pressure boundary conditions (converted to pascal)
Pa_per_mmHg = 133.322
Pa = 28.4   # [mmHg] (28.4, 32) arterial pressure
Pb = 12     # [mmHg] venous pressure
P0 = 20     # [mmHg] P0 = Poc-Pot, resulting oncotic pressure
nu = 0.0012  # [Pa*s] viscosity
R = 3E-6    # [m] radius capillary
L = 600E-6  # [m] capilary length
r  = 50E-9  # [m] pore radius
# r  = 54E-9  # [m] pore radius (10, 100, 250)

l = 0.6E-6  # [m] pore length (capillary thickness)
Np = 1.3E12 # [1/m^2] pores density number of pores per unit area
# Np = 10E12 # [1/m^2] pores density number of pores per unit area

W = 8*nu/(pi*R^4) # [Pa*s/m^4] specific hydraulic resistance
w = 4*nu*l/(pi^2*r^4*R*Np) # [Pa*s/m^2] hydraulic resistance of all pores

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
# How to calculate the pressure from the flow velocity ?
# flow velocity [m/s]
v_f <- function(){
  
}


# filtration and reabsorption processes
# q(x) [m^3/s] - flow perpendicular to sinusoid 