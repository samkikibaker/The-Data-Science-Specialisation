url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "American Communities Survey.csv", method = "curl")
data <- read.csv("American Communities Survey.csv", header = TRUE)

sum(data$VAL == 24, na.rm = TRUE)


library(xlsx)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url2, destfile = "Natural Gas Acquisition Program.xlsx", method = "curl")

dat <- read.xlsx("Natural Gas Acquisition Program.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

library(XML)
url3<- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(url3, destfile = "restaurants.xml")
restaurants <- xmlTreeParse("restaurants.xml", useInternalNodes = TRUE)
zipcodes <- xpathSApply(restaurants, "//zipcode", xmlValue)
sum(zipcodes == "21231")

library(data.table)
url4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url4, destfile = "USCommunities.csv")
DT <- fread(file = "USCommunities.csv")

                 
#Trick question, this is the only option that uses the data.table package
system.time(DT[,mean(pwgtp15), by = SEX])
