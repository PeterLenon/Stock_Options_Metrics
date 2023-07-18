library(quantmod)
library(forecast)
library(tseries)

getStockPrices <- function(string_label)
{
  return (getSymbols(string_label))
}

getTimeSeries <- function(column_label)
{
  return (ts(stocks[,column_label]))
}

makeStationary <- function(stocks_ts, d)
{
  d = 0
  while(adf.test(stocks_ts)$p.value >0.01)
  {
    stocks_ts <- diff(stocks_ts)
    d = d + 1
  }
  return (stocks_ts)
}

renameColumns <- function(stocks)
{
  colnames(stocks)<- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
  return (stocks)
}
stocks <- getStockPrices(user_choice)

stocks_ts <- getTimeSeries("Adjusted")
d_value <- 0
stocks_ts <- makeStationary(stocks_ts, d_value)
Pacf(stocks_ts)
choose your own p value from the graph above
Acf(stocks_ts)
//choose your own p value from the graph above//
q_value

tsMod <- Arima(y = stocks_ts[,"Adjusted"], order = c(p_value, d_value, q_value))
//get user time frame//
autoplot(tsMod, h = time_frame)

stock_stats <- setRefClass("stock_stats", 
                           fields = c(user_choice ,stocks_ts , d_value, getStockPrices(), getTimeSeries(), makeStationary(), ))

cat("peter")

