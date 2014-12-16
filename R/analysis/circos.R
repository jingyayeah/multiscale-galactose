################################################################
# Circos plot of dilution curves
################################################################
# Prepares the dilution data for visualization in circos.
# 
# The preprocess matrices are generated here and saved for analysis
# with python & circos.
#
# author: Matthias Koenig
# date: 2014-12-13
################################################################
rm(list=ls())
library('MultiscaleAnalysis')
setwd(ma.settings$dir.base)
dir_out = 

# Folder and peak times for analysis
folder <- '2014-12-12_T2'   # Multiple indicator data
t_peak <- 5000               # [s] MID peak start
t_end <- 10000               # [s] simulation time
info <- process_folder_info(folder)
pars <- loadParameterFile(info$parsfile)


time = seq(from=t_peak-5, to=t_peak+50, by=0.25) # approximation time for plot
compound = 'galM'
dir_out = file.path(ma.settings$dir.results, 'circos', info$task)
dir.create(dir_out, showWarnings = FALSE)
cat(dir_out, '\n')

# Subset of data to visualize
f.level = "PP__gal" 
gal_levels <- levels(as.factor(pars[[f.level]]))
head(pars)
cat('Galactose levels: ', gal_levels, '\n')

# subset for visualization
inds = which(pars$f_flow==0.4)
inds
# inds = which(pars$f_flow==0.4 & pars$PP__gal==0.28)
sim_ids = rownames(pars)[inds]


create_circos_matrices <- function(compound, time, dir_out, Nc=20){
  # Select the ids for the approximation matrix
  # PP__s, H01__s, H02__s, ..., H20__s, PV__s
  ids = c(sprintf('PP__%s', compound), 
          sprintf('H%02i__%s', 1:Nc, compound),
          sprintf('S%02i__%s', 1:Nc, compound),
          sprintf('PV__%s', compound))  
  
  # Preprocess the data
  p <- preprocess_task(folder=folder, ids=ids, force=FALSE, out_name=sprintf('circos_%s', compound)) 
  
  # Create the approximation matrices
  dlist <- createApproximationMatrix(p$x, ids=ids, simIds=sim_ids, points=time, reverse=FALSE)
  names(dlist)
  
  # Create the circos output matrices for all timepoints
  max.value <- -1
  for (kt in 1:length(time)){  
    m <- matrix(data=NA, nrow=length(ids), ncol=length(sim_ids))
    colnames(m) <- sim_ids
    rownames(m) <- ids
    # fill matrix
    for (ks in seq_along(ids)){
      id <- ids[ks]
      m[ks, ] = dlist[[id]][kt,sim_ids]
    }

    # maximal value
    max.tmp = max(m)
    if (max.tmp > max.value){
      max.value <- max.tmp
    }
    
    # save
    fname = file.path(dir_out, sprintf('cmat_%i.csv', kt))
    cat(fname, '\n')
    write.table(m, file=fname, sep=',', quote=FALSE, row.names=TRUE)
  }  
  # save the time
  write.table(time-t_peak, file=file.path(dir_out, '_time'), sep=',', quote=FALSE, row.names=TRUE)
  # save max
  write.table(max.value, file=file.path(dir_out, '_max'), sep=',', quote=FALSE, row.names=TRUE) 
}
create_circos_matrices(compound, time, dir_out)


# Create circos karyotype data (simulations as chromosomes)
# chr - hs1 1 0 249250621 chr1
# chr - hs2 2 0 243199373 chr2
f_kary <- file(file.path(dir_out, 'su_karyotype.txt'))
lines <- character(length(sim_ids))
for (k in seq_along(sim_ids)){
  id <- sim_ids[k]
  lines[k] <- sprintf('chr - %s SU%i %i %i grey', id, k, k-1, k)
}
writeLines(lines, f_kary)
close(f_kary)



