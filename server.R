library(shiny)
library(leaflet)
library(RColorBrewer)
library(tidyverse)

server <- function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    data[data$区 == input$district & data$日期 == input$date,]
  })
  
  # This reactive expression represents the palette function,
  # which changes as the user makes selections in UI.
  colorpal <- reactive({
    colorNumeric(input$colors, data$区)
  })
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(data[data$区 == input$district & data$日期 == as.Date(input$date),]) %>% addTiles() %>%
      fitBounds(~min(经度), ~min(纬度), ~max(经度), ~max(纬度)) %>%
      addMarkers(~经度, ~纬度, label = ~as.character(地址))
  })
  
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  
  
}