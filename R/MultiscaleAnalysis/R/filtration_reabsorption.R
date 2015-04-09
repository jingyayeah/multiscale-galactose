################################################################
# Filtration/Reabsorption functions
################################################################
#
# author: Matthias Koenig
# date: 2015-04-09
################################################################

# TODO: fix nu_f

#' Create standard parameters for calculation
#' @export
koz_parameters <- function(){
  p_flow <- list(
    Pa = 10,            # [mmHg] portal pressure
    Pb = 2.0,           # [mmHg] central pressure
  
    # viscosity, so that the actual blood flows are correct
    nu_f = 10,            # [-] flow dependent viscosity in capillaries (~ Factor 3 at 100µm/s)
    nu_plasma = 0.0018,   # [Pa*s]
  
    y_sin = 4.4E-6,  # [m]
    L = 500E-6,      # [m]
    y_end = 1.65E-7, # [m]
    N_fen = 10E12,   # [1/m^2]
    r_fen = 5.35E-8  # [m]
  )
  return(p_flow)
}

#' Calculation of derived parameters from given 
#' base parameters.
#' @export
koz_derived_parameters <- function(p){
  p$Pa_per_mmHg = 133.322      # [Pa/mmHg]
  p$P0 = 0.5*(p$Pa+p$Pb)       # [mmHg] P0 = Poc-Pot, resulting oncotic pressure
  p$nu = p$nu_plasma * p$nu_f  # [Pa*s]
  
  p$W = 8*p$nu/(pi*p$y_sin^4)            # [Pa*s/m^4] specific hydraulic resistance (blood)
  p$w = 4*p$nu*p$y_end/(pi^2*p$r_fen^4*p$y_sin*p$N_fen)  # [Pa*s/m^2] hydraulic resistance of all pores (plasma)
  
  p$lambda = sqrt(p$w/p$W) # [m]
  p$lambda2 = sqrt(p$y_sin^3*p$y_end/(2*pi*p$r_fen^4*p$N_fen)) # [m]
  
  # The two alternative lambda calculations have to give the same result
  if (abs(p$lambda-p$lambda2)>1E-8){
    warning('Lambda calculation failed.')
  }
  return(p)
}


#' Pressure gradient function P(x).
#' 
#' Solutions of the partial differential equations
#' P(x) [mmHg] - pressure in mmHg
#' @export
P_f <- function(x, p){
  # returns pressure in units of Pa, Pb, P0, i.e. Pa
  y <- with(p, 
            (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) + 
              ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda) + P0
  )
  return(y)
}

#' Flow along sinusoid function Q(x).
#' 
#' Solutions of the partial differential equations
#' Q(x) flow along sinusoid in [m^3/s]
#' @export
Q_f <- function(x, p){
  y <- with(p, {
    p_x <- (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) - 
      ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda)
    p_x <- p_x * Pa_per_mmHg # [Pa]
    y <- - 1/sqrt(W*w) * p_x  # [m^3/Pa*s * Pa] = [m^3/s]
  })
  return(y)
}

#' Flow through pores function q(x).
#' 
#' Solutions of the partial differential equations
#' q(x) flow through pores [m^2/s]
#' Volume flow results via scaling with length of capillary element.
#' @export
q_f <- function(x, p){
  y <- with(p, {
    p_x <- (-(Pb-P0) + (Pa-P0)*exp(-L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp( x/lambda) + 
      ( (Pb-P0) - (Pa-P0)*exp( L/lambda))/(exp(-L/lambda)-exp(L/lambda))*exp(-x/lambda)
    p_x <- p_x * Pa_per_mmHg
    y <- 1/w * p_x # [m^2/Pa*s * Pa] = [m^2/s]
  })
  return(y)
}

#' Flow velocity along sinuosoid v_f [m/s].
#' @export
v_f <- function(x, p){
  Q <- Q_f(x,p) # [m^3/s]
  A <- pi*p$y_sin^2
  v <- Q/A
  return(v)
}