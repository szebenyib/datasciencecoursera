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

Data set for questions 1, 2, 3, 4 (not uploaded)
------------------------------------------------

Compared to the original dataset this tidy data set holds all
variables in one single R data table with human readable activities,
identifier of the subject and an identifier whether the record
belongs to the training or the testing part of the original dataset.
Only those variables were selected which contain mean or standard
deviation info, the other columns of the original dataset were
discarded.

To load the data set use:
"data <- read.table("step1234_data_set.txt", header=TRUE)"

Data set for question 5 (the uploaded data set)
-----------------------------------------------

This data set contains the average for each activity type for each person
per variable. It consists of four variables that are discussed below
in the variables section.
Please note that the exercise did not request separate average for
the training and testing data set so all records were treated alike
and together. I have also included all NA values and did not drop
them as it would have meant a loss of information value which might
be needed in further analyses.

To load the data set use:
"data <- read.table("step5_data_set.txt", header=TRUE)"

The variables
=============

All variables are in the unit of their origin as it is described in the
documentation of the original files. All other variables added by the
script are detailed below and do not have units that would need a
scale indication of measure (e.g. ther is no: mm - cm - dm - m -km).

Data set for questions 1, 2, 3, 4 (not uploaded)
------------------------------------------------

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

Data set for question 5 (the uploaded data set)
-----------------------------------------------

- `activityType`: the type of the activity - human readable form
- `subject`: the subject's id who performed the activity
- `averageOfVariable`: the average of the variable
- `variableName`: the name of the variable which has its average
  listed in the `averageOfVariable` field

Transformations applied to obtain the tidy data set.
====================================================

Data set for questions 1, 2, 3, 4 (not uploaded)
------------------------------------------------

To obtain the tidy data set training source files were loaded into the
memory. Then the descriptive activity names were obtained by merging
that dataset by the unque identifiers of the records (V1 variable).
The next step was to append the subject and training flag. These
were not merged but simply appended as they were in an ideal form.
The same was done for the testing data set, then the two were simply
appended together. In the end only those sensor columns were retained that
held mean and standard deviation data of the sensors.

Data set for question 5 (the uploaded data set)
-----------------------------------------------

The data set created for question 5 is based on the cleaned data set
of the previous section. For all the variables an average is
calculated per subject per activity type. The calculated matrix is
then transformed into a dataframe which is then reshaped and
labeled.
