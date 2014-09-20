##You should create one R script called run_analysis.R that does the following:
  
library(plyr)

setwd("C:/Users/olivem/Desktop/Data Science Course/3.Getting and Cleaning Data/Course Project")

#Function to 1.Merges the training and the test sets to create one data set.
fMerge = function()
{

training.x <- read.table("UCI HAR Dataset/train/X_train.txt")
test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
merged.x <- rbind(training.x, test.x)

training.y <- read.table("UCI HAR Dataset/train/y_train.txt")
test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
merged.y <- rbind(training.y, test.y)

training.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
merged.subject <- rbind(training.subject, test.subject)

list(x=merged.x, y=merged.y, subject=merged.subject)
}

merged <- fMerge()

#Function to 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
fExtractMeanStdDev = function(df)
{
features <- read.table("UCI HAR Dataset/features.txt")
mean <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
sd <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
edf <- df[, (mean | sd)]
colnames(edf) <- features[(mean | sd), 2]
edf
}

cx <- fExtractMeanStdDev(merged$x)

#Function to 3.Uses descriptive activity names to name the activities in the data set
fActivityNames = function(df)
{
colnames(df) <- "activity"
df$activity[df$activity == 1] = "WALKING"
df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
df$activity[df$activity == 4] = "SITTING"
df$activity[df$activity == 5] = "STANDING"
df$activity[df$activity == 6] = "LAYING"
df
}

cy <- fActivityNames(merged$y)

colnames(merged$subject) <- c("subject")

#Function to 4.Appropriately labels the data set with descriptive variable names
fLabel <- function(x, y, subjects) 
{
cbind(x, y, subjects)
}

combined <- fLabel(cx, cy, merged$subject)

#Function to 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
fTidyDataset = function(df)
{
tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))
tidy
}

tidy <- fTidyDataset(combined)

write.table(tidy, "TidyDataSet.txt", row.names=FALSE)

