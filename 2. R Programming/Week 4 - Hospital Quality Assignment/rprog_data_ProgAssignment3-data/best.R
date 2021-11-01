# 2 Finding the best hospital in a state

#Load tidyr package to make use of replace_na function
library(tidyr)

state <- "TX"
outcome <- "heart attack"

best <- function(state, outcome){
  
  #First read in data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #Deal with case where state is invalid
  if(sum(data$State == state) == 0){
    stop("invalid state")
  }
  
  #Deal with case where outcome is invalid
  else if (!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))){
    stop("invalid outcome")
  }
  
  else 
  
  #Split the data into a list where each element is a dataframe containing the data for exactly one state and then filter by the specified state 
  x <- split(data, data$State)[[state]]
  
  #Set a column index for the specified outcome that will be used in a later calculation
  colIndex <- if (outcome == "heart attack") {
    11
  } else if (outcome == "heart failure") {
    17
  } else {
    23
  }
  
  #Coerce outcome values to numeric suppressing warning regarding NAs produced
  outcomeValues <- suppressWarnings(as.numeric(x[[colIndex]]))
  
  #Find the minimum value for the outcome/state combination, converting the data from character to numeric first and ignoring missing values. Note the coercion will produce missing values but this warning is suppressed
  minValue <- min(outcomeValues, na.rm = TRUE)
  
  #Create a logical vector for which hospitals match the minimum value. Again, the coercion will produce missing values but this warning is suppressed
  minLogical <- outcomeValues == minValue
  
  #Replace missing values in minLogical with FALSE to avoid sub-setting by them later
  minLogical2 <- replace_na(minLogical, FALSE)
  
  #Use the logical vector created above to filter by those Hospitals which meet the minimum value
  bestHospitals <- x$Hospital.Name[minLogical2] 
  
  #Ties are to be resolved alphabetically so sort the hospital names alphabetically and return the first name 
  sort(bestHospitals)[1]
}

best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")
