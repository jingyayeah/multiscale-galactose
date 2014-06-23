# introduction to ggplot
# http://rstudio-pubs-static.s3.amazonaws.com/2176_75884214fc524dc0bc2a140573da38bb.html

install.packages('ggplot2')
install.packages('reshape')


library('ggplot2')
head(diamonds)
# these are equivalent: qplot(diamonds$carat, diamonds$price,
# data=diamonds) qplot(x=carat, y=price, data=diamonds)
qplot(carat, price, data = diamonds)
qplot(carat, price, data = diamonds, colour = clarity)

qplot(carat, price, data = diamonds, colour = clarity, alpha = I(1/2))


cat("\nheight weight health\n1  0.6008 0.3355  1.280\n2  0.9440 0.6890  1.208\n3  0.6150 0.6980  1.036\n4  1.2340 0.7617  1.395\n5  0.7870 0.8910  0.912\n6  0.9150 0.9330  1.175\n7  1.0490 0.9430  1.237\n8  1.1840 1.0060  1.048\n9  0.7370 1.0200  1.003\n10 1.0770 1.2150  0.943\n11 1.1280 1.2230  0.912\n12 1.5000 1.2360  1.311\n13 1.5310 1.3530  1.411\n14 1.1500 1.3770  0.603\n15 1.9340 2.0734  1.073 ", 
    file = "height_weight.dat")
hw <- read.table("height_weight.dat", header = T)
head(hw)
qplot(x = weight, y = health, data = hw, size = height, colour = I("steelblue"))

# plot with linear regression and confidence intervals
qplot(x = weight, y = health, data = hw) + geom_smooth(method = lm)

fit <- lm(health ~ weight, data = hw)
hii <- hatvalues(fit)  #leverages
res <- fit$res  #residuals

qplot(x = weight, y = health, data = hw, size = hii, colour = abs(res)) + geom_abline(intercept = fit$coeff[1], 
                                                                                      slope = fit$coeff[2])  #regression line