corr <- function(directory, threshold = 0){
        fileNames <- list.files(directory) #List files in directory
        filePaths <- paste(getwd(), "/", directory, "/", fileNames, sep="") #Generate file paths from file names
        data <- lapply(filePaths, read.csv) #Read in data
        completeCases <- sapply(lapply(data, complete.cases), sum) #Count the number of complete cases for each monitor location
        thresholdIndex <- completeCases >= threshold #Create logical for which monitor locations meet the threshold for complete cases
        dataThreshold <- data[thresholdIndex] #Subset data by only those monitor locations which meet the threshold for complete cases
        correlations = NULL
        if(sum(thresholdIndex) == 0){
                correlations <- numeric() #Deal with case where no monitors meet the threshold requirement
        }
        else {
                for(i in 1:sum(thresholdIndex)){ #For each monitor location that meets the threshold requirement
                        cases <- complete.cases(dataThreshold[[i]]) #Create a logical for complete cases 
                        sulfateValues <- dataThreshold[[i]]$sulfate[cases] #Subset the monitor location's sulfate values by only those that have complete cases 
                        nitrateValues <- dataThreshold[[i]]$nitrate[cases] #Do the same for nitrate
                        correlations[i] <- cor(sulfateValues, nitrateValues) #Calculate the correlation for sulfate and nitrate values
                }
                 
        }
        correlations 
}

cr <- corr("specdata", 150)
head(cr)
summary(cr)
cr <- corr("specdata", 400)
head(cr)
summary(cr)
cr <- corr("specdata", 5000)
summary(cr)
length(cr)
cr <- corr("specdata")
summary(cr)
length(cr)
