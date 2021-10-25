complete <- function(directory, id = 1:332){
        fileNames <- list.files(directory)[id] #List files in directory
        filePaths <- paste(getwd(), "/", directory, "/", fileNames, sep="") #Generate file paths from file names
        data <- lapply(filePaths, read.csv) #Read in data
        completeCases <- lapply(data, complete.cases) #Produce logical for complete cases
        completeCasesNumber <- cbind(id, data.frame(sapply(completeCases, sum))) #Count complete cases and create data frame with id numbers
        colnames(completeCasesNumber) <- c("id", "nobs") #Rename columns
        completeCasesNumber
}

complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)
