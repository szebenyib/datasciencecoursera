rankall <- function(outcome, num = "best") {
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv",
                 "header"=TRUE,
                 "na.strings"="Not Available")
  
  ## outcome validation
  outcomes <- c("heart attack",
                "heart failure",
                "pneumonia")
  if (!outcome %in% outcomes) {
    stop("invalid outcome")
  }

  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  # Filter for state
  states <- unique(df$State)
  global_df <- split(df, df$State)
  if (outcome == "heart attack") {
    column = 11
  } else if (outcome == "heart failure") {
    column = 17
  } else if (outcome == "pneumonia") {
    column = 23
  } else {
    stop("not a valid outcome, should not have come here")
  }

  ordered_df <- NULL
  lengths <- NULL
  for (state in states) {
    df <- get(state, global_df)
    # Filter for disease, column
    df[ , column] <- as.numeric(df[ , column])
    #df <- df[complete.cases(df[ , column]), ]
    
    df <- df[order(df[ , column],
                   df[ , 2],
                  na.last = TRUE,
                  decreasing = FALSE), ]
    ordered_df[[state]] <- df
    df <- df[complete.cases(df[ , column]), ]
    lengths[[state]] <- nrow(df)
  }

  # Returned the ranked item or NA if num is too big
  hospital_list <- NULL
  state_list <- NULL
  if (num == "best") {
    for (state in states) {
      hospital <- as.character(as.data.frame(ordered_df[state])[1, c(2)])
      hospital_list <- c(hospital_list, hospital)
      state_list <- c(state_list, state)#as.character(as.data.frame(ordered_df[state])[id, c(7)]))
    }
    ranklist <- cbind(hospital_list, state_list)
    ranklist <- ranklist[order(ranklist[ , 2]), ]
    rownames(ranklist) <- state_list
    colnames(ranklist) <- c("hospital", "state")
    ranklist <- data.frame(ranklist)
    return(ranklist)
  } else if (num == "worst") {
    for (state in states) {
      hospital <- as.character(as.data.frame(ordered_df[state])[lengths[state], c(2)])
      hospital_list <- c(hospital_list, hospital)
      state_list <- c(state_list, state)#as.character(as.data.frame(ordered_df[state])[id, c(7)]))
    }
    ranklist <- cbind(hospital_list, state_list)
    ranklist <- ranklist[order(ranklist[ , 2]), ]
    rownames(ranklist) <- state_list
    colnames(ranklist) <- c("hospital", "state")
    ranklist <- data.frame(ranklist)
    return(ranklist)
  } else if (num <= max(lengths)){
    for (state in states) {
      hospital <- as.character(as.data.frame(ordered_df[state])[num, c(2)])
      hospital_list <- c(hospital_list, hospital)
      state_list <- c(state_list, state)#as.character(as.data.frame(ordered_df[state])[id, c(7)]))
    }
    ranklist <- cbind(hospital_list, state_list)
    ranklist <- ranklist[order(ranklist[ , 2]), ]
    rownames(ranklist) <- state_list
    colnames(ranklist) <- c("hospital", "state")
    ranklist <- data.frame(ranklist)
    return(ranklist)
  } else {
    return(NA)
  }
}