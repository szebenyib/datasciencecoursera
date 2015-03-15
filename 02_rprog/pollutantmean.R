pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  means_of_sensors <- vector(mode = "integer",
                             length = length(id))
  weights_of_sensors <- vector(mode = "integer",
                              length = length(id))
  mean_counter <- 1
  for (i in id) {
    full_name <- paste(sprintf("%03d",
                               i),
                      ".csv",
                      sep="")
    full_url <- paste(directory,
                "/",
                full_name,
                sep="")
    df <- read.csv(full_url)
    #Take the average of one file
    means_of_sensors[mean_counter] = mean(x = df[ , pollutant],
                                          na.rm = TRUE)
    #Count valid observations in one file
    weights_of_sensors[mean_counter] <- sum(!is.na(df[ , pollutant]))
    mean_counter = mean_counter + 1
  }
  print(means_of_sensors)
  print(weights_of_sensors)
  mean_of_pollutant <- 0
  return(weighted.mean(x = means_of_sensors,
                       w = weights_of_sensors,
                       na.rm = TRUE))
}
