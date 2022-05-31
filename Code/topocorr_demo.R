# devtools::install_github('https://github.com/fainjj/geoSimple')
# require(geoSimple)


gs.topocorr(dem_path = '/Users/fainjj/Documents/Projects/Sandbox/Data/DEM.tif',
            bands_folder = '/Users/fainjj/Documents/Projects/Sandbox/Data/test_bands',
            sun_elev = 54.7503450,
            sun_azim = 111.2959563,
            correction_method = 'ccorrection')

gs.topocorr(dem_path = '/Users/fainjj/Documents/Projects/Sandbox/Data/DEM.tif',
            bands_folder = '/Users/fainjj/Documents/Projects/Sandbox/Data/test_bands',
            sun_elev = 54.7503450,
            sun_azim = 111.2959563,
            correction_method = 'gamma')

gs.topocorr(dem_path = '/Users/fainjj/Documents/Projects/Sandbox/Data/DEM.tif',
            bands_folder = '/Users/fainjj/Documents/Projects/Sandbox/Data/test_bands',
            sun_elev = 54.7503450,
            sun_azim = 111.2959563,
            correction_method = 'SCS')