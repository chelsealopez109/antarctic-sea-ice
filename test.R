data <- mtcars



#https://polarwatch.noaa.gov/erddap/griddap/nsidcG02202v4sh1day.csv?cdr_seaice_conc%5B(2022-12-01T00:00:00Z):1:(2022-12-01T00:00:00Z)%5D%5B(3212500.0):1:(162500.0)%5D%5B(-2887500.0):1:(62500.0)%5D

# date must be format yyyy-mm-dd "2022-12-01"
ingest.ice.data <- function(date){
  x <- read.csv(url(paste0("https://polarwatch.noaa.gov/erddap/griddap/nsidcG02202v4sh1day.csv?cdr_seaice_conc%5B(",date,"T00:00:00Z):1:(",date,"T00:00:00Z)%5D%5B(3212500.0):1:(162500.0)%5D%5B(-2887500.0):1:(62500.0)%5D")))
  x <- x[cdr_sea_ice_conc != 2.53] #remove artifact
  x <- x[complete.cases(x),] # remove empty rows
  print(mean(x[,4])) #prints mean ice concentration for that day in the defined region
}

  