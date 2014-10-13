# GAMLSS - Head circumference data
# In this example we demonstrate the use of the gamlss package to constructing centile curves.
# GAMLSS was adopted by the World Health Organization for constructing the world standard child growth curves (see WHO Multicentre Growth Reference Study Group 2006).
rm(list=ls())
library("gamlss")

#########################
# Simple GAMLSS example #  
#########################
# http://www.gamlss.org/?page_id=1094
# introduction to gamless package
# http://www.book.gamlss.org/GAMLSS-In_R.html
data('abdom')
plot(y ~ x, data = abdom, col = "blue", xlab = "age", ylab = "circumference")
# To fit a normal distribution to the data with the mean of \( Y \) modelled as a cubic polynomial in x, i.e. poly(x,3), use
abd0 <- gamlss(y ~ poly(x,3), data=abdom, family=NO)
summary(abd0)

# alternative formulation via I()
abd00 <- gamlss(y ~ x + I(x^2) + I(x^3), data = abdom, family = NO)

# Model abd0 is a linear parametric GAMLSS model. In order to fit a semi-parametric model in age using a non-parametric smoothing cubic spline with 3 effective degrees of freedom on top of the constant and linear terms use
abd1 <- gamlss(y ~ cs(x, df=3), data=abdom, family=NO)
plot(abd1)
summary(abd1)

# The total degrees of freedom used for the above model abd1 is six, i.e. 5 for mu the mean, and 1 for the constant scale parameter sigma the standard deviation of the fitted normal distribution model.

# Fitted values of the parameters of the object can be obtained using the fitted() function. For example plot(x, fitted(abd1,“mu”)) will plot the fitted values of mu against x. The constant estimated scale parameter (the standard deviation of the normal in this case) can be obtained: 
fitted(abd1, "sigma")[1]

# where [1] indicates the first value of the vector. The same values can be obtained using the more general function predict():
predict(abd1, what = "sigma", type = "response")[1]

# To model both the mean, mu, and the scale parameter, sigma, as non-parametric smoothing cubic spline functions of x (with a normal distribution for the response \( Y \)) use:
abd2 <- gamlss(y ~ cs(x,3), sigma.formula= ~cs(x,3), data=abdom, family=NO)
plot(abd2)
# ote that the plot() function does not produce additive term plots [as it does for example in the gam() function of the package mgcv] in R. The function which does this in the gamlss package is term.plot()
term.plot(abd2, se=TRUE, partial=TRUE)

# A worm plot of the residuals, see van Buuren and Fredriks (2001), \nocite{vanBuurenFredriks01} can be obtained by using the wp() function:
wp(abd2)
wp(abd2, ylim.all=1.5)

#The default worm plot above is a detrended normal Q-Q plot of the residuals, and indicates a possible inadequacy in modelling the distribution, since some points plotted lie outside the (dotted) confidence bands.

# In model abd2 we fitted a smoothing function for both the \( \mu \) and \( \sigma \) parameter by fixing extra the degrees of freedom for smoothing to be equal to three. This will gives 5 degrees for freedom for both \( \mu \) and \( \sigma \). The function pb() allows the smoothing parameters (and therefore the degrees of freedoms) to be estimated automatically within the GAMLSS algorithm.

# Effective degree of freedom
abd3 <- gamlss(y ~ pb(x), sigma.formula=~pb(x), data=abdom, family=NO)
edfAll(abd3)

# The estimated total degrees of freedom for smoothing are $ 5.679$ and $ 2.0025$ for \( \mu \) and \( \sigma \) respectively. The locally estimated degrees of freedom for \( \mu \) are a bit higher than the fixed degrees of freedom used for models abd1 and abd2. The \( \sigma \) degrees of freedom are almost 2 indicating that we only need a linear model for \( x \), that is the model with sigma.formula = \( \sim \) x.

# If you wish to use loess curves, see \Cleveland and Devlin (1988), instead of cubic or penalised splines use:
abd4 <- gamlss(y ~ lo(~x, span = 0.4), sigma.fo = ~lo(~x, span = 0.4), data = abdom, family = NO)

# If you wish to use a different distribution instead of the normal, use the option family of the function gamlss. For example to fit a t-distribution to the data use:
abd5 <- gamlss(y ~ pb(x), sigma.formula = ~pb(x), data = abdom, family = TF)
# A list of the different continuous distributions implemented in the package gamlss() is given in thereference card. The details of all the distributions currently available in gamlss() are given in the book “The Distribution Toolbox of GAMLSS”. Chapter 4 of the GAMLSS manual, Stasinopoulos et al., (2008), describes how the user can set up their own distribution in gamlss().

# Different models can be compared using their global deviances, \( GD=-2 \hat{\ell} \), (if they are nested) or using a generalised Akaike information criterion, \( GAIC=-2\hat{\ell}+ (k.df) \), where \( \hat{\ell}=\sum_{i=1}^{n} \log f(y_i|\hat{\mu}_i, \hat{\sigma}_i, \hat{\nu}_i,\hat{\tau}_i) \) is the fitted log-likelihood function and \( k \) is a required penalty, e.g. \( k=2 \) for the usual Akaike information criterion or \( k=log(n) \) for the Schwartz Bayesian criterion. The function deviance() provides the global deviance of the model. Note that the GAMLSS global deviance is different from the deviance that is provided by the functions glm() and gam() in \R{}. The global deviance is exactly minus twice the fitted log likelihood function, including all constant terms in the log-likelihood. The glm() deviance is calculated as a deviation from the saturated model and it does not include 'constant' terms (which do not depend on the mean of distribution but depend in scale parameter) in the fitted log likelihood and so cannot be used to compare different distributions. To obtain the generalised Akaike information criterion use the functions AIC() or GAIC(). The functions are identical. For example to compare the models abd1, abd2 and abd3 use:
GAIC(abd1, abd2, abd3, abd4, abd5)


###################################
# Centile estimation using GAMLSS #
###################################
data("db")
head(db)
with(db, plot(age, head, col='grey'))
# example optimizes the degree of freedoms for smoothing
mod1 <- quote(gamlss(head~cs(nage, df = p[1]), sigma.fo = ~cs(nage, p[2]),
                     + nu.fo = ~cs(nage, p[3], c.spar=c(-1.5,2.5)),
                     + tau.fo = ~cs(nage, p[4], c.spar=c(-1.5,2.5)),
                     + data = db, family = BCT,
                     + control = gamlss.control(trace=FALSE)))
op <- find.hyper(model=mod1, other=quote(nage<-age^p[5]),
                 + par = c(10,2,2,2,0.25),
                 + lower = c(0.1,0.1,0.1,0.1,0.001),
                 + steps = c(0.1,0.1,0.1,0.1,0.2),
                 + factr = 2e9, parscale=c(1,1,1,1,0.035), penalty=2 )

# Here for comparison we select the hyperparameters using a validation data set. The data is split into 60% training and 40% validation data. For each specic set of hyperparameters, model (10) is ftted to the training data and the resulting validation global deviance VGD = 􀀀2^`v where ^`v is the log-likelihood of the validation data given the ftted training data model. The VGD is then minimized over the hyperparameters using the numeric optimization function optim().
library('gamlss')
data('db')
set.seed(101)
rand <- sample(2, length(db$head), replace=T, prob=c(0.6, 0.4))
table(rand)/length(db$head)
dbp <- db
dbp$agepower <- db$age^0.33
mBCT<- gamlss(head~cs(agepower,df=10.3), sigma.fo=~cs(agepower,df=3.7),
              nu.fo=~agepower, tau.fo=~agepower, family=BCT, data=dbp)
mu.s <- fitted(mBCT, "mu")[rand==1]
sigma.s <- fitted(mBCT, "sigma")[rand==1]
nu.s <- fitted(mBCT, "nu")[rand==1]
tau.s <- fitted(mBCT, "tau")[rand==1]

# some optimization
fnBCT <- function(p) {
  db$agepower <- db$age^p[1]
  vgd <- VGD(head~cs(agepower,df=p[2],c.spar=list(-1.5, 2.5)),
             sigma.fo=~cs(agepower,df=p[3],c.spar=list(-1.5, 2.5)),
             nu.fo=~agepower, tau.fo=~agepower,
               + family=BCT, data=db, rand=rand, mu.start=mu.s,
               + sigma.start=sigma.s, nu.start=nu.s, tau.start=tau.s)
  + cat("p=", p, " and vgd=", vgd, "\n")
  + vgd }
op <- optim(par=c(.33, 12, 5.7), fnBCT, method="L-BFGS-B",
               + lower=c(.01,1,1), upper=c(.5, 20, 20))


# Below we t this model chosen by minimizing VGD to the full data
# set (i.e., training and validation data combined).
db$agepower <- db$age^0.28
mBCT <- gamlss(head~cs(agepower,df=13.77), sigma.fo=~cs(agepower,df=6.05),
                  nu.fo=~agepower, tau.fo=~agepower, family=BCT, data=db)
centiles(mBCT,  xvar=db$agepower)
# show the fitted values of mu, sigma, nu, tau
fittedPlot(mBCT, x=db$age)

mBCCG.test <- gamlss(head~cs(agepower,df=14), family=BCCG, data=db)
mBCCG.test2 <- gamlss(head~cs(agepower,df=14), sigma.fo=~cs(agepower, df=3), family=BCCG, data=db)

centiles(mBCCG.test,  xvar=db$agepower)
fittedPlot(mBCCG.test, x=db$age)
fittedPlot(mBCCG.test2, x=db$age)
summary(mBCCG.test)
summary(mBCCG.test2)

AIC(mBCCG.test, mBCCG.test2)
# residuals and diagnostics
plot(mBCCG.test, xvar=db$age)
plot(mBCCG.test2, xvar=db$age)

# worm plots for analysis
a<- wp(mBCT, xvar = db$age, n.inter = 20, ylim.worm = 0.6, cex = 0.3, pch = 20)
# here some additional testing

centiles.split(mBCT, xvar = db$age, c(2.5), ylab = "HEAD", xlab = "AGE", bg= "transparent")
centiles(mBCT, xvar=db$age)

# calculation of the quantiles via
newcall <- call(qfun, var/100, 
                mu = fitted(obj, "mu")[order(xvar)], 
                sigma = fitted(obj, "sigma")[order(xvar)], 
                nu = fitted(obj, "nu")[order(xvar)], 
                tau = fitted(obj, "tau")[order(xvar)])
# The function BCCG defines the Box-Cox Cole and Green distribution (Box-Cox normal), a three parameter distribution, for a gamlss.family object to be used in GAMLSS fitting using the function gamlss(). The functions dBCCG, pBCCG, qBCCG and rBCCG define the density, distribution function, quantile function and random generation for the specific parameterization of the Box-Cox Cole and Green distribution.
qBCCG()
