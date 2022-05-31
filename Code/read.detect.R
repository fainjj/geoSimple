read.detect <- function(fpath) {
  switch (fpath,
    grepl('\\.shp', fpath) = sf::st_read(fpath),
    grepl('\\.xlsx', fpath) = readxl::read_xlsx(fpath),
    grepl('\\.xls', fpath) = readxl::read_xls(fpath),
    grepl('\\.csv', fpath) = readr::read_csv(fpath)
  )
}