corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  number_of_files = length(list.files(directory))
  corrs <- vector(mode = "numeric",
                  length = number_of_files)
  for (i in 1:number_of_files) {
    full_name <- paste(sprintf("%03d",
                               i),
                       ".csv",
                       sep="")
    full_url <- paste(directory,
                      "/",
                      full_name,
                      sep="")
    obs_df <- read.csv(full_url)
    complete_cases <- sum(complete.cases(obs_df))
    if (complete_cases > threshold) {
      corrs[i] <- cor(x = obs_df[ , "sulfate"],
                      y = obs_df[ , "nitrate"],
                      use = "complete")
    }
  }
  #Remove zeros that were below threshold
  corrs <- setdiff(corrs, 0)
  return(corrs)
}