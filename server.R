# Define server logic required to draw a histogram
server <- function(input, output) {
  # rct_df_data: reactive function
  # Select file source
  # Rename column name
  # As lat, lng
  rct_df_data <- reactive({
    if (input$data_source == "demo") {
      df <- read_csv("resource/demo_point.csv") %>%
        set_names(c("lng", "lat"))
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
  
  # rct_overview_map: reactive function
  # Generate leaflet Map
  # And addMarkers on it
  # Output: rct_overview_map
  rct_overview_map <-
    reactive({
      leaflet() %>%
        addProviderTiles(providers$Esri.WorldTerrain,
                         options = providerTileOptions(noWrap = TRUE)
        ) %>% 
        addMarkers(
          lng = ~lng,
          lat = ~lat,
          data = rct_df_data()
          )
    })
  
  output$map_viewer <- renderLeaflet(
    rct_overview_map())
  
  # rct_read_total_raster: reactive function
  # read the full dataset from GeoTiff
  rct_read_total_raster <-
    reactive({
      rast("resource/tiff/TotalNumber_per100g.tif")
    })
  
  # rct_extract_point: reactive function
  # Extract value by point
  rct_extract_point <-
    reactive({
      rct_df_data() %>% 
      vect(geom = c("lng", "lat")) %>% 
      terra::extract(rct_read_total_raster(), ., method = input$extract_method, xy = TRUE)
    })
  
  output$extract_data <- renderDT(
    rct_extract_point()
  )
}