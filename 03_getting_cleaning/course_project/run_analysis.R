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
  #Read the files
  dt_x <- read.table(file = x_file)
  dt_y_id <- read.table(file = y_file)
  dt_y_name <- read.table(file = "UCI HAR Dataset//activity_labels.txt")
  dt_subject <- read.table(file = subject_file)
  
  #Part 3: applying descriptive activity names
  #Use activity names instead of ids
  dt_y <- merge(x = dt_y_id, y = dt_y_name, by.x = "V1", by.y = "V1")
  dt_y <- dt_y[2]
  
  #Merge them
  dt <- cbind(dt_x, dt_y, dt_subject)

  #Add training info column
  dt <- cbind(dt, rep(training, dim(dt)[1]))
  
  #Part 4: Labeling the data set with descriptive variable names
  #Add column names
  cnames <- read.table("UCI HAR Dataset//features.txt",
                       stringsAsFactors = FALSE)
  colnames(dt) <- c(unlist(cnames[2]), "activityType", "subject", "isTraining")
  
  return(dt)
}

dt_train <- merge_x_y_subject_and_append_status(x_file = "UCI HAR Dataset//train//X_train.txt",
                                    y_file = "UCI HAR Dataset//train//y_train.txt",
                                    subject_file = "UCI HAR Dataset//train//subject_train.txt",
                                    training = TRUE)
dt_test <- merge_x_y_subject_and_append_status(x_file = "UCI HAR Dataset//test//X_test.txt",
                                               y_file = "UCI HAR Dataset//test//y_test.txt",
                                               subject_file = "UCI HAR Dataset//test//subject_test.txt",
                                               training = FALSE)
#Merging and freeing up ram
dt <- rbind(dt_train, dt_test)
rm(list=c("dt_train", "dt_test"))

#Part 2 :Extracting measurements on the mean and standard deviation for each
#measurement

cnames <- colnames(dt)
means <- grepl("mean", cnames)
stds <- grepl("std", cnames)
#If any of them are TRUE, mark them as TRUE
both <- means | stds

dt <- cbind(dt[both], dt$activityType, dt$subject, dt$isTraining)

#Part 5 : Creating a tidy data set with the average of
#each variable for each activity and each subject
ncolumns <- dim(dt)[2] - 3 #last three are not sensor data
cnames <- colnames(dt)
desc <- NULL
dimnames <- tapply(X = unlist(dt[1]),
                   INDEX = list(unlist(dt[80]),
                                unlist(dt[81])),
                   FUN = mean)
for (i in 1:ncolumns) {
  desc <- cbind(desc, 
                c(unlist(tapply(X = unlist(dt[i]),
                                INDEX = list(unlist(dt[80]),
                                             unlist(dt[81])),
                                FUN = mean)
                         ),
                  unlist(tapply(X = unlist(dt[i]),
                                INDEX = list(unlist(dt[80]),
                                             unlist(dt[81])),
                                FUN = sd)
                         )
                  )
                )
}
#Rename the rows
rnames <- rownames(desc)
for (i in 1:12) {
  if (i <= 6) {
    rnames[i] <- paste("MEAN_", rnames[i], sep="")
  } else {
    rnames[i] <- paste("SD_", rnames[i], sep="")
  }
}
#rownames(desc) <- rnames
#Rename the columns
colnames(desc) <- cnames[1:79]