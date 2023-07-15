library(quantmod)
install.packages("tseries")
library(tseries)
install.packages("timeSeries")
library(timeSeries)
install.packages("forecast")
library(forecast)
library(xts)

getSymbols('TSLA')
class(TSLA)
df_TSLA = data.frame(TSLA)
class(df_TSLA)
head(df_TSLA)
tail(df_TSLA)

colnames(df_TSLA)
colnames(df_TSLA) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
colnames(df_TSLA)
 
plot(df_TSLA)

plot(Cl(df_TSLA), type = 'l')
plot(Ad(df_TSLA), type = 'l')

length(Ad(df_TSLA))
all_time_returns <- 100*((Ad(df_TSLA)[3242] - Ad(df_TSLA)[1])/Ad(df_TSLA)[1])
all_time_returns

daily_returns = dailyReturn(Ad(as.xts(df_TSLA)),type='arithmetic')
plot(dailyReturn(Ad(as.xts(df_TSLA)),type='arithmetic'), type ='l')
cummulative_returns <- cumprod(1+dailyReturn(Ad(as.xts(df_TSLA)),type='arithmetic'))
plot(cummulative_returns, type = 'l')

apply(df_TSLA[,c("Close","Adjusted")], 2, length)
apply(df_TSLA[,c("Close","Adjusted")], 2, log)
adjusted_VS_close <- data.frame(apply(apply(df_TSLA[,c("Close", "Adjusted")], 2, log), 2, diff))

plot(adjusted_VS_close[,1], type='l')
lines(adjusted_VS_close[,2], type ='l', col= "red")
