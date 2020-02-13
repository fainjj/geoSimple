#' Quick point plotting with ESRI basemap
#'
#' @param object A SpatialPoints or sf points object.
#'
#' @return Produces a point map in the viewer window.
#' @export
#'
gs.quickMap <- function(object) {
  if (!require(leaflet)) { install.packages('leaflet') }; require(leaflet)
  if (!require(sf)) { install.packages('sf') }; require(sf)
  
  if (!('sf' %in% class(object))) {object <- st_as_sf(object)}
  
  leaflet(object) %>%
    addProviderTiles('Esri.WorldImagery') %>%
    addCircles(layerId = ~name, color = '#ffb700', opacity = 1,
               labelOptions = labelOptions(interactive = TRUE,
                                           sticky = FALSE))
}

