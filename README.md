# getting-and-cleaning-data
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

Download the dataset in the working directory,unzip it
Loads both the training and test datasets
Load the activity and feature info
assign the columns names
Merges the train and test datasets
extract those columns which reflect a mean or standard deviation
uses descriptive activity names to name the activities in the data set
and labels the data set with descriptive variable names
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair
The end result is shown in the file tidy.txt