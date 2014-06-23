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
