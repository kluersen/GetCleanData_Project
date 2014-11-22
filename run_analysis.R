# Course: Getting and Cleaning Data
# Project: Project1
# Assignment:
#             You should create one R script called run_analysis.R that does the following. 
#               1.  Merges the training and the test sets to create one data set.
#               2.  Extracts only the measurements on the mean and standard deviation for 
#                   each measurement. 
#               3.  Uses descriptive activity names to name the activities in the data set.
#               4.  Appropriately labels the data set with descriptive variable names. 
#               5.  From the data set in step 4, creates a second, independent tidy data set 
#                   with the average of each variable for each activity and each subject.


## First, assuming that the root of the data starts in our working directory, 
## lets read our data in.

features <- read.table("features.txt")
actLabels <- read.table("activity_labels.txt")
testLabels <- read.table("test/y_test.txt")
testData <- read.table("test/x_test.txt")
testSubject <- read.table("test/subject_test.txt")
trainLabels <- read.table("train/y_train.txt")
trainData <- read.table("train/x_train.txt")
trainSubject <- read.table("train/subject_train.txt")

## Next, we need to inspect our data. After looking at the data, I find two things wrong with it.
## 1. There are duplicated labels as shown here:

sum(duplicated(features[,2]))>0

##    I will therefore remove the duplications when filtering out unwanted data.
##
## 2) The variable labels are not R freindly.  I can either substitute them or not use them
##    outside of their string name. - I will not use them outside their string name.

## Next, to make this easier I will do the above Assignmentsteps out of order.

## First things first, lets add the labels to our variables

##---- 4.Appropriately label the data set with descriptive variable names.

names(testData)<-features[,2]
names(trainData)<-features[,2]
names(testLabels)<-"Activity"
names(trainLabels)<-"Activity"
names(testSubject)<-"Volunteer"
names(trainSubject)<-"Volunteer"

##---- 3.  Uses descriptive activity names to name the activities in the data set.

##  This is easily done using the activity labels.  just substitute them in

testLabels$Activity<-as.character(testLabels$Activity)
trainLabels$Activity<-as.character(trainLabels$Activity)
for (i in 1:dim(actLabels)[1]){
  testLabels$Activity[testLabels$Activity==as.character(i)]<-as.character(actLabels$V2[i])
  trainLabels$Activity[trainLabels$Activity==as.character(i)]<-as.character(actLabels$V2[i])}

##---- 1. Merges the training and the test sets to create one data set.

## First,  merge the subject and the label tables to the test and train data tables

testData<-cbind(testSubject,cbind(testLabels,testData))
trainData<-cbind(trainSubject,cbind(trainLabels,trainData))

## Now merge test and train together

mergedData<-rbind(testData,trainData)

##---- 2.  Extract only the mean and standard deviation measurements. 

##    Three things to note here:
##      1.  The variable names contain illegal R names. - I will unly use their string names in 
##          my program.
##
##      2.  Their are duplicated variable names. - I will drop them using the duplicated() 
##          function.
##
##      3.  What is meant by standard deviation and mean values in the variable name? - I will
##          use anything labeled "-mean()' or "-std()" as my key for filtering.         

require(dplyr)
mergedData<-mergedData[,!duplicated(names(mergedData))]
mergedData<-select(mergedData,Volunteer,Activity,contains("-mean()"),contains("-std()"))

##---- 5.  From the data set in step 4, creates a second, independent tidy data set 
#               with the average of each variable for each activity and each subject.

## To do this, I need to reshape my data frame so that the variables are columnized 
## with a value column

require(reshape2)
tidyData<-melt(mergedData,id=c("Volunteer","Activity"))

## Now let's group and average the values.

tidyData<-group_by(tidyData,Volunteer,Activity,variable)%>%
          summarize(Average=mean(value))

## To finilize this effort, lets write this table to a file

write.table(tidyData, file="project_tidyData.txt",row.names=FALSE)


