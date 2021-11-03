outcome <- "heart attack"
num <- 20

rankall <-function(outcome, num = "best"){
  
  #First read in data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #Deal with case where outcome is invalid
  if (!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))){
    stop("invalid outcome")
  }
  
  else
    
    #Build a function that takes a data frame (corresponding to a single state) and extracts the Hospital of the given rank and outcome
    rank <- function(x, outcome, num){
      
      #Set a column index for the specified outcome that will be used in a later calculation
      colIndex <- if (outcome == "heart attack") {
        11
      } else if (outcome == "heart failure") {
        17
      } else {
        23
      }
      
      #Filter the data down to just the Hospital Name, State, and Outcome Rate
      filtered <- data.frame(Hospital = x[, 2], State = x[, 7], Rate = suppressWarnings(as.numeric(x[, colIndex])))
      
      #Sort this data frame by outcome rate, breaking ties by hospital name
      sorted <- filtered[order(filtered$Rate, filtered$Hospital),]
      
      #Create numIndex which deals with the cases when num is "best" or "worst". Note that in the case num = "worst" we want to extract the last non-missing rate value after the data has been sorted by rate 
      numIndex <- if (num == "best") {
        1
      } else if (num == "worst"){
        sum(!is.na(sorted$Rate))
      } else {
        numIndex <- num
      }
      
      #Extract the Hospital name of the required rank and put it in a data frame with the state name 
      ranked <- data.frame(Hospital = sorted$Hospital[numIndex], State = sorted$State[1])
      ranked
    }
  
  #Split the data into a list where each element correspond to exactly one state
  byState <- split(data, data$State)
  
  #Apply the above function to each member of the list to extract the Hospital of the given rank for each state
  z <- lapply(byState, FUN = rank, outcome = outcome, num = num)
  
  #Combine the results into a single data frame and output this
  do.call(rbind, z)
}

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)
