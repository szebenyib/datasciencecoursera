General
=======

This codebook is a supplementary material that contains information
about the dataset that we needed to clean for further analysis.
It was the course project for the Coursera course "Getting and Cleaning Data".

The data
========

The data is collected from the sensors of mobile phones during six
different activities that were performed by thirty individuals. The
original dataset is available from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Compared to the original dataset this tidy data set holds all
variables in one single R data table with human readable activities,
identifier of the subject and an identifier whether the record
belongs to the training or the testing part of the original dataset.
Only those variables were selected which contain mean or standard
deviation info, the other columns of the original dataset were
discarded.

The variables
=============

All variables are stored in their separate columns with one record
per row. The variables are named to include a reference to their
content.

The collected sensor data stem from the smoothed versions of the
original dataset. To obtain a full list of the variables either
consult the original documentation or run `rownames(dt)` on the
tidy dataset. They were not included in this file for their sheer
size.

Besides the sensor variables you may find three additional
variables:
- `activityType`: the type of the activity - human readable form
- `subject`: the subject's id who performed the activity
- `isTraining`: TRUE if the record was in the training dataset in
  the original data source and FALSE if the record belonged to the
testing observations

Transformations applied to obtain the tidy data set.
====================================================

To obtain the tidy data set training source files were loaded into the
memory. Then the descriptive activity names were obtained by merging
that dataset by the unque identifiers of the records (V1 variable).
The next step was to append the subject and training flag. These
were not merged but simply appended as they were in an ideal form.
The same was done for the testing data set, then the two were simply
appended together. In the end only those sensor columns were retained that
held mean and standard deviation data of the sensors.
