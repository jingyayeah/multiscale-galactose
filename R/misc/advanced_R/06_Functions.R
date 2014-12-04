##############################################################################
## Functions
# http://adv-r.had.co.nz/Functions.html
##############################################################################
# The only package you’ll need is pryr, which is used to explore what happens when modifying vectors in place. Install it with install.packages("pryr").
# install.packages('pryr')
library('plyr')

# Function components
# All R functions have three parts:
# - the body(), the code inside the function.
# - the formals(), the list of arguments which controls how you can call the function.
# - the environment(), the “map” of the location of the function’s variables.
# When you print a function in R, it shows you these three important components. If the environment isn’t displayed, it means that the function was created in the global environment. 

f <- function(x) x^2
f
#> function(x) x^2
formals(f)
#> $x
body(f)
#> x^2
environment(f)
#> <environment: R_GlobalEnv>

# Like all objects in R, functions can also possess any number of additional attributes(). One attribute used by base R is “srcref”, short for source reference, which points to the source code used to create the function. Unlike body(), this contains code comments and other formatting. You can also add attributes to a function. For example, you can set the class() and add a custom print() method. 

# Primitive functions
# There is one exception to the rule that functions have three components. Primitive functions, like sum(), call C code directly with .Primitive() and contain no R code. Therefore their formals(), body(), and environment() are all NULL:
  
sum
#> function (..., na.rm = FALSE)  .Primitive("sum")
formals(sum)
#> NULL
body(sum)
#> NULL
environment(sum)
#> NULL

# Primitive functions are only found in the base package, and since they operate at a low level, they can be more efficient (primitive replacement functions don’t have to make copies), and can have different rules for argument matching (e.g., switch and call). This, however, comes at a cost of behaving differently from all other functions in R. Hence the R core team generally avoids creating them unless there is no other option.

## Lexical scoping
# Scoping is the set of rules that govern how R looks up the value of a symbol. In the example below, scoping is the set of rules that R applies to go from the symbol x to its value 10:
x <- 10
x
#> [1] 10

# Understanding scoping allows you to:
# -build tools by composing functions, as described in functional programming.
# - overrule the usual evaluation rules and do non-standard evaluation, as described in non-standard evaluation.
# R has two types of scoping: lexical scoping, implemented automatically at the language level, and dynamic scoping, used in select functions to save typing during interactive analysis. We discuss lexical scoping here because it is intimately tied to function creation. Dynamic scoping is described in more detail in scoping issues.

# Lexical scoping looks up symbol values based on how functions were nested when they were created, not how they are nested when they are called. With lexical scoping, you don’t need to know how the function is called to figure out where the value of a variable will be looked up. You just need to look at the function’s definition.

# The “lexical” in lexical scoping doesn’t correspond to the usual English definition (“of or relating to words or the vocabulary of a language as distinguished from its grammar and construction”) but comes from the computer science term “lexing”, which is part of the process that converts code represented as text to meaningful pieces that the programming language understands.

# There are four basic principles behind R’s implementation of lexical scoping:
# - name masking
# - functions vs. variables
# - a fresh start
# - dynamic lookup

# You probably know many of these principles already, although you might not have thought about them explicitly. Test your knowledge by mentally running through the code in each block before looking at the answers.

f <- function() {
  x <- 1
  y <- 2
  c(x, y)
}
f()
rm(f)

# If a name isn’t defined inside a function, R will look one level up.
x <- 2
g <- function() {
  y <- 1
  c(x, y)
}
g()
rm(x, g)

# The same rules apply if a function is defined inside another function: look inside the current function, then where that function was defined, and so on, all the way up to the global environment, and then on to other loaded packages. Run the following code in your head, then confirm the output by running the R code.

# You generally want to avoid this behaviour because it means the function is no longer self-contained. This is a common error — if you make a spelling mistake in your code, you won’t get an error when you create the function, and you might not even get one when you run the function, depending on what variables are defined in the global environment.

# One way to detect this problem is the findGlobals() function from codetools. This function lists all the external dependencies of a function:
  
f <- function() x + 1
codetools::findGlobals(f)
#> [1] "+" "x"


# Every operation is a function call
# “To understand computations in R, two slogans are helpful:
# Everything that exists is an object.
#     Everything that happens is a function call."
#               — John Chambers

# Function arguments
# It’s useful to distinguish between the formal arguments and the actual arguments of a function. The formal arguments are a property of the function, whereas the actual or calling arguments can vary each time you call the function. This section discusses how calling arguments are mapped to formal arguments, how you can call a function given a list of arguments, how default arguments work, and the impact of lazy evaluation.

# Calling functions
# When calling a function you can specify arguments by position, by complete name, or by partial name. Arguments are matched first by exact name (perfect matching), then by prefix matching, and finally by position. 

f <- function(abcdef, bcde1, bcde2) {
  list(a = abcdef, b1 = bcde1, b2 = bcde2)
}
str(f(1, 2, 3))
#> List of 3
#>  $ a : num 1
#>  $ b1: num 2
#>  $ b2: num 3
str(f(2, 3, abcdef = 1))
#> List of 3
#>  $ a : num 1
#>  $ b1: num 2
#>  $ b2: num 3

# Can abbreviate long argument names:
str(f(2, 3, a = 1))
#> List of 3
#>  $ a : num 1
#>  $ b1: num 2
#>  $ b2: num 3

# But this doesn't work because abbreviation is ambiguous
str(f(1, 3, b = 1))
#> Error in f(1, 3, b = 1): argument 3 matches multiple formal arguments

# Calling a function given a list of arguments
# Suppose you had a list of function arguments:
args <- list(1:10, na.rm = TRUE)
# How could you then send that list to mean()? You need do.call():
do.call(mean, list(1:10, na.rm = TRUE))
#> [1] 5.5
# Equivalent to
mean(1:10, na.rm = TRUE)
#> [1] 5.5

# You can determine if an argument was supplied or not with the missing() function.
i <- function(a, b) {
  c(missing(a), missing(b))
}
i()
#> [1] TRUE TRUE
i(a = 1)
#> [1] FALSE  TRUE
i(b = 2)
#> [1]  TRUE FALSE
i(1, 2)
#> [1] FALSE FALSE

# Lazy evaluation
# If you want to ensure that an argument is evaluated you can use force():
f <- function(x) {
    force(x)
    10
}
f(stop("This is an error!"))
#> Error in force(x): This is an error!

# This is important when creating closures with lapply() or a loop:
add <- function(x) {
    function(y) x + y
}
adders <- lapply(1:10, add)
adders[[1]](10)
#> [1] 20
adders[[10]](10)
#> [1] 20

# x is lazily evaluated the first time that you call one of the adder functions. At this point, the loop is complete and the final value of x is 10. Therefore all of the adder functions will add 10 on to their input, probably not what you wanted! Manually forcing evaluation fixes the problem:
  
add <- function(x) {
    force(x)
    function(y) x + y
}
adders2 <- lapply(1:10, add)
adders2[[1]](10)
#> [1] 11
adders2[[10]](10)
#> [1] 20

# This code is exactly equivalent to
add <- function(x) {
  x
  function(y) x + y
}

# More technically, an unevaluated argument is called a promise, or (less commonly) a thunk. A promise is made up of two parts:
# The expression which gives rise to the delayed computation. (It can be accessed with substitute(). See non-standard evaluation for more details.)
# The environment where the expression was created and where it should be evaluated.

# The first time a promise is accessed the expression is evaluated in the environment where it was created. This value is cached, so that subsequent access to the evaluated promise does not recompute the value (but the original expression is still associated with the value, so substitute() can continue to access it). You can find more information about a promise using pryr::promise_info(). This uses some C++ code to extract information about the promise without evaluating it, which is impossible to do in pure R code.

# Laziness is useful in if statements — the second statement below will be evaluated only if the first is true. If it wasn’t, the statement would return an error because NULL > 0 is a logical vector of length 0 and not a valid input to if.

x <- NULL
if (!is.null(x) && x > 0) {
  
}

# There is a special argument called ... . This argument will match any arguments not otherwise matched, and can be easily passed on to other functions. This is useful if you want to collect arguments to call another function, but you don’t want to prespecify their possible names. ... is often used in conjunction with S3 generic functions to allow individual methods to be more flexible.

# One relatively sophisticated user of ... is the base plot() function. plot() is a generic method with arguments x, y and ... . To understand what ... does for a given function we need to read the help: “Arguments to be passed to methods, such as graphical parameters”. Most simple invocations of plot() end up calling plot.default() which has many more arguments, but also has ... . Again, reading the documentation reveals that ... accepts “other graphical parameters”, which are listed in the help for par(). This allows us to write code like:
  
plot(1:5, col = "red")
plot(1:5, cex = 5, pch = 20)

# To capture ... in a form that is easier to work with, you can use list(...). (See capturing unevaluated dots for other ways to capture ... without evaluating the arguments.)

f <- function(...) {
  names(list(...))
}
f(a = 1, b = 2)
#> [1] "a" "b"

# (There are two important exceptions to the copy-on-modify rule: environments and reference classes. These can be modified in place, so extra care is needed when working with them.)
