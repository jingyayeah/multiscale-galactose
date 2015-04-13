#---------------------------------------------------------------
# Pressure - Flow - Model
#---------------------------------------------------------------
# Model of pressure and flow dependency in the sinusoidal 
# unit based on Kozlova2000 solutions for filtration and
# reabsorption.
#
# author: Matthias Koenig
# date: 2014-03-05
#---------------------------------------------------------------
rm(list=ls())
library('MultiscaleAnalysis')


# Create standard parameters from SBML model
# TODO: read the necessary parameters from the SBML
p_flow <- koz_parameters()

head(p_flow)
p_new <- koz_derived_parameters(p_flow)

# Figure: Pressure and flow profiles
x <- seq(from=0, to=p_new$L, length.out=51)
par(mfrow=c(2,2))
# pressure along capillary
plot(x, P_f(x, p_new), type='l',
      font.lab=2,
      main='Pressure along capillary',
      xlab='x [m]', ylab='P(x) [mmHg]',
      xlim=c(0,p_new$L), ylim=c(0, p_new$Pa))
abline(h=0)

# flow along capillary
plot(x, Q_f(x, p_new), type='l',
      font.lab=2,
      main='Flow along capillary',
      xlab='x [m]', ylab='Q(x) [m^3/s]',
      xlim=c(0,p_new$L), ylim=c(0,1E-13))
abline(h=0)

# flow through pores
plot(x, q_f(x, p_new), type='l',
      font.lab=2,
      main='Flow through pores',
      xlab='x [m]', ylab='q(x) [m^2/s]',
      xlim=c(0,p_new$L))
abline(h=0)

# blood flow velocity
v = v_f(x, p_new)
plot(x, v, type='l',
     font.lab=2,
     main='flow velocity',
     xlab='x [m]', ylab='v(x) [m/s]',
     xlim=c(0,p_new$L),
     ylim=c(0,1E-3))
abline(h=0)
abline(h=mean(v), lty=2)
par(mfrow=c(1,1))

cat('y_flow = ', mean(v), ' [m/s]\n')
cat('max/mean v_flow = ', max(v)/mean(v), ' [-]\n')

#

# Balancing of the flow decrease (dQ = -q dx) 
# the decrease in flow along the capillary is completely due to the flow through the pores
# of the capillary
# The two lines should be approximately identical.
N = length(x)
plot(x[1:(N-1)], Q_f(x, p_new)[2:N]-Q_f(x, p_new)[1:(N-1)] , type='l',
     font.lab=2,
     main='Flow along capillary',
     xlab='x [m]', ylab='Q(x) [m^3/s]',
     xlim=c(0,p_new$L)) #, ylim=c(-1E12, 1E-12))

lines(x[1:(N-1)], -q_f(x, p_new)[1:(N-1)]*(x[2]-x[1]), type='l', col='blue')
abline(h=0)


#####################################################################
# Sampling from distributions
# load distributions

library(MultiscaleAnalysis)

dir_out <- file.path(ma.settings$dir.base, 'results', 'distributions')
fname <- file.path(dir_out, 'distribution_fit_data.csv')
p.gen <-read.csv(file=fname)
head(p.gen)


Nsample = 1000

# Create parameter samples from the underlying parameter
# distributions
# L, y_sin, y_dis, y_cell
create_parameter_samples <- function(Nsample){
  vnames <- c('L', 'y_sin', 'y_dis', 'y_cell')
  p_set <- list()
  for (name in vnames){
    # cat(name, '\n')
    meanlog <- p.gen[p.gen$name==name, "meanlog"]
    sdlog <- p.gen[p.gen$name==name, "sdlog"]
    
    # scale <- p.gen[name, "scale_fac"]
    y <- rlnorm(Nsample,
                meanlog=meanlog, 
                sdlog=sdlog)
    p_set[[name]] = y
  }
  p_set <- as.data.frame(p_set)
  names(p_set) <- vnames  
  return(p_set)
} 
p_set <- create_parameter_samples(Nsample=Nsample)
str(p_set)

# example histogram
name <- 'L'
hist(p_set[[name]], xlim=c(0, max(p_set[[name]])))

# Create the list of parameters
names(p_flow)
pflow_set <- as.list(rep(NA, Nsample))
for (k in 1:Nsample){
  p_new <- p_flow
  p_new$L <- p_set$L[k]
  p_new$y_sin <- p_set$y_sin[k]
  p_new$y_dis <- p_set$y_dis[k]
  p_new$y_cell <- p_set$y_cell[k]
  p_new <- derived_pars(p_new)
  pflow_set[[k]] <- p_new
}
head(pflow_set, 3)

# Plot the resulting distributions of pressure and flow
# gradients along the sinusoidal units for the given 
# set of parameters.
plot_pressure_flow_distribution <- function(pflow_set, Lmax=1000E-6, Pmax=40, Qmax=1E-13, qmax=2E-10){
  lcol = rgb(0.5,0.5,0.5, 0.5)

  par(mfrow=c(3,1))
  # P(x) ---------------------------------------------------
  plot(numeric(0), numeric(0), type='n',
     font.lab=2,
     main='Pressure along capillary',
     xlab='x [m]', ylab='P(x) [mmHg]',
     xlim=c(0, Lmax), ylim=c(0, Pmax))
  abline(h=0)
  for (k in 1:Nsample){
    p <- pflow_set[[k]]
    x <- seq(from=0, to=p$L, length.out=40)
    lines(x, P_f(x, p), col=lcol)
  }

  # Q(x) ---------------------------------------------------
  plot(numeric(0), numeric(0), type='n',
     font.lab=2,
     main='Flow along capillary',
     xlab='x [m]', ylab='Q(x) [m^3/s]',
     xlim=c(0,Lmax), ylim=c(0, Qmax))
  abline(h=0)
  for (k in 1:Nsample){
    p <- pflow_set[[k]]
    x <- seq(from=0, to=p$L, length.out=40)
    lines(x, Q_f(x, p), col=lcol)
  }

  # q(x) ---------------------------------------------------
  plot(numeric(0), numeric(0), type='n',
     font.lab=2,
     main='Flow through pores',
     xlab='x [m]', ylab='q(x) [m^2/s]',
     xlim=c(0,Lmax), ylim=c(-qmax, qmax))
  abline(h=0)
  for (p in pflow_set){
    x <- seq(from=0, to=p$L, length.out=40)
    lines(x, q_f(x, p), col=lcol)
  }
  par(mfrow=c(1,1))
}
plot_pressure_flow_distribution(pflow_set)

# Figure: flow velocity
v = v_f(x, p_new)
plot(x, v, type='l',
     font.lab=2,
     main='flow velocity',
     xlab='x [m]', ylab='v(x) [m/s]',
     xlim=c(0,p_new$L),
     ylim=c(0,1E-3))
abline(h=0)

curve(v_f, from=0, to=L, font.lab=2,
      main='Flow throw pores',
      xlab='x [m]', ylab='v(x) [m/s]',
      xlim=c(0,L), ylim=c(0,0.004))
abline(h=0)

# and flow velocity histogram based on constant pressure
flow <- rep(NA, Nsample)
for (k in 1:Nsample){
  p <- pflow_set[[k]]
  flow[k] = v_f(0, p)
}
hist(flow, breaks = 20, xlim=c(0, 1.5E-3), ylim=c(0,250), col=rgb(0.5, 0.5, 0.5, 0.5))

# experimental data
flow_exp <- rlnorm(Nsample,
            meanlog=p.gen[p.gen$name=='flow_sin', "meanlog"], 
            sdlog=p.gen[p.gen$name=='flow_sin', "sdlog"])
hist(flow_exp, breaks = 20, add=TRUE, col=rgb(0,0,1,0.5))


###################################################################
# Optimization of Pa distribution
###################################################################
Nsample = 1000

# pressure sample
# Create pressure distribution
# via calculating meanlog and stdlog from the mean and standard deviation
m = 4.40
s = 2.82
Pa <- p_flow$Pb + rlnorm(n=Nsample, meanlog=meanlog(m=m, std=s), sdlog=stdlog(m=m, std=s))
hist(Pa, xlim=c(0, 30), breaks=20)

# parameter sample
p_set <- create_parameter_samples(Nsample=Nsample)

# Create full list of parameters
pflow_set <- as.list(rep(NA, Nsample))
for (k in 1:Nsample){
  p_new <- p_flow
  p_new$Pa <- Pa[k] # set the pressure from the sampled distribution
  p_new$L <- p_set$L[k]
  p_new$y_sin <- p_set$y_sin[k]
  p_new$y_dis <- p_set$y_dis[k]
  p_new$y_cell <- p_set$y_cell[k]
  p_new <- derived_pars(p_new)
  pflow_set[[k]] <- p_new
}
plot_pressure_flow_distribution(pflow_set, Pmax=30, qmax=4E-10)


# flow velocity histogram based on constant pressure
bins <- seq(from=0, to=0.003, length.out=80)

flow <- rep(NA, Nsample)
for (k in 1:Nsample){
  p <- pflow_set[[k]]
  flow[k] = v_f(0, p)
}
hist(flow, breaks=bins, xlim=c(0, 1.5E-3), col=rgb(0.5, 0.5, 0.5, 0.5))

# experimental data
flow_exp <- rlnorm(Nsample,
                   meanlog=p.gen[p.gen$name=='flow_sin', "meanlog"], 
                   sdlog=p.gen[p.gen$name=='flow_sin', "sdlog"])
hist(flow_exp, breaks=bins, add=TRUE, col=rgb(0,0,1,0.5))


################################
# Perform the optimization
################################

f_Pa <- function(m, s, Pb, Nsample){
  Pa <- Pb + rlnorm(n=Nsample, 
                           meanlog=meanlog(m=m, std=s), 
                           sdlog=stdlog(m=m, std=s))
}


f_objective <- function(m, s, Nsample){
  # pressure sample
  Pa <- f_Pa(m, s, Pb=p_flow$Pb, Nsample=Nsample)
  
  # parameter sample
  p_set <- create_parameter_samples(Nsample=Nsample)
  
  # Create full list of parameters
  pflow_set <- as.list(rep(NA, Nsample))
  for (k in 1:Nsample){
    p_new <- p_flow
    p_new$Pa <- Pa[k] # set the pressure from the sampled distribution
    p_new$L <- p_set$L[k]
    p_new$y_sin <- p_set$y_sin[k]
    p_new$y_dis <- p_set$y_dis[k]
    p_new$y_cell <- p_set$y_cell[k]
    p_new <- derived_pars(p_new)
    pflow_set[[k]] <- p_new
  }
  
  # flow velocity histogram based on constant pressure
  max_flow = 0.0015
  bins <- seq(from=0, to=max_flow, length.out=100)
  
  flow <- rep(NA, Nsample)
  for (k in 1:Nsample){
    p <- pflow_set[[k]]
    flow[k] = v_f(0, p)
  }
  h_flow = hist(flow[flow<max_flow], breaks=bins, plot=FALSE)
  
  # experimental data
  flow_exp <- rlnorm(Nsample,
                     meanlog=p.gen[p.gen$name=='flow_sin', "meanlog"], 
                     sdlog=p.gen[p.gen$name=='flow_sin', "sdlog"])
  
  h_flow_exp <- hist(flow_exp[flow_exp<max_flow], breaks=bins, plot=FALSE)

  # ((test$h_flow)$counts - (test$h_flow_exp)$counts)^2
  # density necessary due to possible unequal samples 
  res = sum( (h_flow$density - h_flow_exp$density)^2 )
  return(res)
  
  # return(list(h_flow=h_flow, h_flow_exp=h_flow_exp))
}
res <- f_objective(m=m_start, s=s_start, Nsample=1000)

# do the optimization
# mean and sd start values and bounds
# TODO: do proper fitting with seed function
set.seed(123456)

m_start = 4.40
m_bounds = c(m_start-1.5, m_start+1.5)
s_start = 2.82
s_bounds = c(s_start-1, s_start+1)

Nsample=3000
Nopt_m=20
Nopt_s=20
res = matrix(data=NA, nrow=Nopt_m, ncol=Nopt_s)

m_vals = seq(from=m_bounds[1], to=m_bounds[2], length.out=Nopt_m)
s_vals = seq(from=s_bounds[1], to=s_bounds[2], length.out=Nopt_s)
for (k in 1:Nopt_m){
  for (j in 1:Nopt_s){
    cat(m_vals[k], s_vals[j], '\n')
    res[k,j] = f_objective(m=m_vals[k], s=s_vals[j], Nsample=Nsample)
  }
}
# find the minimum
idxs = which(res == min(res), arr.ind = TRUE)
m_opt <- m_vals[idxs[1]] 
s_opt <- m_vals[idxs[2]]
cat('m_opt =', m_opt, '\n')
cat('s_opt = ', s_opt, '\n')

# Plot the optimization matrix
require(lattice)
res2 <- res
res2[res2>0.5*mean(res2)] = mean(0.5*res2)
levelplot(res2)

library(ggplot2)
library(reshape)
res.m <- melt(res2)

ggplot(res.m, aes(X1, X2, fill = value)) + geom_tile() + 
  scale_fill_gradient(low = "blue",  high = "white")



