################################################################
# Circos plot of dilution curves
################################################################
# Prepares the dilution data for visualization in circos.
# 
# TODO: visualize Multiple Indicator data
# author: Matthias Koenig
# date: 2014-12-13
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)
out_dir = file.path(ma.settings$dir.results, 'circos')

# Set folder and peak times for analysis
folder <- '2014-12-12_T2'   # Multiple indicator data
t_peak <- 5000               # [s] MID peak start
t_end <- 10000               # [s] simulation time

# Only small subset of simulation is of interest
time = seq(from=t_peak-5, to=t_peak+50, by=0.25) # approximation time for plot

# Select the ids for the approximation matrix
# PP__s, H01__s, H02__s, ..., H20__s, PV__s
compound = 'galM'
ids = c(sprintf('PP__%s', compound), 
        sprintf('H%02i__%s', 1:20, compound),
        sprintf('PV__%s', compound))

# problem that different ids can be used for preprocessing
p <- preprocess_task(folder=folder, ids=ids, force=TRUE, out_name='circos') 

# Process the integration time curves
info <- process_folder_info(folder)
pars <- p$pars

# Variation of background galactose levels for given tracer
f.level = "PP__gal" 
gal_levels <- levels(as.factor(pars[[f.level]]))
cat('Galactose levels: ', gal_levels, '\n')

# subset for visualization
inds = which(pars$f_flow==0.4)
inds
# inds = which(pars$f_flow==0.4 & pars$PP__gal==0.28)


sim_ids = rownames(pars)[inds]

# Create the approximation matrices
time
ids
length(sim_ids)
dlist <- createApproximationMatrix(p$x, ids=ids, simIds=sim_ids, points=time, reverse=FALSE)
dlist
names(dlist)

time

# Create circos karyotype data (simulations as chromosomes)
# chr - hs1 1 0 249250621 chr1
# chr - hs2 2 0 243199373 chr2

f_kary <- file(file.path(out_dir, 'su_karyotype.txt'))
lines <- character(length(sim_ids))
for (k in seq_along(sim_ids)){
  id <- sim_ids[k]
  lines[k] <- sprintf('chr - %s SU%i %i %i grey', id, k, k-1, k)
}
writeLines(lines, f_kary)
close(f_kary)


dlist[[1]]

# Write for every timepoint the PP, Nc (=20) and PV 2D tracks
for (kt in 30:30){
  for (name in names(dlist)){
    cat(name, '\n')
    
    f <- file(file.path(out_dir, sprintf('%s.txt', name)))
    lines <- character(length(sim_ids))
    for (ks in seq_along(sim_ids)){
      id <- sim_ids[ks]
      value = dlist[[name]][kt, id]
      value = max(1E-20, value)
      lines[ks] <- sprintf('%s %i %i %f', id, ks, ks-1, value)
    }
    writeLines(lines, f_kary)
    close(f_kary)  
  }
}
  # The cell files
  
  
  # The PV file
  
  
  m <- matrix(data=NA, nrow=length(ids), ncol=length(sim_ids))
  colnames(m) <- sim_ids
  rownames(m) <- ids
  # fill matrix
  for (ks in seq_along(ids)){
    id <- ids[ks]
    m[ks, ] = dlist[[id]][ks, sim_ids]
  }
  # save
  fname = file.path(out_dir, sprintf('cmat_%03i', kt))
  write.table(m, file=fname, sep=',', quote=FALSE, row.names=TRUE)
}


# Create the circos output matrices for all timepoints
# for (kt in 1:length(time)){  
  m <- matrix(data=NA, nrow=length(ids), ncol=length(sim_ids))
  colnames(m) <- sim_ids
  rownames(m) <- ids
  # fill matrix
  for (ks in seq_along(ids)){
    id <- ids[ks]
    m[ks, ] = dlist[[id]][ks, sim_ids]
  }
  # save
  fname = file.path(out_dir, sprintf('cmat_%03i', kt))
  write.table(m, file=fname, sep=',', quote=FALSE, row.names=TRUE)
}


# Create the CSV file for the species of interest
df <- as.data.frame(p$x[[name]])
df$time <- time


