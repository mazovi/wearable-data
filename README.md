#Getting and Cleaning Wearable Data

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This repo includes: 1) a tidy data set (result.txt) as described by CodeBook.md, 2) a code book (CodeBook.md) that describes the variables, the data, and any transformations or work that  performed to clean up the data, (3) a r script file (run_analysis.R), and (4) This README.md file.

#About the Raw Data

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Explanation about the Script

run_analysis.R cleans up the raw data in following steps:

* Loading required package: we need join, ddply methods from package plyr and melt, dcast methods from reshape2 package;
* Reading raw data by read.table method;
* Using cbind method to merge the test and train data to the corresponding subject and activity id;
* Using rbind method to merge the test and train data (both have the same column structures);
* Renaming columns of the data set to more understandable names by direct assigning;
* Using join method to lookup activity name by activity id;
* Applying regular expression and grepl method to remove all the undesired columns;
* Using melt method to restructure the data set;
* Averaging all the value group by subjectid and activityname with ddply method;
* Calling dcast method to unmelt the data set back to original structure;
* Writing the result to a flat file (result.txt).
