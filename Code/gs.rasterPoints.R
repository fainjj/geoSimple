gs.rasterPoints <- function(raster_stack, label = NULL, rgb_order = c(3, 2, 1), stretch_method = 'hist') {
  if (!require(tidyverse)) { install.packages('tidyverse') }; require(tidyverse)
  if (!require(raster)) { install.packages('raster') }; require(raster)
  if (!require(sf)) { install.packages('sf') }; require(sf)
  
  plotRGB(stack(raster_stack), r=rgb_order[1], g=rgb_order[2], b=rgb_order[3], scale=max(values(raster_stack)), stretch=stretch_method)
  print('Opening raster in viewer. Press ESC to finish.')
  pt_coords <- click(n=1024)
  clicked_pts <- pt_coords %>% as.data.frame() %>% st_as_sf(coords = c('x', 'y'))
  st_crs(clicked_pts) <- crs(raster_stack)
  
  pt_values <- raster::extract(raster_stack, as(clicked_pts, 'Spatial'), sp = TRUE)
  pts <- st_as_sf(pt_values)
  if (is.null(label) | !'character' %in% class(label)) {
    input_label <- readline('What is the label for this class? ')
    pts <- mutate(pts, label = input_label)
  } else {
    pts <- mutate(pts, label = label)
  }
  pts <- select(pts, label, everything())
  
  return(pts)
}
