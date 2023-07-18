library(forecast)
library(tseries)
library(quantmod)
library(xts)
library(shiny)
library(shinythemes)

ui <- fluidPage(theme = shinytheme("cerulean"),
                navbarPage(
                  # theme = "cerulean",  # <--- To use a theme, uncomment this
                  "My first app",
                  tabPanel("Navbar 1",
                           sidebarPanel(
                             tags$h3("Input:"),
                             textInput("txt1", "Given Name:", ""),
                           ), # sidebarPanel
                           mainPanel(
                             h3("Forecast"),
                             plotOutput("ARIMA_forecast")
                           )
                           
                  ), # Navbar 1, tabPanel
                  
                ) # navbarPage
) # fluidPage
                
                
               

server <- function(input, output){
  symbol <- reactive({input$txt1})
  getSymbols(symbol)
  tesla_ts <- ts(symbol)
  colnames(tesla_ts) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
  adf.test(tesla_ts[,"Adjusted"])
  tesla_ts_Ad_d1 <- diff(tesla_ts[,"Adjusted"])
  adf.test(tesla_ts_Ad_d1)
  pacf(tesla_ts_Ad_d1)
  Acf(tesla_ts_Ad_d1)
  tsMod <- Arima(y=tesla_ts[,"Adjusted"], order = c(7,1,8))
  
  output$ARIMA_forecast <- renderplot({forecast(tsMod, h = 365)})
}

shinyApp(ui = ui, server = server)



