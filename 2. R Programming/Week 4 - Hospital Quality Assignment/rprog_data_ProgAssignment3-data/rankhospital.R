state <- "TX"
outcome <- "heart failure"

rankhospital <-function(state, outcome, num){
  
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
    
  unsorted <- data.frame(x$Hospital.Name, outcomeValues)
  sorted <- unsorted[order(unsorted[,2], unsorted[,1]),]
  names(sorted) <- c("Hospital Name", "Rate")
  
  if(num == "best"){
    numIndex <- 1
  } else if (num == "worst"){
    numIndex <- sum(complete.cases(sorted))
  }
  else 
    numIndex <- num
  sorted$`Hospital Name`[numIndex]
}

rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)
