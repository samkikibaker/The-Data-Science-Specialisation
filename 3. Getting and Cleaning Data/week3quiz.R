# Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "American Communities Survey 3.csv")
data <- read.csv("American Communities Survey 3.csv", header = TRUE)
agricultureLogical <- data$ACR == 3 & data$AGS == 6
which(agricultureLogical)

# Question 2 
library(jpeg)
pic <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(pic, destfile = "Instructor.jpg", mode = "wb")
picData <- readJPEG("Instructor.jpg", native = TRUE)
quantile(picData, probs = c(0.3, 0.8))

# Question 3 
library(dplyr)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url2, destfile = "GDP.csv")
data <- read.csv("GDP.csv", skip = 4, nrows = 190, col.names = c("CountryCode", "Ranking", "col3", "Country", "GDP", "col5", "col6", "col7", "col8", "col9"))
GDP <- suppressWarnings(select(data, CountryCode, Ranking, Country, GDP) %>% 
  mutate(across(c(Ranking), as.numeric)))


url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url3, destfile = "Education.csv")
Education <- read.csv("Education.csv", header = TRUE)

combined <- merge(GDP, Education) %>%
  filter(!is.na(Ranking))
length(combined$Ranking)

sorted <- arrange(combined, desc(Ranking))
sorted$Country[13]

# Question 4
# Can be done with tapply or dplyr
tapply(combined$Ranking, combined$Income.Group, mean)

group_by(combined, Income.Group) %>% summarise(mean(Ranking))

# Question 5
cut(combined$Ranking, breaks = quantile(combined$Ranking, probs = seq(0, 1, 0.2))) %>%
  table(combined$Income.Group)
# Make sure to take lowest ranking group which corresponds to highest GDP






