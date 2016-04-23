#loading required package
#package plyr for the join and ddply methods
#package reshape for the melt and dcast methods
library(plyr)
library(reshape2)

#reading raw data
#data frame activities for the activity lookup table
#data frame features for the features lookup table
#data farme test for the test data (features values)
#data frame test_activity for the test data corresponding activitiy id
#data frame test_subject for the test data corresponding subject id
#data farme train for the train data (features values)
#data frame train_activity for the train data corresponding activitiy id
#data frame train_subject for the train data corresponding subject id
activities <- read.table("activity_labels.txt")
features <- read.table("features.txt")
test <- read.table("test/X_test.txt")
train <- read.table("train/X_train.txt")
test_activity <- read.table("test/y_test.txt")
train_activity <- read.table("train/y_train.txt")
test_subject <- read.table("test/subject_test.txt")
train_subject <- read.table("train/subject_train.txt")

#using cbind method to merge the test and train data to the corresponding subject and activity id  
test <- cbind(test_subject, test_activity, test)
train <- cbind(train_subject, train_activity, train)

#using rbind method to merge the test and train data (both have the same column structures)
all <- rbind(test, train)

#renaming columns of the data set to more understandable name
names(all) <- c("subjectid", "activityid", as.character(features$V2))
names(activities) <- c("activityid", "activityname")

#using join method to lookup activity name by activity id
all <- join(all, activities, by="activityid")
all$activityid <- NULL

#applying regular expression and grepl method to remove all the undesired columns
#we only want subjectid, activityname and all the mean and standard deviation for each measurement
all_extracted <- all[, grepl("subjectid|activityname|mean()|std()", names(all))]

#using melt method to restruct the data set
#moving all the columns except subjectid and activityname to row and identified by variable value 
molten <- melt(all_extracted, id.vars=c("subjectid", "activityname"))
#averaging all the value group by subjectid and activityname by ddply method
temp <- ddply(molten, .(subjectid, activityname, variable), summarise, value=mean(value))
#calling dcast method to unmelt the data set back to original structure
result <- dcast(temp, formula=subjectid + activityname ~ variable)

#writing the result to a flat file (result.txt)
write.table(result, file="result.txt", row.names=FALSE)