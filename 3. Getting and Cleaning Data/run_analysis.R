# 561 features (i.e. variables) listed in features.txt with full details of how they were obtained in features_info.txt

# 1. Merges the training and the test sets to create one data set.

#### How do I download and read from the .zip??????
traindata <- read.table("./train/X_train.txt")
trainlabels <- read.table("./train/y_train.txt")
trainsubject <- read.table("./train/subject_train.txt")
train <- cbind(trainlabels, trainsubject, traindata)

testdata <- read.table("./test/X_test.txt")
testlabels <- read.table("./test/y_test.txt")
testsubject <- read.table("./test/subject_test.txt")
test <- cbind(testlabels, testsubject, testdata)

data <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- c("Activity", "Subject", read.table("./features.txt")[,2])
keep <- grepl("Activity|Subject|*mean|*std", features)
data <- data[, keep]

# 3. Uses descriptive activity names to name the activities in the data set
data <- data %>% mutate(V1 = as.factor(V1))
levels(data$V1) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# 4. Appropriately labels the data set with descriptive variable names. 
names(data) <- features[keep]

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data2 <- melt(data, id.vars=c("Activity", "Subject"))



