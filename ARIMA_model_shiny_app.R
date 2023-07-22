library(forecast)
library(tseries)
library(quantmod)
library(xts)
library(shiny)
library(shinythemes)
install.packages('BatchGetSymbols')
library(BatchGetSymbols)
sp500 <- GetSP500Stocks()
sp500 <- as.list(sp500['Tickers'])

ui <- fluidPage(
  selectInput(inputId = 'choice',
              label = 'Choice',
              choices = sp500,
              selected = c('')
  ),
  
  plotOutput('ARIMA_forecast')
  
)

server <- function(input, output){
  symbol <- reactive({input$choice})
  
  data <- reactive({
    tryCatch({
      getSymbols(symbol(),
      src = "yahoo",
      verbose = TRUE,
      auto.assign = FALSE)
    }, error = function(e) {
      NULL
    })
  })
  
  observe({
    if (!is.null(data())) {
      data <- as.data.frame(data)
      colnames(data) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
      tesla_ts <- ts(data)
      
      adf.test(tesla_ts[,"Adjusted"])
      
      if (length(tesla_ts[,"Adjusted"]) > 1) {
        tesla_ts_Ad_d1 <- diff(tesla_ts[,"Adjusted"])
        adf.test(tesla_ts_Ad_d1)
        pacf(tesla_ts_Ad_d1)
        Acf(tesla_ts_Ad_d1)
        tsMod <- Arima(y = tesla_ts[,"Adjusted"], order = c(7, 1, 8))
        
        if (!is.null(tsMod)) {
          output$ARIMA_forecast <- renderPlot({forecast(tsMod, h = 365)})
        } else {
          output$ARIMA_forecast <- renderText("Failed to create the ARIMA model.")
        }
      } else {
        output$ARIMA_forecast <- renderText("Insufficient data for differencing.")
      }
    } else {
      output$ARIMA_forecast <- renderText("Error fetching data. Please select a valid symbol.")
    }
  })
}

shinyApp(ui = ui, server = server)



