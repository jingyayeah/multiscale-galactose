# ANOVA
# ONEWAY BETWEEN SUBJECTS ANOVA
# http://ww2.coastal.edu/kingw/statistics/R-tutorials/oneway.html


# The data are from an agricultural experiment in which six different insect sprays were tested in many different fields, and the response variable (DV) was a count of insects found in each field after spraying.
data(InsectSprays)
str(InsectSprays)
attach(InsectSprays)
head(InsectSprays)
tapply(count, spray, mean)
tapply(count, spray, var)
tapply(count, spray, length)

boxplot(count ~ spray)
# Wow! It hurts my eyes just to look at it! The distributions are skewed, there are outliers, and homogeneity is out the window!

oneway.test(count ~ spray)
# By default, the oneway.test( ) applies a Welch correction for nonhomogeneity, so this is not the answer your intro stat students would have gotten if they were doing the problem by hand. If you want to turn off this behavior, set the "var.equal=" option to TRUE. Another caution: The function demands a formula interface, so the data should be in a proper data frame and not in vectors group by group. (But see a further comment on this below.) There is a "data=" option if you don't care to attach the data frame. One more thing... 
