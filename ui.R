#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(leaflet)

library(readr)
library(purrr)

# Define UI for application that draws a histogram
ui <- bootstrapPage(
  # Application title
  titlePanel("Global Soil Nematode Database Spatial Anaylsis"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(sidebarPanel(
    radioButtons(
      "data_source",
      "File Source:",
      choices = list("Demo" = "demo",
                     "Upload a File" = "file"),
      selected = "demo"
    )
  ),
  
  # Show a plot of the generated distribution
  mainPanel(leafletOutput("overview")))
)
