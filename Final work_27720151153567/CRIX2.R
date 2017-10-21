rm(list=ls())
library(rjson)
library(zoo)
library(forecast)
library(ggplot2)

#download crix data
Json_file = "http://crix.hu-berlin.de/data/crix.json"
Json_data = fromJSON(file=Json_file)

#get daily price and log return of crix from the original data
crix_data_frame = as.data.frame(Json_data)
n=dim(crix_data_frame)
num1 = seq(from=1,to=n[2],by=2) 
num2 = seq(from=2,to=n[2],by=2)
date = as.Date(t(crix_data_frame[,num1]))
price = as.numeric(t(crix_data_frame[,num2]))
return = diff(log(price))

#plot the price of crix
graph1 = data.frame(time=date,price=price)
p1 = ggplot(graph1,aes(x=time,y=price))
p1 + geom_line(colour = 'black') + labs(x='Date',y='Price',title='The daily price of CRIX')

#plot the log return of crix
graph2 = data.frame(time=date[-1],return=return)
p2 = ggplot(graph2,aes(x=time,y=return))
p2 + geom_line(colour = 'black') + labs(x='Date',y='log return',title='The daily log returns of CRIX')

par(mfrow = c(1, 2))
# histogram of returns
hist(return, col = "grey", breaks = 20, freq = FALSE, ylim = c(0, 25), xlab = NA)
lines(density(return), lwd = 2)
mu = mean(return)
sigma = sd(return)
x = seq(-4, 4, length = 100)
curve(dnorm(x, mean = mean(return), sd = sd(return)), add = TRUE, col = "darkblue", 
      lwd = 2)
# qq-plot
qqnorm(return)
qqline(return, col = "blue", lwd = 3)

par(mfrow = c(1, 2))
# acf plot
autocorr = acf(return, lag.max = 20, main='ACF Squared Residuals',ylab = "ACF", lwd = 2, ylim = c(-0.3, 1))
# plot of pacf
autopcorr = pacf(return, lag.max = 20, ylab = "PACF",main='PACF Squared Residuals', ylim = c(-0.3, 0.3), lwd = 2)
#fit arima model
fit = auto.arima(return)
crpre = predict(fit, n.ahead = 30)

par(mfrow = c(1, 1))
#plot crix reurn and predicted values

ts.plot(return,main="The log return of CRIX and predicted values",ylab = "log return", xlab = "day", lwd = 1.5)
lines(crpre$pred, col = "red", lwd = 3)
lines(crpre$pred + 2 * crpre$se, col = "red", lty = 3, lwd = 3)
lines(crpre$pred - 2 * crpre$se, col = "red", lty = 3, lwd = 3)

res.fit=fit$residuals
squared.res.fit=res.fit^2
par(mfcol=c(1,1))
#plot the squared residuals of fitted model
plot(squared.res.fit,main='Squared Residuals')

par(mfcol=c(1,2))
#plot acf of the squared residuals of fitted model
acf.squared=acf(squared.res.fit,main='ACF Squared Residuals',lag.max=20,ylim=c(-0.5,1))
#plot pacf of the squared residuals of fitted model
pacf.squared=pacf(squared.res.fit,main='PACF Squared Residuals',lag.max=20,ylim=c(-0.5,1))

