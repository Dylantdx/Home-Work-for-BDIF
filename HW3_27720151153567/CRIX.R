rm(list=ls())
library(rjson)
library(zoo)
library(ggplot2)
library(forecast)

Json_file = "http://crix.hu-berlin.de/data/crix.json"

Json_data = fromJSON(file=Json_file)

crix_data_frame = as.data.frame(Json_data)

num1 = seq(from=1,to=2349,by=2) 
num2 = seq(from=2,to=2350,by=2)

date = as.Date(t(crix_data_frame[,num1]))
price = as.numeric(t(crix_data_frame[,num2]))

graph = data.frame(time=date,price=price)
p = ggplot(graph,aes(x=time,y=price))
p + geom_line(colour = 'black') + xlab('Date') 
+ ylab('Price')

zoo = zoo(price,order.by = date)
price_ts = ts(zoo)

fit = auto.arima(price_ts)
fit

res.fit=fit$residuals
squared.res.fit=res.fit^2
par(mfcol=c(3,1))
plot(squared.res.fit,main='Squared Residuals')
acf.squared212=acf(squared.res.fit,main='ACF Squared Residuals',lag.max=100,ylim=c(-0.5,1))
pacf.squared212=pacf(squared.res.fit,main='PACF Squared Residuals',lag.max=100,ylim=c(-0.5,1))
