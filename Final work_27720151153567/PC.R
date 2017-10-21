rm(list=ls())
Time=c(1970:1979,1982,1988:2001,2004,2009,2014)
memory=c(rep(256,10),256,rep(2*1024,3),rep(16*1024,5),rep(256*1024,5),1024*1024,4*1024*1024,8*1024*1024,16*1024*1025)
plot(Time,memory,type="l",main="The History of computer memory",ylab = "memory(KB)", xlab = "year", lwd = 1.5)
