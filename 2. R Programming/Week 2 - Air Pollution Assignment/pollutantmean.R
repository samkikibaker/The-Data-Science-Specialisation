pollutantmean <- function(directory, pollutant, id = 1:332){
  fileNames <- list.files(directory)[id] #List files in directory
  filePaths <- paste(getwd(), "/", directory, "/", fileNames, sep="") #Generate file paths from file names
  data <- lapply(filePaths, read.csv) #Read in data
  pollutantindex <- if(pollutant == "sulfate"){2}else{3} #Create index for use in sub-setting
  x <- NULL
  for(i in 1:length(id)){
    x <- rbind(x, data[[i]][pollutantindex])
  } #Create dataframe of pollutant values
  mean(x[[1]], na.rm = TRUE) #Take mean ignoring missing values
}

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)



