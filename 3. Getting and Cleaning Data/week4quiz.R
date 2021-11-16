# Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "American Communities Survey 4.csv")
data <- read.csv("American Communities Survey 4.csv", header = TRUE)
strsplit(names(data), "wgtp")[[123]]

# Question 2
library(dplyr)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url2, destfile = "GDP.csv")
data <- read.csv("GDP.csv", skip = 4, nrows = 190, col.names = c("CountryCode", "Ranking", "col3", "Country", "GDP", "col5", "col6", "col7", "col8", "col9"))
GDP <- suppressWarnings(select(data, CountryCode, Ranking, Country, GDP)) %>%
        filter(!(GDP == "" | GDP == ".."))
avgGDP <- gsub(",", "", GDP$GDP) %>%
        as.numeric() %>%
        mean()
avgGDP

# Question 3


# Question 4
url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url3, destfile = "Education.csv")
Education <- read.csv("Education.csv", header = TRUE)

combined <- merge(GDP, Education) %>%
  filter(!is.na(Ranking))
sum(grepl("*Fiscal year end: June*", combined$Special.Notes))

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)
sum(year(sampleTimes) == 2012)
sum(weekdays(sampleTimes) == "Monday" & year(sampleTimes) == 2012)
