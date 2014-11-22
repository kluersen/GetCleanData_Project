---
title: "project_tidyData_Code_Book"
author: "kluersen"
date: "Saturday, November 22, 2014"
output: html_document
---

##Purpose

This code book describes the variables, the data, and any transformations or work that I performed to clean up the Human Activity Recognition Using Smartphones Dataset.

## Variables

For each record I provided:

-Volunteer: An identifier of the subject who carried out the experiment (Range: 1-30).

-Activity:  One of the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) performed by the volunteer.

-variable: One of the original 561-feature vectors with time and frequency domain variables. Only the "-std()" and "-mean()" variables were kept for this data set (total # kept:68).

-Average: The mean of the values associated with volunter, activity, and variable of the original data set. Since they were originally normalized, the range is between -1 and 1.

## Data

All data used is from the Human Activity Recognition Using Smartphones Dataset.  This data was gathered and organized by volunteer, activity and the std/mean variables of the original data set, then the corresponding variable values were averaged.

## Transformation

Here are the notes of how I transformed the data.  It is a compilation of the comments from my R code.

 Course: Getting and Cleaning Data
 Project: Project1
 Assignment:
             You should create one R script called run_analysis.R that does the following. 
               1.  Merges the training and the test sets to create one data set.
               2.  Extracts only the measurements on the mean and standard deviation for 
                   each measurement. 
               3.  Uses descriptive activity names to name the activities in the data set.
               4.  Appropriately labels the data set with descriptive variable names. 
               5.  From the data set in step 4, creates a second, independent tidy data set 
                   with the average of each variable for each activity and each subject.

First, assuming that the root of the data starts in our working directory, lets read our data in.
Next, we need to inspect our data. After looking at the data, I find two things wrong with it.

1. There are duplicated labels - I will therefore remove the duplications when filtering out unwanted data.

2. The variable labels are not R freindly.  I can either substitute them or not use them outside of their string name. - I will not use them outside their string name.

Next, to make this easier I will do the above Assignmentsteps out of order.

First things first, lets add the labels to our variables

---- 4.Appropriately label the data set with descriptive variable names. - I used the labels supplied by nameing the columns

---- 3.  Uses descriptive activity names to name the activities in the data set. - This is easily done using the activity labels just substitute them in.

---- 1. Merges the training and the test sets to create one data set. First, merge the subject and the label tables to the test and train data tables. Now merge test and train tables together

---- 2.  Extract only the mean and standard deviation measurements. 

         Three things to note here:
            1.  The variable names contain illegal R names. - I will unly use their string names in my program.

            2.  Their are duplicated variable names. - I will drop them using the duplicated() function.

            3.  What is meant by standard deviation and mean values in the variable name? - I will use anything labeled "-mean()' or "-std()" as my key for filtering.

---- 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. To do this, I need to reshape my data frame so that the variables are columnized with a value column, then group and average the values. To finilize this effort, the tidy data file was generated.





