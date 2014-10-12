# GAMLSS - Head circumference data
# In this example we demonstrate the use of the gamlss package to constructing centile curves.
# GAMLSS was adopted by the World Health Organization for constructing the world standard child growth curves (see WHO Multicentre Growth Reference Study Group 2006).
rm(list=ls())
library("gamlss")
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
