################################################################
# Plot helpers
################################################################
# Convenient functions for consistent plots.
#
# author: Matthias Koenig
# date: 2014-12-06
################################################################

#' Axis labels for given name.
#' 
#' @return list of axis labels.
#' @export
lab = list(age = "Age [years]",
           bodyweight = "Body weight [kg]",
           height = "Height [cm]",
           BSA = "Body surface area (BSA) [m^2]",
           GEC = "GEC [mmol/min]",
           GECkg = "GEC per bodyweight [mmol/min/kg]",
           volLiver = "Liver volume [ml]",
           volLiverkg = "Liver volume per bodyweight [ml/kg]",
           volLiverBSA = "Liver volume per BSA [ml/m^2]",
           flowLiver = "Liver blood flow [ml/min]",
           flowLiverkg = "Liver blood flow per bodyweight [ml/min/kg]",
           perfusion = "Perfusion [ml/min/ml]"
)

#' Axis limits for given name.
#' @return list of axis limits
#' @export
lim = list(age = c(0, 100),
           bodyweight = c(0, 135),
           height = c(0, 220),
           BSA = c(0, 3.1),
           GEC = c(0, 5.0),
           GECkg = c(0, 0.10),
           volLiver = c(0, 3200),
           volLiverkg = c(0, 90),
           volLiverBSA = c(0, 3200),
           flowLiver = c(0, 2800),
           flowLiverkg = c(0, 90),
           perfusion = c(0, 2)
)

#' Adds alpha value to a color.
#' 
#' @param col color
#' @param alpha alpha value between 0 and 1
#' @return color with changed alpha value
#' @export
add.alpha = function(col, alpha=1){
  if(missing(col))
    stop("Please provide a vector of colours.")
  ncol = apply(sapply(col, col2rgb)/255, 2,
               function(x)
                 rgb(x[1], x[2], x[3], alpha=alpha))
  names(ncol) = names(col)
  return(ncol)
}

#' Returns the colors for the different gender settings in data.
#' 
#' @return gender levels and colors
#' @export 
gender.cols = function(){
  levels = c('all', 'male', 'female')
  names(levels) = levels
  
  # symbols = c(21, 22, 23)
  symbols = rep(22, 3)
  names(symbols) = levels
  
  cols.base = c(rgb(0,0,0, alpha=1.0), rgb(0,0,1, alpha=1.0), rgb(1,0,0, alpha=1.0))
  names(cols.base) = levels
  cols = add.alpha(cols.base, 0.5)
  cols.light = add.alpha(cols.base, 0.1)
  
  list(levels=levels, 
       symbols=symbols,
       cols.base=cols.base, 
       cols=cols,
       cols.light=cols.light)
}
