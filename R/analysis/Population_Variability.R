# population analysis
# create some examples
flowLiver = 1500 # ml/min
volLiver = 1800 # ml
perfusion = flowLiver/volLiver
perfusion

# GEC per volume liver tissue for given perfusion
# function coming from the underlying detailed kinetic model
GEC_per_vol <- function(perfusion){
    GEC = log((perfusion*10 + 1)) # mmol/min/ml(liver)
    return(GEC)
}
