complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  #files_df <- list.files(directory)
  df = data.frame(id = id,
                  nobs = 0)
  line_counter <- 1
  for (i in id) {
    full_name <- paste(sprintf("%03d",
                               i),
                       ".csv",
                       sep="")
    full_url <- paste(directory,
                      "/",
                      full_name,
                      sep="")
    obs_df <- read.csv(full_url)
    df[line_counter, 2] <- sum(complete.cases(obs_df))
    line_counter = line_counter + 1
  }
  return(df)
}