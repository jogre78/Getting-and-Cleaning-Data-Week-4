# Getting-and-Cleaning-Data-Week-4
Week 4 Programming Assignment

This repo was created as per the Assignment of the 4th week of Getting and Cleaning Data course.

First download the zip file and unzip it in the R working directory.
Then, download the R source code in the R working directory
Finally, submit the R source code in order to create the tidy data set.

DATA DESCRIPTION :

There are 2 decodes data sets : features.txt and activity_labels.txt
And 2 sets of data : 1 set of training data and 1 set of test data.
Within a set of data there are :

- The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. 
- The variable in the data Y indicates activity type the subjects performed during recording.
- The variable in the data subject indicates which subject performs which set (either training or test)

CODE EXPLANATION :

- the source code combines the training and test data sets.
- it selects the mean and standard deviation variables.
- it creates a new data set which summarises these variables for each combination of subject and activity types.

NEW DATA : 

- The tidy data set contains mean and standard deviation variables for each combination of subjects and activity types.

Based on the assigment's instruction, the R source code does :

A) Read training and test data sets in the R environment
B) Read variables names in the R environment
C) Read subject index in the R environment

Once all the data sets have been read, it :

1) Merges the training and the test sets to create one data set.
    => using rbind to combine the data sets
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
    => using grep to select "mean" and "std" variables from the features set.
3) Uses descriptive activity names to name the activities in the data set. 
    => converting activity labels to characters using as.characters and create a new column as factor with colnames
4) Appropriately labels the data set with descriptive variable names.
    => renaming the variables columns using the liste of selected descriptive names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  -> using pipline, group_by and summarise_all to create the tidy data set 
