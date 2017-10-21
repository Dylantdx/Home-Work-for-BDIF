# call the library doing the transition between R and JSON
library(rjson)

#create a list in R
x <- list( alpha = 1:5, beta = "Bravo", 
           gamma = list(a=1:3, b=NULL), 
           delta = c(TRUE, FALSE) )

#transfer it to JSON
json <- toJSON( x )

#read it again
fromJSON( json )