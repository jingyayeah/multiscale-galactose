# Additional data information used for plots and analysis
# main purpose for automatically generating the images
# for the various xname, yname combinations of available data

# Axis labels
lab <- list()
lab$age <- "Age [years]"
lab$bodyweight <- "Body weight [kg]"
lab$height <- "Height [cm]"
lab$BSA <- "Body surface area (BSA) [m^2]"
lab$GEC <- "GEC [mmol/min]"
lab$GECkg <- "GEC per bodyweight [mmol/min/kg]"
lab$volLiver <- "Liver volume [ml]"
lab$volLiverkg <- "Liver volume per bodyweight [ml/kg]"
lab$flowLiver <- "Liver blood flow [ml/min]"
lab$flowLiverkg <- "Liver blood flow per bodyweight [ml/min/kg]"
lab$Perfusion <- "Perfusion [ml/min/ml]"

# Axis limits
lim <- list()
lim$age <- c(0, 95)
lim$bodyweight <- c(0, 150)
lim$height <- c(0, 220)
lim$BSA <- c(0, 3.1)
lim$GEC <- c(0, 5.0)
lim$GECkg <- c(0, 0.10)
lim$volLiver <- c(0, 3200)
lim$volLiverkg <- c(0, 30)
lim$flowLiver <- c(0, 2800)
lim$flowLiverkg <- c(0, 40)
lim$perfusion <- c(0, 2)