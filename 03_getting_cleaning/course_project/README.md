How the run_analysis.R script works
===================================

*Note: the script is well commented, for more details please check
the source code.*

The script begins with a setup part that sets up the working
directory so that when it is invoked it can look up the raw data
that is downloaded and in an extracted from the location introduced
in the CodeBook.md. Necessary libraries are also loaded at this
point.

To solve **question 1** there is a `merge_x_y_subject_and_append_status`
function defined that takes three files and a boolean value as
arguments. I have decided to use a function to avoid duplicate
coding as the same job has to be done both for the training and the
testing data set.

This function reads in the x file (the measurements),
the y file (the activities) and the subject file (who has done the
activity). As for **question 3** there is also another file
loaded that contains the activity names, this was not included
as an argument but hardcoded in the function.

The activities' names are obtained via the merge function where the
files are merged on the ids. The three files' contents are otherwise
simply appended to each other. The script also appends the training
status in a separate variable to indicate where the data comes from
as it may come handy in further analysis and I did not want to lose
this kind of information.

To name the data set with descriptive names column names were read
from the features.txt for **question 4**.

The function is applied to both the training and the testing samples
and the two samples are put in one data table, while the no longer
needed objects are removed to free up ram.

To extract measurements on the mean and standard deviation it was
necessary to find those variables that had 'mean' or 'std' in their
names. A vector was created to indicate that only those variables
were to be retained that were either mean or std. Having found those
columns "step1234_data_set.txt" is created with the tidy data set
without row names.

As for **question 5** the script iterates over the columns that need
the calculation and takes the mean per variable for each subject and
activity type. A matrix is created as a result that is later on
transformed into a dataframe. Row names are put in the data frame
which is later melted to include the activity name and subject id in
separate variables. An additional column is added based on the name
of which original variable the results belong to. This way four
variables exist in the end as described in the CodeBook.md file. One
could have crunched these together into embedded structures but this
way it can be cleanly exported, understood and used. The resulted
data frame is exported as "step5_data_set.txt" without row names.

