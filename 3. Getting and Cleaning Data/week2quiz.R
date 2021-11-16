# Question 1
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url

#    Replace your key and secret below:
myapp <- oauth_app("github", key = "79ee9c2ea3f1652189b0", secret = "0937636d82ef0543b80029466497db9aef4b9fb4")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
data <- content(req)


#Create index for which repo has name datasharing
index <- which(sapply(data, function(x) x$name == "datasharing"))

#Extract date created from datasharing repo
data[[index]]$created_at


# Question 2 
install.packages("sqldf")
library(sqldf)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, destfile = "American Communities Survey 2.csv" )
acs <- read.csv("American Communities Survey 2.csv", header = TRUE)
sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 3 
sqldf("select distinct AGEP from acs")

# Question 4 
library(XML)
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con)
sapply(html, nchar)[c(10, 20, 30, 100)]

# Question 5 
library(utils)
url <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
data <- read.fwf(url, widths = c(10, rep(c(9,4), 4)), skip = 4)
names(data) <- c("week","nino1and2sst","nino1and2ssta","nino3sst", "nino3ssta","nino34sst","nino34ssta", "nino4sst","nino4ssta")
sum(data[[4]])







     