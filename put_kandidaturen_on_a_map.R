library(tidyverse)
library(leaflet)
library(htmltools)
library(htmlwidgets)

# read in candidates as dataframe
kandidaturen <- read_csv("kandidaturen_mit_geokoordinaten.csv", locale = locale(encoding = "UTF-8"))

# define icon used in map
awesome <- makeAwesomeIcon(
  icon = "user",
  iconColor = "black",
  markerColor = "red",
  library = "fa"
)

# add labels to markers
labs <- lapply(seq(nrow(kandidaturen)), function(i) {
  paste0(
    '<b>Name:</b> ', kandidaturen[i, "Vornamen"], 
    ' ', kandidaturen[i, "Nachname"], "<p>",  
    '<b>Geburtsort:</b> ', kandidaturen[i, "Geburtsort"], '<p>', 
    '<b>Partei:</b> ', kandidaturen[i, "Gruppenname"], '<p>', 
    '<b>Wahlkreis:</b> ', kandidaturen[i, "Gebietsname"], '<p>', 
    '<b>Beruf:</b> ', kandidaturen[i, "Beruf"]) 
})


# create map
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addAwesomeMarkers(data=kandidaturen,
                    lng=~long, 
                    lat=~lat,
                    icon=awesome, 
                    clusterOptions = markerClusterOptions(),
                    label = lapply(labs, htmltools::HTML))

saveWidget(m, file="birtplace_german_candidates.html")