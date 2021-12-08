#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(shiny.i18n)
library(DT)
library(leaflet)

library(readr)
library(purrr)
library(terra)

# Define UI for application that draws a histogram
ui <- bootstrapPage(
  tags$head(tags$style(HTML(
    "
        h3 {
            font-weight:bold
        }
                        "
  ))),
  theme = shinytheme("flatly"),
  navbarPage(
    # Application title
    "Global Soil Nematode Database Spatial Anaylsis",
    # tabPanel(
    #   "Overview",
    # ),
    tabPanel(
      # Sidebar with a slider input for number of bins
      "Analysis",
      fluidRow(column(5,
                      h4(
                        "Author:",
                        a(href = "https://blog.washman.top", "Han Chen"),
                        "and Wanyanhan Jiang"
                      )),
               column(3,
                      h5(
                        a(href = "mailto://chenhan28@gmail.com", "chenhan28@gmail.com")
                      )),
               column(3,
                      h6("Version: 20211208"))),
      sidebarLayout(
        sidebarPanel(
          radioButtons(
            "data_source",
            "File Source:",
            choices = list("Internel Demo" = "demo",
                           "Upload a File" = "file"),
            selected = "demo"
          ),
          helpText(
            "Internel demo data comes from sampling sites of following paper:\n",
            a(href = "https://doi.org/10.3390/d13080369", "https://doi.org/10.3390/d13080369")
          ),
          radioButtons(
            "extract_method",
            "Method for extracting values with points",
            choices = list(
              "Simple" = "simple",
              "Bilinear" = "bilinear"
            ),
            selected = "simple"
          )
        ),
        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel(
            tabPanel(title = ("Map Viewer"),
                     leafletOutput("map_viewer")),
            tabPanel(title = ("Extract Spatial Data"),
                     DTOutput("extract_data")
                     )
            )
          )
      )
    ),
    tabPanel(
      "Acknowledgements and References"
      )
  )
)
