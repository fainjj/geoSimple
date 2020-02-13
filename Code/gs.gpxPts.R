#' Convert GPX points to an sf object
#'
#' @param gpx_file A path to the gpx file containing waypoints
#'
#' @return An sf points object.
#' @export
#'
#' @examples
gs.gpxPts <- function(gpx_file) {
  if (!require(plotKML)) { install.packages('plotKML') }; require(plotKML)
  if (!require(sf)) { install.packages('sf') }; require(sf)
  
  gp <- readGPX(gpx_file)
  
  pts <- st_as_sf(gp$waypoints, coords=c('lon', 'lat'))
  st_crs(pts) <- '+proj=longlat +datum=WGS84 +no_defs'
  
  return(pts)
}
