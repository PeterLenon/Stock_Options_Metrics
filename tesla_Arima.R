library(forecast)
library(tseries)
library(quantmod)
library(xts)

getSymbols('TSLA')
head(TSLA)
tesla_ts <- ts(TSLA)
plot(tesla_ts)
colnames(tesla_ts)
colnames(tesla_ts) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
colnames(tesla_ts)
plot(tesla_ts[,'Adjusted'])
autoplot(tesla_ts[,'Adjusted'])

adf.test(tesla_ts[,"Adjusted"])
tesla_ts_Ad_d1 <- diff(tesla_ts[,"Adjusted"])
adf.test(tesla_ts_Ad_d1)

plot(tesla_ts_Ad_d1)

Pacf(tesla_ts_Ad_d1)
Acf(tesla_ts_Ad_d1)

tsMod <- Arima(y=tesla_ts[,"Adjusted"], order = c(7,1,8))
print(tsMod)

forecast(tsMod, h= 30)

autoplot(forecast(tsMod, h = 365))
