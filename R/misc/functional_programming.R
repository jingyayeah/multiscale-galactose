# Advanced R functional programming
######################################
# http://adv-r.had.co.nz/Functional-programming.html
install.packages("pryr")
library("pryr")

# Generate a sample dataset
set.seed(1014)
df <- data.frame(replicate(6, sample(c(1:10, -99), 6, rep = TRUE)))
names(df) <- letters[1:6]
df

fix_missing <- function(x) {
  x[x == -99] <- NA
  x
}
# lapply(), knows how to do something to each column in a data frame.
# lapply() is called a functional, because it takes a function as an argument. 
df[] <- lapply(df, fix_missing)
df

# Closures allow to make functions based on a template
missing_fixer <- function(na_value) {
  function(x) {
    x[x == na_value] <- NA
    x
  }
}
fix_missing_99 <- missing_fixer(-99)
fix_missing_999 <- missing_fixer(-999)

# To remove this source of duplication, you can take advantage of another 
# functional programming technique: storing functions in lists.
summary <- function(x) {
  funs <- c(mean, median, sd, mad, IQR)
  lapply(funs, function(f) f(x, na.rm = TRUE))
}

# You use an anonymous function when it’s not worth the effort to give it a name

# Like all functions in R, anonymous functions have formals(), a body(), and a parent environment():
formals(function(x = 4) g(x) + h(x))
body(function(x = 4) g(x) + h(x))
environment(function(x = 4) g(x) + h(x))

# So this anonymous function syntax
(function(x) x + 3)(10)
f <- function(x) x + 3
f(10)

# “An object is data with functions. A closure is a function with data.” — John D. Cook
# One use of anonymous functions is to create small functions that are not worth naming. Another important use is to create closures, functions written by functions. Closures get their name because they enclose the environment of the parent function and can access all its variables. This is useful because it allows us to have two levels of parameters: a parent level that controls operation and a child level that does the work. 

power <- function(exponent) {
  function(x) {
    x ^ exponent
  }
}
square <- power(2)
cube <- power(3)
# That’s because the function itself doesn’t change. The difference is the enclosing environment, environment(square). One way to see the contents of the environment is to convert it to a list:
  
as.list(environment(square))
#> $exponent
#> [1] 2
as.list(environment(cube))
#> $exponent
#> [1] 3

# Another way to see what’s going on is to use pryr::unenclose(). This function replaces variables defined in the enclosing environment with their values:
  
library(pryr)
unenclose(square)
#> function (x) 
#> {
#>     x^2
#> }
unenclose(cube)
#> function (x) 
#> {
#>     x^3
#> }
