#' Simple Topographic Correction
#'
#' @param dem_path Path to your DEM file
#' @param bands_folder Path to the folder containing one image per band
#' @param sun_elev Solar elevation
#' @param sun_azim Solar azimuth
#' @param raster_extension File extension for image bands. Defaults to 'tif'
#' @param correction_method Correction method passed directly to landsat::topocorr. See ?landsat::topocorr for full list of options.
#'
#' @return Returns nothing. Topo corrected bands will be placed in the same folder as the original bands with the _topo_corr suffix. Currently only supports tif output.
#' @export
#'
#' @examples
gs.topocorr <- function(dem_path, bands_folder, sun_elev, sun_azim, raster_extension='tif', correction_method='ccorrection'){
  if (!require(landsat)) { install.packages('landsat') }; require(landsat)
  if (!require(raster)) { install.packages('raster') }; require(raster)
  if (!require(tidyverse)) { install.packages('tidyverse') }; require(tidyverse)

  urdem <- raster(dem_path)
  urslp <- terrain(urdem, opt='slope') %>% as('SpatialGridDataFrame')
  urasp <- terrain(urdem, opt='aspect') %>% as('SpatialGridDataFrame')

  list.files(bands_folder, pattern=paste0('.', raster_extension, '$'), full.names = T) %>%
    walk(function(x) {
      readGDAL(x) %>%
        topocorr(urslp, urasp, sun_elev, sun_azim,
                 method=correction_method, na.value=NA, GRASS.aspect=FALSE) %>%
        raster() %>%
        writeRaster(filename = x %>%
                      str_remove(pattern = paste0('\\.', raster_extension)) %>%
                      paste0('_topocorr.tif'))
    })
}
