# alternative between base and lattice packages
# implementation of: Grammar of Graphics (Leland Wilkinson)
# https://www.youtube.com/watch?v=HeqHMM4ziXA
# https://www.youtube.com/watch?v=n8kYa9vu1l8

install.packages('ggplot2')
library('ggplot2')
# qplot very similar to plot
# - data always comes from data frame
# - plots are made of aesthetics and geoms

# factors specify subsets and should be properly labeled
str(mpg)
qplot(displ, hwy, data=mpg)
# modifying aesthetics
qplot(displ, hwy, data=mpg, color=drv)

# adding a geom (smoother)
# points and the smoother
qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))

# histograms
qplot(hwy, data=mpg, fill=drv)

# facets (like panels)
qplot(displ, hwy, data=mpg, facets= .~drv)
qplot(hwy, data=mpg, facets= drv~., binwidth=2)

## ggplot2 ##
# basic compontents
# data frame
# aestetic mappings
# geoms: geometric objects
# facets: conditional plots
# stats: statistical transformation
# scales: scale of aestetic map
# coordinate system

# plot by layers
# - plot the data
# - overlay a summary
# - metadata and annotation
head(mpg)

g <- ggplot(mpg, aes(displ, hwy))
summary(g)

p <- g + geom_point()
print(p)
g + geom_point()
# adding additional layers (smoother loess or lm, ...)
g + geom_point() + geom_smooth(method='lm')

# adding the facets
g + geom_point(color="steelblue", size=4, alpha=1/2) + geom_smooth(method='lm') + facet_grid(drv~.)

g + geom_point(aes(color=drv), size=4, alpha=1/2) + geom_smooth(method='lm') + labs(title = "MAACS Cohort") + labs(x='Nocturnal Symptoms')

g + geom_point(color="steelblue", size=4, alpha=1/2) + geom_smooth(method='lm') + theme_bw()

# Annotation
# labels xlab, ylab, labs, ggtitle

# set axis limits with
g + geom_point(color="steelblue", size=4, alpha=1/2) + geom_smooth(method='lm') + theme_bw() + coord_cartesian(ylim=c(15, 35))

# make categories with cut()
# cutpoints <- quantile()

# https://www.youtube.com/watch?v=efmuwtFNlME
install.packages('gcookbook')