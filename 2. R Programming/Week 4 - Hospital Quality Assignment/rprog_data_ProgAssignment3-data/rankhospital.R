state <- "TX"
outcome <- "heart failure"

rankhospital <-function(state, outcome, num = "best"){
  
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
  
  #Create a data frame of hospital names and outcome rates  
  unsorted <- data.frame(Hospital = x$Hospital.Name, Rate = outcomeValues)
  
  #Sort this data frame by outcome rate breaking ties by hospitl name alphabetically. Also rename columns
  sorted <- unsorted[order(unsorted$Rate, unsorted$Hospital),]
  names(sorted) <- c("Hospital", "Rate")
  
  #Create numIndex which deals with the cases when num is "best" or "worst". Note that in the case num = "worst" we want to extract the last non-missing rate value after the data has been sorted by rate 
  numIndex <- if (num == "best") {
    1
  } else if (num == "worst"){
    sum(!is.na(sorted$Rate))
  } else {
    numIndex <- num
  }
  
 #Output hospital name of required rank 
  sorted$`Hospital`[numIndex]
}

rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)
