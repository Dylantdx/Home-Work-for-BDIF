rm(list=ls())
# call the library doing the hashes
library("digest")
# now do the hash code calculation
digest("I learn a lot from this class when I am proper listening to the professor", "sha256")
digest("I do not learn a lot from this class when I am absent and playing on my Iphone","sha256")