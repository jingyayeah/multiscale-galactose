#' Parameters which are fixed in the model
#' @param pars parameter structure
#' @param all_ps parameters in model
#' @export
getFixedParameters <- function (pars, all_ps) {
  fixed_ps = setdiff(all_ps, getParameterNames(pars))
}

#' All parameters which are varied, i.e. depend on sample
#' @param pars parameter structure
#' @param all_ps parameters in model
#' @export
getVariableParameters <- function (pars, all_ps) {
  fixed_ps = getFixedParameters(pars, all_ps)
  var_ps = setdiff(all_ps, fixed_ps)
}

#' Load the model from the SBML file. 
#' @param filename Filename of the SBML file
#' @export
loadSBMLModel <- function(filename){
  doc        = readSBML(filename);
  errors   = SBMLDocument_getNumErrors(doc);
  SBMLDocument_printErrors(doc);
  model = SBMLDocument_getModel(doc);
}

#' Parameter ids in the sbml model
#' @param filename SBML filename
#' @export
getAllSBMLParameterIdsFromModel <- function (model) {
  # Get all parameter names from model
  lofp <- Model_getListOfParameters(model)
  Np <- ListOf_size(lofp)
  model_pids <- character(Np)
  for (kp in seq(0, (Np-1))){  
    p <- ListOfParameters_get(lofp, kp)
    model_pids[kp+1] <- Parameter_getId(p)
  }
  model_pids
}


#' Create extended data frame with the calculated values
#'@param pars parameter structure
#'@export
extendParameterStructure <- function(pars, fixed_ps, model){
  X <- pars
  Nsim <- nrow(pars)
  
  # the fixed parameters in model
  model_pids <- getAllSBMLParameterIdsFromModel(model)
  for (pid in fixed_ps){
    if (pid %in% model_pids){
      p <- Model_getParameter(model, pid)
      value <- Parameter_getValue(p)
      # create a variable with the name
      X[[pid]] <- rep(value, Nsim)
    } else {
      cat('parameter not in model:', pid, '\n')    
    }
  }
  
  attach(X)   	
  x_cell 	= 	L/Nc  # [m]
  x_sin 	= 	x_cell  # [m]
  A_sin 	= 	pi*y_sin^2  # [m^2] 		
  A_dis 	= 	pi*(y_sin+y_dis)^2-A_sin  # [m^2] 		
  A_sindis 	= 	2*pi*y_sin*x_sin  # [m^2] 		
  Vol_sin 	= 	A_sin*x_sin  # [m^3] 		
  Vol_dis 	= 	A_dis*x_sin  # [m^3] 		
  Vol_cell 	= 	pi*(y_sin+y_dis+y_cell)^2*x_cell-pi*(y_sin+y_dis)^2*x_cell  # [m^3]
  Vol_pp 	= 	Vol_sin  # [m^3] 		
  Vol_pv 	= 	Vol_sin  # [m^3]
  f_sin   = 	Vol_sin/(Vol_sin+Vol_dis+Vol_cell)  # [-]
  f_dis 	= 	Vol_dis/(Vol_sin+Vol_dis+Vol_cell)  # [-] 		
  f_cell 	= 	Vol_cell/(Vol_sin+Vol_dis+Vol_cell) # [-] 		
  Vol_sinunit 	= 	L*pi*(y_sin+y_dis+y_cell)^2   # [m^3] 		
  Q_sinunit 	= 	A_sin*flow_sin                  # [m^3/sec] 		
  m_liv 	= 	rho_liv*Vol_liv   # [kg] 		
  q_liv 	= 	Q_liv/m_liv       # [m^3/sec/kg]
  
  X$x_cell = x_cell
  X$x_sin = x_sin
  X$A_sin = A_sin
  X$A_dis = A_dis
  X$A_sindis = A_sindis
  X$Vol_sin = Vol_sin
  X$Vol_dis = Vol_dis
  X$Vol_cell = Vol_cell
  X$Vol_pp = Vol_pp 		
  X$Vol_pv = Vol_pv
  X$f_sin = f_sin
  X$f_dis = f_dis
  X$f_cell = f_cell
  X$Vol_sinunit = Vol_sinunit
  X$Q_sinunit = Q_sinunit
  X$m_liv = m_liv
  X$q_liv = q_liv
  detach(X)
  X
}