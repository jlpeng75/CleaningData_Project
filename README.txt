==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Original data are from:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================


Data Cleaning Steps:
=========================================

- read the X_train and y-train data and subject information for training dataset
- colum bind to create traing dataset
- create a new column Source to indicate the observed data are from training data
- read the X-test and y_test data and subject information for testing dataset
- colum bind to create testing dataset
- create a new column Source to indicate the observed data are from test data
- row bind training and testing set to form entire data set

- read features.txt and find the index which contains "mean" and "std" using regular expression
- subset the feature name using index
- subset the entire dataset using column index, wchich contains "mean" and "std"
- set column names of entire data set

- read the activity data 
- merge Activity data with Entire dataset by column "Activity"
- using gather function to reshape dataset to long format.
- summarise data with mean function for each Subject, Measure_type and Activity




The dataset includes the following files:
=========================================

- 'README.txt'

- 'Final.txt': Shows combined data set.

- 'Final_Average.txt': summarised data set for each each Subject, measure_type and Activity.

