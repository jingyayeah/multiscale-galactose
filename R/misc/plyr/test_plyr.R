# The PLYR package is a tool for doing split-apply-combine (SAC) procedures.
# plyr test
library('plyr')


set.seed(1)
d <- data.frame(year=rep(2000:2002, each=3), count=round(runif(9,0,20)))
print(d)

f <- function(x) {
    mean.count <- mean(x$count)
    sd.count <- sd(x$count)
    cv <- sd.count/mean.count
    data.frame(cv.count = cv)
}

ddply(d, "year", f)

## transform, summarize and mutate
# summarize creates new condensed data.frame
ddply(d, "year", summarise, mean.count = mean(count))

# transform (adds information to original data.frame)
ddply(d, "year", transform, total.count = sum(count), mean.count=mean(count))

# mutate
ddply(d, "year", mutate, mu = mean(count), sigma = sd(count),
      cv = sigma/mu)

# plotting with plyr
par(mfrow = c(1, 3), mar = c(2, 2, 1, 1), oma = c(3, 3, 0, 0))
d_ply(d, "year", transform, plot(count, main = unique(year), type = "o"))
mtext("count", side = 1, outer = TRUE, line = 1)
mtext("frequency", side = 2, outer = TRUE, line = 1)


# nested chunking of data
# do the things for multiple factor dimensions
baseball.dat <- subset(baseball, year > 2000) # data from the plyr package
d2 <- ddply(baseball.dat, c("year", "team"), summarize, homeruns = sum(hr))
head(d2)
