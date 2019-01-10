# Coursera - Getting and Cleaning Data - WEEK4  Assignment
# run_analysis.R code

# Assignment Descriptiont : 

# 1 - Download UCI HAR Datasets zipped file from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 2 - Unzip files in R Directory
# 3 - Read files in R
# 4 - Merges the training and the test sets to create one data set.
# 5 - Extracts only the measurements on the mean and standard deviation for each measurement.
# 6 - Uses descriptive activity names to name the activities in the data set
# 7 - Appropriately labels the data set with descriptive variable names.
# 8 From the data set in the previsou step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## 0 - SETTINGS
# Set environment to import the data
install.packages("dplyr")
library(dplyr)
setwd('~/Desktop/coursera/UCI HAR Dataset');

## 1 - READ FILES IN R
# 1.1 - Read training data sets 
# Training set
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
# Training labels
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
# Training subjets
Sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# 1.2 - Read testing data sets 
# Testing set
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
# Testing labels
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
# Training subjets
Sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# 1.3 - Read data description
features <- read.table("./UCI HAR Dataset/features.txt")

# 1.4 - Read activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# 2 - MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
# Merge X training & testing data sets
X_total <- rbind(X_train, X_test)
# Merge Y training and testing label data sets
Y_total <- rbind(Y_train, Y_test)
# Merge training & testing subjects data sets
Sub_total <- rbind(Sub_train, Sub_test)


# 3 - EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND THE STANDARD DEVIATION FOR EACH MEASUREMENT
# Select all the measurements correspinding to "mean" and "std" in the features data set
selected_measures <- features[grep("mean\\(\\)|std\\(\\)",features[,2]),]
# Select the "mean" and "std" observations from the merged dataset containing the observed measurements.
X_total <- X_total[,selected_measures[,1]]

# 4 - USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
# Rename variable from Y_total data label set
colnames(Y_total) <- "activity"
# Add the description of the activity added to the Y_total data label set
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))
# Keep only the activity label
activitylabel <- Y_total[,-1]

# 5 - APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES 
# Rename the variables with their correct "mean" or "std" labels
colnames(X_total) <- features[selected_measures[,1],2]

# 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(Sub_total) <- "subject"
total <- cbind(X_total, activitylabel, Sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_all(funs(mean))
write.table(total_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)