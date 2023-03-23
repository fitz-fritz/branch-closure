tags$section(id = "overview",
  class = "content_page",
  div(
    id = "content_header_id",
    class = "content_header",
    tags$style(type = "text/css", "#trip {height: calc(100vh) !important;}"),
  leafletOutput("trip", width="100%", height="100%")),
 absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
               draggable = TRUE, top = 10.5, left = 53 , right = "auto", bottom = "auto", opacity = 0.6,
               width = "20.5%", height = "auto", 
  h6("A Visualisation by FitzFritzData", tags$a(href="https://twitter.com/fitzfritzdata", icon("twitter")), tags$a(href="https://linkedin.com/in/pascalfrick", icon("linkedin")), tags$a(href="https://github.com/fitz-fritz", icon("github")),
                            h2("(Planned) Branch Closures", tags$br(), "of a German Retail Bank"),
   h6(radioButtons("Branches", label = "Branches ", c("Overview Branch Closures","Travel Time and Distance to Replacement Branch for Customers"), selected = "Overview Branch Closures")),
   h6(tags$br(),"The distances and travel time by car are calculated by the Open Street Routing Machine"),
   h6("Disclaimer:", tags$br(), "There are no commercial interests involved in this project. All information contained on this website is without guarantee.", tags$br(),"The app is published with Shiny from RStudio. The visualisation and calculations are mainly based on the packages leaflet, osrm and tidygeocoder."))
))


