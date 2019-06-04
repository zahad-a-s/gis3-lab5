#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(spData)
library(dplyr)
library(tmap)
library(sf)

# Define UI for application that filters map points based on year and minimum population
ui <- fluidPage(
  
  # Application title
  titlePanel("Average Daily Traffic Volume - Chicago Roads"),
  
  # Sidebar with a slider input for year, numeric input for population 
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("min",
                  "Minimum Volume",
                  min = 700,
                  max = 111700,
                  step = 100,
                  sep = "",
                  value = 700)
    ),
    
    # Show the map and table
    mainPanel(
      leafletOutput("map"),
      dataTableOutput("table")
    )
  )
)

# Define server logic required to draw a map and table
server <- function(input, output) {
  
  output$map <- renderLeaflet({
    traffic = read.csv("C:/Users/Ali/Documents/School/GEOG 28602/Lab 5/AverageDailyTraffic.csv")
    volume = filter(traffic,
                    Volume >= input$min)
    
    #world map (placeholder)                
    tm = tm_shape(world) + tm_borders()
    tmap_leaflet(tm)
  })
  
  output$table <- renderDataTable({
    
    traffic = read.csv("C:/Users/Ali/Documents/School/GEOG 28602/Lab 5/AverageDailyTraffic.csv")
    
    volume = filter(traffic,
                    Volume >= input$min)
    
    volume[, c(1,2,3,5,6,9)]
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)