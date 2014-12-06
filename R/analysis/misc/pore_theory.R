#################################################################################
# Pore Theory
################################################################################
# Analyzing pore theory
#
# author: Matthias Koenig
# date: 2014-11-20
################################################################################
# Steric hindrance
r_pore=53.5
virtualAreaFraction <- function(a, r=r_pore){
    a[a>r] <- r   # it larger nothing is going through
    return( (1-a/r)^2 )
}

# full equation for restricted diffusion of spherical molecules through cylindrical
# pores (steric hindrance & viscous drag)
restrictedDiffusionFraction <- function(a, r=r_pore){
    a[a>r] <- r   # it larger nothing is going through
    return( (1-a/r)^2/(1+2.4*a/r) )
}

# full equation for restricted diffusion of spherical molecules through cylindrical
# pores (steric hindrance & viscous drag)
restrictedDiffusionRenkin <- function(a, r=r_pore){
  a[a>r] <- r   # it larger nothing is going through
  return( (1-a/r)^2 * (1-2.104*(a/r)+2.09*(a/r)^3-0.95*(a/r)^5) )
}

curve(restrictedDiffusionFraction, from=0, to=1.1*r_pore, lty=2, 
      xlab='radius molecules [nm]', ylab='D_res/D', main=sprintf('Pore radius r= %s nm', r_pore), font.lab=2)
curve(virtualAreaFraction, from=0, to=1.1*r_pore, lty=3, add=TRUE)
curve(restrictedDiffusionRenkin, from=0, to=1.1*r_pore, lty=1, add=TRUE)
abline(v = r_pore, col='black') # pore radius
abline(v = 3.6, col='orange') # albumin
abline(v = 1.52, col='blue')  # inulin
abline(v = 0.8, col='gray')   # sucrose
abline(v = 0.36, col='red')  # galactose
legend(x='topright',legend=c('virtualArea', 'restricted diffusion', 'restricted diffusion Renkin', 'albumin', 'inulin', 'sucrose', 'galactose'), lty=c(2,3,1,1,1,1,1), col=c('black','black','black','orange', 'blue', 'gray', 'red')) 

