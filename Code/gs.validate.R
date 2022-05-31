gs.validate <- function(object) {
  if (!require(tidyverse)) { install.packages('tidyverse') }; require(tidyverse)
  if (!require(raster)) { install.packages('raster') }; require(raster)
  if (!require(sf)) { install.packages('sf') }; require(sf)
  if (!require(leaflet)) { install.packages('leaflet') }; require(leaflet)
  if (!require(sf)) { install.packages('sf') }; require(sf)
  
  if (!('sf' %in% class(object))) {object <- st_as_sf(object)}
  object <- st_transform(object, 4326)
  
  pts <- tibble(.rows = nrow(object))
  counter <- 1
  
  for (i in 1:nrow(pts)) {
    leaflet(object[i, ]) %>%
      addProviderTiles('Esri.WorldImagery') %>%
      addCircles(color = '#ffb700', opacity = 1)
    
    response <- readline('Persistent?')
    pts[i, ] <- mutate(object[i, ], response = response)
  }
  
  return(pts)
}
