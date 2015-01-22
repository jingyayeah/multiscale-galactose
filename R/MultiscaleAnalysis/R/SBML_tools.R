################################################################
## SBML Tools
################################################################
# Functions to read additional information from the SBML file.
# All necessary parameters for calculation should be available 
# in the underlying SBML model of the sinusoidal unit.
# Here functions for the information retrieval from the SBML.
#
# Uses information from the SBML to extend the parameter 
# structure.
#
# author: Matthias Koenig
# date: 2015-01-21
################################################################

##################
# Parameter Sets #
##################

#' Get fixed parameters in the model.
#' 
#' Fixed parameters are all parameters which are listed in 
#' the parameter names from the parameter structure.
#' @param pars parameter structure
#' @param all_ps parameters in model
#' @export
getFixedParameters <- function (pars, all_ps) {
  fixed_ps = setdiff(all_ps, getParameterNames(pars))
}

#' Get parameters which are varied.
#' 
#' @param pars parameter structure
#' @param all_ps parameters in model
#' @export
getVariableParameters <- function (pars, all_ps) {
  fixed_ps = getFixedParameters(pars, all_ps)
  var_ps = setdiff(all_ps, fixed_ps)
}

#######################
# SBML parameter sets #
#######################

#' Load SBML model from file. 
#' @param filename Filename of the SBML file
#' @return SBML model structure
#' @export
loadSBMLModel <- function(filename){
  doc = readSBML(filename);
  errors   = SBMLDocument_getNumErrors(doc);
  SBMLDocument_printErrors(doc);
  model = SBMLDocument_getModel(doc);
}

#' Parameter ids in the sbml model.
#' 
#' Gets all ids from the listOfParameters.
#' @param model SBML model
#' @return character vector of parameter ids
#' @export
getAllSBMLParameterIdsFromModel <- function (model) {
  lofp <- Model_getListOfParameters(model)
  Np <- ListOf_size(lofp)
  model_pids <- character(Np)
  for (kp in seq(0, (Np-1))){  
    p <- ListOfParameters_get(lofp, kp)
    model_pids[kp+1] <- Parameter_getId(p)
  }
  model_pids
}

#' Extend paramter structure with SBML information.
#' 
#' Create extended data frame with the calculated values based
#' on the information from the SBML.
#' The formulas for calculation are hard coded and have to be 
#' updated with the respective model version.
#'@param pars parameter structure
#'@param fixed_ps fixed parameter names
#'@param model SBML model structure
#'@return extended parameter structure
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
  A_dis 	= 	pi*(y_sin+y_end+y_dis)^2 - pi*(y_sin+y_end)^2  # [m^2] 		
  A_sindis 	= 	2*pi*y_sin*x_sin  # [m^2] 		
  A_sinunit =   pi*(y_sin+y_end+y_dis+y_cell)^2 # [m^2]
  Vol_sin 	= 	A_sin*x_sin  # [m^3] 		
  Vol_dis 	= 	A_dis*x_sin  # [m^3] 		
  Vol_cell 	= 	pi*x_cell*( (y_sin+y_end+y_dis+y_cell)^2-(y_sin+y_end+y_dis)^2 )  # [m^3]
  Vol_pp 	= 	Vol_sin  # [m^3] 		
  Vol_pv 	= 	Vol_sin  # [m^3]
  Vol_sinunit 	= 	L*pi*(y_sin+y_end+y_dis+y_cell)^2   # [m^3] 		
  f_sin   =   Vol_sin/(A_sinunit*x_sin)  # [-]
  f_dis 	=   Vol_dis/(A_sinunit*x_sin)  # [-] 		
  f_cell 	= 	Vol_cell/(A_sinunit*x_sin) # [-] 		
  Q_sinunit 	= 	pi*y_sin^2*flow_sin                 # [m^3/sec] 		
  f_fen 	= 	N_fen*pi*(r_fen)^2   # [-] 		
  
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
  X$f_fen = f_fen
  detach(X)
  X
}