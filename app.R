#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinybusy)
library(shinyWidgets)
library(sass)
library(plyr)
library(leaflet)
library(stringr)
library(bitops)
library(R.utils)
library(osrm)
library(tidygeocoder)
library(tibble)
library(markdown)

load("Anybank_2.RData")

import$When <- str_replace(import$When, "\\s", "")

import[import == "abOkt 2021"] <- "Oct 2021"
import[import == "geschlossen"] <- "now"


#lat_longs$latitude[which(lat_longs$latitude == 52.54278)] <- 52.125378
#lat_longs$longitude[which(lat_longs$longitude == 13.350396)] <- 14.21165


pal <- colorFactor(palette = c("red", "orange"), levels = c(1,2))

css <- sass(sass_file("www/styles.scss"), cache =FALSE)

ui <- source(file.path("ui", "ui.R"), local = TRUE)$value

server <- function(input, output, session) {
  renderUI({HTML()})

output$trip <- renderLeaflet({
  if(input$Branches == "Overview Branch Closures"){

  leaflet() %>% 
    addProviderTiles(providers$CartoDB.Voyager, group = "OSM") %>% 
    setView(lng = 8.900972, lat = 50.123611, zoom = 5.3)  %>% 
    addGraticule(interval = 2) %>% 
    addCircleMarkers(
                     lat = lat_longs$latitude,
                     lng = lat_longs$longitude,
                     popup = paste(df$start, "will be closed by", import$When),
                     color = "red",
                     stroke = FALSE,
                     radius = 10,
                     fillOpacity = 0.5,
                     clusterOptions = markerClusterOptions())  %>% 
      addLegend (color = "red", label = "Closed Branches", position = "topright") %>% 
    addMiniMap(tiles = "OpenStreetMap",position = "topright", width = 100, height = 100)}
  else{
  leaflet(df) %>% 
      addProviderTiles(providers$CartoDB.Voyager, group = "OSM") %>% 
      setView(lng = 8.900972, lat = 50.123611, zoom = 5.3)  %>% 
      addGraticule(interval = 2) %>% 
      addPolylines() %>%
      addCircleMarkers(
        lat = new_df$lat,
        lng = new_df$long,
        color = ~pal(id),
        popup = paste("Distance between", df$start, "and", df$end,"in km:",  print(round(df$distance, digits = 2)), "<br>", "Travel time between", df$start, "and", df$end,"in decimal minutes by car:", print(round(df$duration, digits =2))),
        stroke = FALSE,
        radius = 10,
        fillOpacity = 0.5,
        clusterOptions = markerClusterOptions())  %>% 
      addLegend (color = c("red","orange"), label = c("Closed Branches", "Replacement Branches"), position = "topright") %>% 
      addMiniMap(tiles = "OpenStreetMap", position = "topright",  width = 100, height = 100)}  
    })

}

shinyApp(
  ui = ui,
  server = server
)