#################################################################################
# Pore Theory
################################################################################
# Analyzing pore theory
#
# author: Matthias Koenig
# date: 2014-11-20
################################################################################




# Steric hindrance
r_pore=75
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

curve(restrictedDiffusionFraction, from=0, to=1.1*r_pore, xlab='radius molecules [nm]')
curve(virtualAreaFraction, from=0, to=1.1*r_pore, lty=2, add=TRUE)
abline(v = r_pore, col='black') # pore radius
abline(v = 3.6, col='orange') # albumin
abline(v = 1.52, col='blue')  # inulin
abline(v = 0.8, col='blue')   # sucrose
abline(v = 0.36, col='blue')  # glucose

