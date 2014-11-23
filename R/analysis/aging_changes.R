#################################################################################
# Aging changes
################################################################################
# Analyzing changes in aging.
#
# author: Matthias Koenig
# date: 2014-11-23
################################################################################

# Generate the function for aging depending on the data
# fold: changes old/young, with old(60) and young(20)
# endothelial thickness
y_end_fold <- 1.75
# fenestration density per area
N_fen_fold <- 0.25
# fenestration pore radius
r_fen_fold <- 1
# porosity
f_fen_fold = N_fen_fold*r_fen_fold^2

# Diffusion changes
y_dis = 1.2
y_end = 0.165
D_fold = f_fen_fold * (y_dis+y_end)/(y_dis+y_end*y_end_fold) 
D_fold


# generate a function against age
r_fen_age <- function(age){
 return( rep(1,length(age)) ) 
}
r_fen_age <- function(age){
  return( rep(1,length(age)) ) 
}


f_age <- function(age, x1, y1, x2, y2, fk=0.7, n=4){
  # n Hill coefficient
  # fy2: change fraction of total change
  
  # calculate k
  # k = x1 -(x2-x1) + (x2-x1)/(fk^(1/n))
  k = x2
  cat('k=', k, '\n')
  
  f <- function(age){
    #res = 1 + 1/fk* ( (age-x1)/ ((age-x1)+k))^n
    
    # res = ( (age-x1)/ ((age-x1)+k) )^n
    # res = 1+ 1/fk*( (age-x1)/(age-x1+k) )^n
    res = 1+ ( (age-x1)^n/( (age-x1)^n+k^n) )
    # res[age<=x1] <- 1
    return(res)
  }
  
  return( f ) 
}

f_y_end <- function(age){
  f <- f_age(age, x1=20, y1=1, x2=60, y2=1.75)
  return( f(age) )
}
f_y_end(age=1)
curve(f_y_end, from=0, to=200)
points(c(20,60), c(1,1.75))



plot(numeric(0), numeric(0), type='n', xlim=c(0, 100), ylim=c(0,2), 
     xlab='age [years]', ylab='fractional change', main='Change in aging', font.lab=2)
curve(r_fen_age, from=0, to=100, add=TRUE, lty=2)
legend(x='topright', legend=c('r_fen - fenestration radius'), lty=c(2))
points( c(20,60), c(1,y_end_fold) )
