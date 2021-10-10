# Week 1 Quiz 

# Use the Week 1 Quiz Data Set to answer questions 11-20.

x <- read.csv("hw1_data.csv", ) # First load the dataset

# 11. In the dataset provided for this Quiz, what are the column names of the dataset? 
colnames(x) # The function colnames() extract column names from a dataframe

# 12. Extract the first 2 rows of the data frame and print them to the console. What does the output look like?
head(x, n = 2)

# 13. How many observations (i.e. rows) are in this data frame?
dim(x)[1] # dim gives a vector of length 2 with the number of rows and columns 

# 14. Extract the last 2 rows of the data frame and print them to the console. What does the output look like?
tail(x, n = 2)

# 15. What is the value of Ozone in the 47th row?
x$Ozone[47]

# 16. How many missing values are in the Ozone column of this data frame?
missingOzone <- is.na(x$Ozone) # create a logical vector for ozone NA values
sum(missingOzone) # sum treats logical as numeric with FALSE = 0 and TRUE = 1

# 17. What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.
OzoneValues <- x$Ozone[!missingOzone] # remove missing value from Ozone
mean(OzoneValues)

# 18. Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
library(tidyverse) # The package tidyverse has an easy function filter to perform this task
xfiltered <- filter(x, x$Ozone > 31, x$Temp > 90) # Filter by the required conditions
mean(xfiltered$Solar.R) #No missing values so can take mean

# 19. What is the mean of "Temp" when "Month" is equal to 6? 
xfiltered2 <- filter(x, x$Month == 6) # Filter by required conditions
mean(xfiltered2$Temp) # No missing values so can take mean

# 20. What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?
xfiltered3 <- filter(x, x$Month == 5) # Filter by required conditions
OzoneNAMay <- is.na(xfiltered3$Ozone) # Find missing Ozone values in May
OzoneValuesMay <- xfiltered3$Ozone[!OzoneNAMay] # Remove missing values from Ozone in May
max(OzoneValuesMay) 
