best <- function(state, outcome) {
  ## state: 2 char name of the state
  ## outcome: outcome name to check for
  
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv",
                 "header"=TRUE,
                 "na.strings"="Not Available")
  
  ## Check that state and outcome are valid
  states <- (df$State)
  outcomes <- c("heart attack",
                "heart failure",
                "pneumonia")
  if (!state %in% states) {
    stop("invalid state")
  }
  if (!outcome %in% outcomes) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  # Filter for state
  df <- split(df, df$State)
  df <- get(state, df)
  if (outcome == "heart attack") {
    column = 11
  } else if (outcome == "heart failure") {
    column = 17
  } else if (outcome == "pneumonia") {
    column = 23
  } else {
    stop("not a valid outcome, should not have come here")
  }
  # Filter for disease, column
  df[ , column] <- as.numeric(df[ , column])
  rows = which(df[ , column] == min(df[ , column],
                                    na.rm = TRUE))
  
  #Return the first in abc order
  hospitals = vector(mode = "character",
                     length = 0)
  for (i in rows) {
    hospitals <- c(hospitals, as.character(df$Hospital.Name[i]))
  }
  hospitals <- sort(hospitals,
                    decreasing = FALSE)
  return(hospitals[1])
}