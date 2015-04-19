#Coursera: Data Science course: Getting and Cleanging Data
#This script is part of the assignment for the course project of the Getting
#and Cleaning Data course. For more information see: 
#https://www.coursera.org/course/getdata

#In order to be able to run this file you need to have the required files
#downloaded from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#extracted in the directory where the script resides.

#Part 0: Setup
#Setting up working directory to be able to access files.
setwd(dirname(sys.frame(1)$ofile))

#Part 1: Merging training and testing sets.

#First reading the x file in and appending training status (TRUE or FALSE),
#then reading in the two other files and appending data from them.
#@returns: a merged dataset
merge_x_y_subject_and_append_status <- function(x_file,
                                                 y_file,
                                                 subject_file,
                                                 training = TRUE) {
  #Read x_file and append training column with status from signature
  dt_x <- read.table(file = x_file)
  number_of_observations <- dim(dt_x)[1]
  dt_x <- cbind(dt_x, rep(training, number_of_observations))
  column_names <- colnames(dt_x)
  column_names[length(column_names)] <- "training"
  colnames(dt_x) <- column_names
  
  #Read y_file and subject file
  dt_y <- read.table(file = y_file)
  dt_subject <- read.table(file = subject_file)
  
  #Merge them
  dt <- cbind(dt_x, dt_y, dt_subject)
  
  return(dt)
}

dt_train <- merge_x_y_subject_and_append_status(x_file = "UCI HAR Dataset/train/X_train.txt",
                                    y_file = "UCI HAR Dataset/train/y_train.txt",
                                    subject_file = "UCI HAR Dataset/train/subject_train.txt",
                                    training = TRUE)
dt_test <- merge_x_y_subject_and_append_status(x_file = "UCI HAR Dataset/test/X_test.txt",
                                               y_file = "UCI HAR Dataset/test/y_test.txt",
                                               subject_file = "UCI HAR Dataset/test/subject_test.txt",
                                               training = FALSE)
#Merging and freeing up ram
dt <- rbind(dt_train, dt_test)
rm(list=c("dt_train", "dt_test"))

#Extracting measurements on the mean and standard deviation for each
#measurement

#Applying descriptive activity names

#Labeling the data set with descriptive variable names

#Creating a tidy data set with the average of each variable for each
#activity and each subject

#Temp
