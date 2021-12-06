# Define server logic required to draw a histogram
server <- function(input, output) {
  
  rct_df_data <- reactive({
    if (input$data_source == "demo") {
      df <- read_csv("resource/demo_point.csv") %>%
        set_names(c("x", "y"))
      df
    } else {
      if (is.null(input$df_upload_file)) {
        return("")
      } else {
        return("")
        # df <- read_csv(input$df_upload_file$datapath)
        # tr_name <- colnames(df)[1]
        # rename(df, "Treatment" = all_of(tr_name)) %>%
        #   mutate(Treatment = as.factor(Treatment))
      }
    }
  })
  
  rct_overview_map <-
    reactive({
      leaflet() %>%
        addProviderTiles(providers$Esri.WorldTerrain,
                         options = providerTileOptions(noWrap = TRUE)
        ) %>% 
        addMarkers(
          lat = ~y,
          lng = ~x,
          data = rct_df_data()
          )
    })
  
  output$overview <- renderLeaflet({
    rct_overview_map()
  })
}