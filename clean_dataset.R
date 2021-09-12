library(tidyverse)
library(tidygeocoder)

bundestagswahl_kandidaturen <- read_csv2("btw21_kandidaturen.csv", skip = 8, col_types = cols(
  Staatsangehörigkeit = col_character(),
  Listenplatz = col_double()
))

unique_bundestagswahl_kandidaturen <- bundestagswahl_kandidaturen %>% 
  distinct(Nachname, Vornamen, Geburtsjahr, .keep_all = T)

kandidaturen_mit_geokoordinaten <- unique_bundestagswahl_kandidaturen %>% 
  geocode(address = Geburtsort, verbose = TRUE)

write.csv(kandidaturen_mit_geokoordinaten ,"kandidaturen_mit_geokoordinaten.csv", row.names = FALSE)
