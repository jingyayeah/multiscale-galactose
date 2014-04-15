pkgname <- "MultiscaleAnalysis"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('MultiscaleAnalysis')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("MultiscaleAnalysis-package")
### * MultiscaleAnalysis-package

flush(stderr()); flush(stdout())

### Name: MultiscaleAnalysis-package
### Title: What the package does (short line) ~~ package title ~~
### Aliases: MultiscaleAnalysis-package MultiscaleAnalysis
### Keywords: package

### ** Examples

~~ simple examples of the most important functions ~~



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
