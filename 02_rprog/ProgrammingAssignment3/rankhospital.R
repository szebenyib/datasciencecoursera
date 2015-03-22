rankhospital <- function(state, outcome, num = "best") {
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
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
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
  df <- df[complete.cases(df[ , column]), ]
  ordering <- order(df[ , column],
                    df[ , 2],
                    decreasing = FALSE)
  if (num == "best") {
    id <- 1
  } else if (num == "worst") {
    id <- ordering[nrow(df)]
  } else if (num > nrow(df)) {
    id <- num #will return NA later
  } else {
    id <- ordering[num]
  }
  
  # Returned the ranked item or NA if num is too big
  if (nrow(df) >= id) {
    return(as.character(df[id, 2]))
  } else {
    return(NA)
  }
}