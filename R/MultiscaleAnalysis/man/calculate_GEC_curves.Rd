\name{calculate_GEC_curves}
\alias{calculate_GEC_curves}
\title{Calculate GEC curves for task folder.}
\usage{
calculate_GEC_curves(folder, t_peak = 2000, t_end = 10000,
  factors = c("f_flow", "gal_challenge", "N_fen", "scale_f"), force = FALSE,
  B = 1000)
}
\description{
Integrates over the available simulations and calculates
the individual GEC for the combinations of provided
factors. Folders have the format:
}

